package com.su.vx.callback;

import com.su.vx.models.VXUser;

public interface QueryUserCallback {
    void onQueryResult(boolean success,String e,VXUser user);
}
