package com.su.vx.utils;

import android.content.Context;
import android.text.TextUtils;
import android.util.Log;
import android.widget.Toast;

import com.su.vx.callback.EmptyCallback;
import com.su.vx.callback.LoginUserCallback;
import com.su.vx.callback.QueryCallback;
import com.su.vx.callback.QueryListCallback;
import com.su.vx.callback.QueryUserCallback;
import com.su.vx.callback.RegisterUserCallback;
import com.su.vx.callback.UpdateUserCallback;
import com.su.vx.models.AddFriendMessage;
import com.su.vx.models.AgreeAddFriendMessage;
import com.su.vx.models.Friend;
import com.su.vx.models.NewFriend;
import com.su.vx.models.VXUser;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.bmob.newim.BmobIM;
import cn.bmob.newim.bean.BmobIMConversation;
import cn.bmob.newim.bean.BmobIMMessage;
import cn.bmob.newim.bean.BmobIMUserInfo;
import cn.bmob.newim.core.BmobIMClient;
import cn.bmob.newim.event.MessageEvent;
import cn.bmob.newim.listener.MessageSendListener;
import cn.bmob.v3.BmobQuery;
import cn.bmob.v3.BmobUser;
import cn.bmob.v3.exception.BmobException;
import cn.bmob.v3.listener.FindListener;
import cn.bmob.v3.listener.SaveListener;
import cn.bmob.v3.listener.UpdateListener;

import static cn.bmob.newim.core.BmobIMClient.getContext;

public class UserUtils {

    private static UserUtils instance;

    private UserUtils(){}

    public static UserUtils getInstance(){
        if(instance==null){
            synchronized (UserUtils.class){
                if(instance==null){
                    instance=new UserUtils();
                }
            }
        }
        return instance;
    }

    public void RegisterVXUser(VXUser user, RegisterUserCallback callback){
        if(callback==null){
            Log.e("RegisterVXUser","缺少注册回调对象");
            return;
        }
        if(user==null){
            Log.e("RegisterVXUser","注册用户对象为空");
            return;
        }
        BmobQuery<VXUser> bmobQuery=new BmobQuery<>();
        bmobQuery.addWhereEqualTo("imei",user.getImei());
        bmobQuery.findObjects(new FindListener<VXUser>() {
            @Override
            public void done(List<VXUser> list, BmobException e) {
                if(e==null){
                    if(list.size()==0){
                        //不存在设备，可以注册
                        user.signUp(new SaveListener<VXUser>() {
                            @Override
                            public void done(VXUser user, BmobException e) {
                                if(e==null){
                                    callback.onRegisterResult(true,null,user);
                                }else{
                                    callback.onRegisterResult(false,"注册失败,"+e.toString(),null);
                                }
                            }
                        });
                    }else{
                        callback.onRegisterResult(false,"该设备用户已经存在，请联系管理员提供真实身份信息重新注册设备.",null);
                    }
                }else{
                    callback.onRegisterResult(false,e.toString(),null);
                }
            }
        });
    }

    public void loginDeviceVXUser(String id, String weight, String p, LoginUserCallback callback){
        if(callback==null){
            Log.e("loginDeviceVXUser","传入的登录回调不能为空");
            return;
        }
        if(TextUtils.isEmpty(id)||TextUtils.isEmpty(weight)||TextUtils.isEmpty(p)){
            Log.e("loginDeviceVXUser","输入参数不能为空");
            return;
        }
        if(DeviceUtils.getMD5(weight+p).equals(id)){
            BmobQuery<VXUser> bmobQuery=new BmobQuery<>();
            bmobQuery.addWhereEqualTo("id",id);
            bmobQuery.findObjects(new FindListener<VXUser>() {
                @Override
                public void done(List<VXUser> list, BmobException e) {
                    if(e==null){
                        callback.onLoginResult(true,null,list.get(0));
                    }else{
                        callback.onLoginResult(false,e.toString(),null);
                    }
                }
            });
        }
    }

    public void queryVXUser(String imei, QueryUserCallback callback){
        if(callback==null){
            Log.e("queryVXUser","查询回调为空");
            return;
        }
        if(imei==null){
            Log.e("queryVXUser","输入的查询id为空");
            return;
        }
        BmobQuery<VXUser> bmobQuery=new BmobQuery<>();
        bmobQuery.addWhereEqualTo("imei",imei);
        bmobQuery.findObjects(new FindListener<VXUser>() {
            @Override
            public void done(List<VXUser> list, BmobException e) {
                if(e==null){
                    if(list.size()>0) {
                        callback.onQueryResult(true, null, list.get(0));
                    }else{
                        callback.onQueryResult(true, "没有数据", null);
                    }
                }else{
                    callback.onQueryResult(false,e.toString(),null);
                }
            }
        });
    }

    public void loginUser(String username,String password,QueryCallback<VXUser> callback){
        if(callback==null){
            Log.e("loginUser","回调为空");
            return;
        }
        if(username==null||password==null){
            Log.e("loginUser","用户名密码为空");
            return;
        }
        VXUser user=new VXUser();
        user.setUsername(username);
        user.setPassword(password);
        user.login(new SaveListener<VXUser>() {
            @Override
            public void done(VXUser user, BmobException e) {
                if(e==null){
                    callback.result(true,null,user);
                }else{
                    callback.result(false,e.toString(),null);
                }
            }
        });
    }

