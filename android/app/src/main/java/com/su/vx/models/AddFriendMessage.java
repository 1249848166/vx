package com.su.vx.models;

import cn.bmob.newim.bean.BmobIMExtraMessage;

public class AddFriendMessage extends BmobIMExtraMessage {

    @Override
    public String getMsgType() {
        return "add";
    }

    @Override
    public boolean isTransient() {
        return true;
    }

}
