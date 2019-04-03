package com.su.vx.models;

import cn.bmob.newim.bean.BmobIMExtraMessage;

public class AgreeAddFriendMessage extends BmobIMExtraMessage {

    private String uid;//最初的发送方
    private Long time;
    private String msg;//用于通知栏显示的内容

    @Override
    public String getMsgType() {
        return "agree";
    }

    @Override
    public boolean isTransient() {
        return false;
    }


}