    public void updateUserInfo(MessageEvent event, final UpdateUserCallback callback) {
        if(callback==null){
            Log.e("updateUserInfo","输入更新用户信息回调为空");
            return;
        }
        if(event==null){
            Log.e("updateUserInfo","输入消息事件为空");
            return;
        }
        final BmobIMConversation conversation = event.getConversation();
        final BmobIMUserInfo info = event.getFromUserInfo();
        final BmobIMMessage msg = event.getMessage();
        String username = info.getName();
        String avatar = info.getAvatar();
        String title = conversation.getConversationTitle();
        String icon = conversation.getConversationIcon();
        if (!username.equals(title) || (avatar != null && !avatar.equals(icon))) {
            queryVXUser(info.getUserId(), (success, e, user) -> {
                if (e == null) {
                    String name = user.getNickname();
                    String avatar1 = user.getAvatar();
                    conversation.setConversationIcon(avatar1);
                    conversation.setConversationTitle(name);
                    info.setName(name);
                    info.setAvatar(avatar1);
                    BmobIM.getInstance().updateUserInfo(info);
                    if (!msg.isTransient()) {
                        BmobIM.getInstance().updateConversation(conversation);
                    }
                    callback.onUpdateResult(true,null,user);
                } else {
                    callback.onUpdateResult(false,e.toString(),null);
                }
            });
        } else {
            callback.onUpdateResult(false,"无需更新用户信息",null);
        }
    }

    public void queryUsername(String username, QueryCallback<VXUser> callback){
        if(callback==null){
            Log.e("queryUsername","回调对象为空");
            return;
        }
        if(username==null){
            Log.e("queryUsername","输入的用户名为空");
            return;
        }
        BmobQuery<VXUser> bmobQuery=new BmobQuery<>();
        bmobQuery.addWhereEqualTo("username",username);
        bmobQuery.findObjects(new FindListener<VXUser>() {
            @Override
            public void done(List<VXUser> list, BmobException e) {
                if(e==null){
                    if(list.size()>0){
                        callback.result(true,null,list.get(0));
                    }else{
                        callback.result(true,"用户不存在",null);
                    }
                }else{
                    Log.e("queryUsername",e.toString());
                    callback.result(false,e.toString(),null);
                }
            }
        });
    }

    public void queryFriends(QueryListCallback<Friend> callback){
        if(callback==null){
            Log.e("queryFriends","回调为空");
            return;
        }
        BmobQuery<Friend> query = new BmobQuery<>();
        VXUser user =BmobUser.getCurrentUser(VXUser.class);
        query.addWhereEqualTo("user", user);
        query.include("friendUser");
        query.order("-updatedAt");
        query.findObjects(new FindListener<Friend>() {
            @Override
            public void done(List<Friend> list, BmobException e) {
                if(e==null){
                    callback.result(true,null, list);
                }else{
                    callback.result(false,e.toString(),null);
                }
            }
        });
    }

    public void deleteFriend(Friend f,EmptyCallback callback){
        if(callback==null){
            Log.e("deleteFriend","回调为空");
            return;
        }
        f.delete(new UpdateListener() {
            @Override
            public void done(BmobException e) {
                if(e==null){
                    callback.result(true,null);
                }else{
                    callback.result(false,e.toString());
                }
            }
        });
    }

    //发送添加好友请求
    public void sendAddFriendMessage(BmobIMUserInfo info) {
        BmobIMConversation conversationEntrance = BmobIM.getInstance().startPrivateConversation(info, true, null);
        BmobIMConversation messageManager = BmobIMConversation.obtain(BmobIMClient.getInstance(), conversationEntrance);
        AddFriendMessage msg = new AddFriendMessage();
        VXUser currentUser = BmobUser.getCurrentUser(VXUser.class);
        msg.setContent("很高兴认识你，可以加个好友吗?");//给对方的一个留言信息
        Map<String, Object> map = new HashMap<>();
        map.put("name", currentUser.getUsername());//发送者姓名
        map.put("avatar", currentUser.getAvatar());//发送者的头像
        map.put("uid", currentUser.getObjectId());//发送者的uid
        msg.setExtraMap(map);
        messageManager.sendMessage(msg, new MessageSendListener() {
            @Override
            public void done(BmobIMMessage msg, BmobException e) {
                if (e == null) {//发送成功
                    Toast.makeText(getContext(), "好友请求发送成功，等待验证", Toast.LENGTH_SHORT).show();
                } else {//发送失败
                    Toast.makeText(getContext(), "发送失败", Toast.LENGTH_SHORT).show();
                }
            }
        });
    }

    //发送统一添加好友请求
    public void sendAgreeAddFriendMessage(final NewFriend add) {
        BmobIMUserInfo info = new BmobIMUserInfo(add.getUid(), add.getName(), add.getAvatar());
        BmobIMConversation conversationEntrance = BmobIM.getInstance().startPrivateConversation(info, true, null);
        BmobIMConversation messageManager = BmobIMConversation.obtain(BmobIMClient.getInstance(), conversationEntrance);
        //而AgreeAddFriendMessage的isTransient设置为false，表明我希望在对方的会话数据库中保存该类型的消息
        AgreeAddFriendMessage msg = new AgreeAddFriendMessage();
        final VXUser currentUser = BmobUser.getCurrentUser(VXUser.class);
        msg.setContent("我通过了你的好友验证请求，我们可以开始 聊天了!");//这句话是直接存储到对方的消息表中的
        Map<String, Object> map = new HashMap<>();
        map.put("msg", currentUser.getUsername() + "同意添加你为好友");//显示在通知栏上面的内容
        map.put("uid", add.getUid());//发送者的uid-方便请求添加的发送方找到该条添加好友的请求
        map.put("time", add.getTime());//添加好友的请求时间
        msg.setExtraMap(map);
        messageManager.sendMessage(msg, new MessageSendListener() {
            @Override
            public void done(BmobIMMessage msg, BmobException e) {
                if (e == null) {//发送成功

                } else {//发送失败

                }
            }
        });
    }


}
