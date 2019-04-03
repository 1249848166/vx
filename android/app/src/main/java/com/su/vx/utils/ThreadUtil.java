package com.su.vx.utils;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class ThreadUtil {

    private ExecutorService executorService;

    private static ThreadUtil instance;

    private ThreadUtil(){
        executorService=Executors.newFixedThreadPool(10);
    }

    public static ThreadUtil getInstance(){
        if(instance==null){
            synchronized (ThreadUtil.class){
                if(instance==null){
                    instance=new ThreadUtil();
                }
            }
        }
        return instance;
    }

    public void execute(Runnable runnable){
        if(runnable!=null){
            executorService.execute(runnable);
        }
    }
}
