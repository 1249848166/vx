package com.su.vx.callback;

import com.su.vx.models.VXUser;

public interface LoginUserCallback {
    void onLoginResult(boolean success, String e, VXUser user);
}
