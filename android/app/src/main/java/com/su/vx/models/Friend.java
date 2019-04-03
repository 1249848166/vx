package com.su.vx.models;

import cn.bmob.v3.BmobObject;

public class Friend extends BmobObject {

    private VXUser user;
    private VXUser friendUser;

    public VXUser getUser() {
        return user;
    }

    public void setUser(VXUser user) {
        this.user = user;
    }

    public VXUser getFriendUser() {
        return friendUser;
    }

    public void setFriendUser(VXUser friendUser) {
        this.friendUser = friendUser;
    }
}
