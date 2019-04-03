package com.su.vx.callback;

import com.su.vx.models.VXUser;

public interface RegisterUserCallback {
    void onRegisterResult(boolean success, String e, VXUser user);
}
