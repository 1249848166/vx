package com.su.vx.callback;

import java.util.List;

public interface QueryListCallback<T> {
    void result(boolean success,String e,List<T> tList);
}
