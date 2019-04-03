package com.su.vx.activity;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;

import com.google.gson.Gson;
import com.su.vx.callback.QueryListCallback;
import com.su.vx.models.Friend;
import com.su.vx.models.VXUser;
import com.su.vx.utils.Constant;
import com.su.vx.utils.DeviceUtils;
import com.su.vx.utils.UserUtils;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.util.List;

import cn.bmob.newim.BmobIM;
import cn.bmob.newim.bean.BmobIMUserInfo;
import cn.bmob.newim.core.ConnectionStatus;
import cn.bmob.newim.listener.ConnectListener;
import cn.bmob.newim.listener.ConnectStatusChangeListener;
import cn.bmob.newim.notification.BmobNotificationManager;
import cn.bmob.v3.BmobUser;
import cn.bmob.v3.exception.BmobException;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @SuppressLint("NewApi")
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    try {

      GeneratedPluginRegistrant.registerWith(this);
      //注册供flutter调用的接口
      new MethodChannel(getFlutterView(), "Device").setMethodCallHandler((methodCall, result) -> {
        try {
          if (methodCall.method.equals("getImeiMac")) {
            String imei = getImeiMac();
            result.success(imei);
          }else if (methodCall.method.equals("register")) {
            VXUser user=new VXUser();
            user.setAvatar("http://bmob-cdn-20674.b0.upaiyun.com/2018/10/10/f7e4bcbe40f7442180ac3305031f8ea6.jpg");
            user.setId(methodCall.arguments.toString());
            user.setImei(DeviceUtils.getMD5(DeviceUtils.getImei(this)));
            user.setMac(DeviceUtils.getMD5(DeviceUtils.getMac(this)));
            user.setNickname("微信用户"+System.currentTimeMillis());
            user.setPhone("未设置");
            Intent intent=getIntent();
            user.setUsername(intent.getStringExtra("username"));
            user.setPassword(intent.getStringExtra("password"));
            UserUtils.getInstance().RegisterVXUser(user, (success, e, user1) -> {
              if (success) {
                result.success("注册成功");
              } else {
                Log.e("register", e);
                result.success(e);
              }
            });
          }else if(methodCall.method.equals("login")){
            SharedPreferences sp=getSharedPreferences("vx",MODE_PRIVATE);
            String username=sp.getString("username","");
            String password=sp.getString("password","");
            //Log.e("用户名密码",username+"："+password);
            UserUtils.getInstance().loginUser(username, password, (success, e, user) -> {
              if(success){
                Log.e("mainactivity","登录成功");
                imLogic();
              }else{
                Log.e("mainactivity","登录失败"+e);
              }
            });
          }else if(methodCall.method.equals("queryDeviceID")){//搜索当前设备是否注册
              UserUtils.getInstance().queryVXUser(
                      DeviceUtils.getMD5(DeviceUtils.getImei(MainActivity.this)),
                      (success, e, user) -> {
                        try {
                          if (success) {
                            //成功，有可能查询到的为空
                            if (user != null) {
                              result.success(new Gson().toJson(user));
                            } else {
                              result.success(Constant.no_device_msg);
                            }
                          } else {
                            Log.e("查询当前设备是否注册，失败", "原因：" + e);
                            result.success("查询失败:" + e);
                          }
                        }catch (Exception e1){
                          e1.printStackTrace();
                        }
                      });
          }else if(methodCall.method.equals("getUserInfo")){//获取用户信息
            UserUtils.getInstance().queryVXUser(DeviceUtils.getMD5(DeviceUtils.getImei(this)),
                    (success, e, user) -> {
                      if(success){
                        Gson gson=new Gson();
                        String json=gson.toJson(user);
                        result.success(json);
                      }else{
                        result.success("");
                      }
                    });
          }else if(methodCall.method.equals("queryFriends")){
              UserUtils.getInstance().queryFriends((success, e, friends) -> {
                  if(success){
                      Log.e("好友数",""+friends.size());
                  }else{
                      Log.e("mainactivity",e);
                  }
              });
          } else {
            result.notImplemented();
          }
        }catch (Exception e){
          e.printStackTrace();
        }
      });

    }catch (Exception e){
      e.printStackTrace();
    }

  }

  //im逻辑
  private void imLogic(){
    Log.e("imLogic","执行了im逻辑");
    VXUser user = BmobUser.getCurrentUser(VXUser.class);
    if (!TextUtils.isEmpty(user.getObjectId()) &&
            BmobIM.getInstance().getCurrentStatus().getCode() != ConnectionStatus.CONNECTED.getCode()) {
      BmobIM.connect(user.getObjectId(), new ConnectListener() {
        @Override
        public void done(String uid, BmobException e) {
          if (e == null) {
            BmobIM.getInstance().
                    updateUserInfo(new BmobIMUserInfo(user.getObjectId(),
                            user.getNickname(), user.getAvatar()));
            Log.e("imLogic","连接im成功");
          } else {
            Log.e("imLogic",e.toString());
          }
        }
      });
      BmobIM.getInstance().setOnConnectStatusChangeListener(new ConnectStatusChangeListener() {
        @Override
        public void onChange(ConnectionStatus status) {
          Log.e("imLogic",status.getMsg());
          Log.e("imLogic",BmobIM.getInstance().getCurrentStatus().getMsg());
          if(status.getCode()==0){//意外断开连接
              BmobIM.connect(user.getObjectId(), new ConnectListener() {
                  @Override
                  public void done(String uid, BmobException e) {
                      if (e == null) {
                          BmobIM.getInstance().
                                  updateUserInfo(new BmobIMUserInfo(user.getObjectId(),
                                          user.getNickname(), user.getAvatar()));
                          Log.e("imLogic","连接im成功");
                      } else {
                          Log.e("imLogic",e.toString());
                      }
                  }
              });
          }
        }
      });
    }else{
      Log.e("imLogic","没有登录");
    }
  }

  @Override
  protected void onResume() {
    super.onResume();
    //检查未读信息
    //checkRedPoint();
    //取消通知栏消息提醒
    BmobNotificationManager.getInstance(this).cancelNotification();
  }

  @Override
  protected void onDestroy() {
    super.onDestroy();
    //清理数据
    BmobIM.getInstance().clear();
    //断开连接
    BmobIM.getInstance().disConnect();
  }

  private void checkRedPoint() {
    int count = (int) BmobIM.getInstance().getAllUnReadCount();
  }

  //获取imei和mac
  private String getImeiMac(){
    return DeviceUtils.getImei(this)+","+DeviceUtils.getMac(this);
  }

}
