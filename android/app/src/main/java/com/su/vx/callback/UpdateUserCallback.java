package com.su.vx.callback;

import com.su.vx.models.VXUser;

public interface UpdateUserCallback {
    void onUpdateResult(boolean success, String e, VXUser user);
}
