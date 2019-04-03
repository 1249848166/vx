package com.su.vx.im;

import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Log;

import com.su.vx.activity.MainActivity;
import com.su.vx.R;
import com.su.vx.callback.UpdateUserCallback;
import com.su.vx.models.VXUser;
import com.su.vx.utils.UserUtils;

import org.greenrobot.eventbus.EventBus;

import java.util.List;
import java.util.Map;
import cn.bmob.newim.bean.BmobIMMessage;
import cn.bmob.newim.bean.BmobIMMessageType;
import cn.bmob.newim.bean.BmobIMUserInfo;
import cn.bmob.newim.event.MessageEvent;
import cn.bmob.newim.event.OfflineMessageEvent;
import cn.bmob.newim.listener.BmobIMMessageHandler;
import cn.bmob.newim.notification.BmobNotificationManager;

public class VXHandler extends BmobIMMessageHandler {

    private Context context;

    public VXHandler(Context context){
        this.context=context;
    }

    //接收线上消息
    @Override
    public void onMessageReceive(MessageEvent messageEvent) {
        super.onMessageReceive(messageEvent);
        executeMessage(messageEvent);
    }

    //接收离线消息
    @Override
    public void onOfflineReceive(OfflineMessageEvent offlineMessageEvent) {
        super.onOfflineReceive(offlineMessageEvent);
        Map<String, List<MessageEvent>> map = offlineMessageEvent.getEventMap();
        Log.e("onOfflineReceive","有" + map.size() + "个用户发来离线消息");
        //挨个检测下离线消息所属的用户的信息是否需要更新
        for (Map.Entry<String, List<MessageEvent>> entry : map.entrySet()) {
            List<MessageEvent> list = entry.getValue();
            int size = list.size();
            Log.e("onOfflineReceive","用户" + entry.getKey() + "发来" + size + "条消息");
            for (int i = 0; i < size; i++) {
                //处理每条消息
                executeMessage(list.get(i));
            }
        }
    }

    private void executeMessage(final MessageEvent event) {
        UserUtils.getInstance().updateUserInfo(event, new UpdateUserCallback() {
            @Override
            public void onUpdateResult(boolean success, String e, VXUser user) {
                BmobIMMessage msg=event.getMessage();
                if (BmobIMMessageType.getMessageTypeValue(msg.getMsgType()) == 0) {
                    processCustomMessage(msg, event.getFromUserInfo());
                } else {
                    processSDKMessage(msg, event);
                }
            }
        });
    }

    private void processSDKMessage(BmobIMMessage msg, MessageEvent event) {
        if (BmobNotificationManager.getInstance(context).isShowNotification()) {
            Intent pendingIntent = new Intent(context, MainActivity.class);
            pendingIntent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK);
            BmobIMUserInfo info = event.getFromUserInfo();
            Bitmap largeIcon = BitmapFactory.decodeResource(context.getResources(), R.mipmap.ic_launcher);
            BmobNotificationManager.getInstance(context).showNotification(largeIcon,
                    info.getName(), msg.getContent(), "您有一条新消息", pendingIntent);
        } else {
            EventBus.getDefault().post(event);
        }
    }

    private void processCustomMessage(BmobIMMessage msg, BmobIMUserInfo info) {

    }
}
