package com.su.vx.callback;

public interface QueryCallback<T> {
    void result(boolean success,String e,T t);
}
