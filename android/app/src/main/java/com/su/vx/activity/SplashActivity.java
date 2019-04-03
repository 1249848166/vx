package com.su.vx.activity;

import android.animation.Animator;
import android.animation.ObjectAnimator;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.view.View;
import android.widget.TextView;

import com.su.vx.R;
import com.su.vx.im.VXHandler;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;

import cn.bmob.newim.BmobIM;

public class SplashActivity extends Activity {

    private TextView 虽然,我是,假微信,但是我很,可信;

    @SuppressLint("NewApi")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash);

        虽然=findViewById(R.id.虽然);
        我是=findViewById(R.id.我是);
        假微信=findViewById(R.id.假微信);
        但是我很=findViewById(R.id.但是我很);
        可信=findViewById(R.id.可信);

        虽然.setAlpha(0);
        我是.setAlpha(0);
        假微信.setAlpha(0);
        但是我很.setAlpha(0);
        可信.setAlpha(0);

        //文字动画
        animateText();

        //初始化即时通讯sdk
        if (getApplicationInfo().packageName.equals(getMyProcessName())) {
            BmobIM.init(this);
            BmobIM.registerDefaultMessageHandler(new VXHandler(this));
        }
    }

    private void animateText() {
        Animator animator=ObjectAnimator.ofFloat(虽然,"alpha",0,0.5f,1);
        animator.setDuration(500);
        animator.addListener(new Animator.AnimatorListener() {
            @Override
            public void onAnimationStart(Animator animation) {

            }

            @Override
            public void onAnimationEnd(Animator animation) {
                Animator animator1=ObjectAnimator.ofFloat(我是,"alpha",0,0.5f,1);
                animator1.setDuration(500);
                animator1.addListener(new Animator.AnimatorListener() {
                    @Override
                    public void onAnimationStart(Animator animation) {

                    }

                    @Override
                    public void onAnimationEnd(Animator animation) {
                        Animator animator2=ObjectAnimator.ofFloat(假微信,"alpha",0,0.5f,1);
                        animator2.setDuration(1000);
                        animator2.addListener(new Animator.AnimatorListener() {
                            @Override
                            public void onAnimationStart(Animator animation) {

                            }

                            @Override
                            public void onAnimationEnd(Animator animation) {
                                Animator animator3=ObjectAnimator.ofFloat(但是我很,"alpha",0,0.5f,1);
                                animator3.setDuration(500);
                                animator3.addListener(new Animator.AnimatorListener() {
                                    @Override
                                    public void onAnimationStart(Animator animation) {

                                    }

                                    @Override
                                    public void onAnimationEnd(Animator animation) {
                                        Animator animator4=ObjectAnimator.ofFloat(可信,"alpha",0,0.5f,1);
                                        animator4.setDuration(1000);
                                        animator4.addListener(new Animator.AnimatorListener() {
                                            @Override
                                            public void onAnimationStart(Animator animation) {

                                            }

                                            @Override
                                            public void onAnimationEnd(Animator animation) {
                                                new Handler(Looper.getMainLooper()).postDelayed(() -> {
                                                    startActivity(new Intent(SplashActivity.this,LoginActivity.class));
                                                    finish();
                                                },1000);
                                            }

                                            @Override
                                            public void onAnimationCancel(Animator animation) {

                                            }

                                            @Override
                                            public void onAnimationRepeat(Animator animation) {

                                            }
                                        });
                                        animator4.start();
                                    }

                                    @Override
                                    public void onAnimationCancel(Animator animation) {

                                    }

                                    @Override
                                    public void onAnimationRepeat(Animator animation) {

                                    }
                                });
                                animator3.start();
                            }

                            @Override
                            public void onAnimationCancel(Animator animation) {

                            }

                            @Override
                            public void onAnimationRepeat(Animator animation) {

                            }
                        });
                        animator2.start();
                    }

                    @Override
                    public void onAnimationCancel(Animator animation) {

                    }

                    @Override
                    public void onAnimationRepeat(Animator animation) {

                    }
                });
                animator1.start();
            }

            @Override
            public void onAnimationCancel(Animator animation) {

            }

            @Override
            public void onAnimationRepeat(Animator animation) {

            }
        });
        animator.start();
    }

    //获取进程名称
    private String getMyProcessName() {
        try {
            File file = new File("/proc/" + android.os.Process.myPid() + "/" + "cmdline");
            BufferedReader mBufferedReader = new BufferedReader(new FileReader(file));
            String processName = mBufferedReader.readLine().trim();
            mBufferedReader.close();
            return processName;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public void onWindowFocusChanged(boolean hasFocus) {
        super.onWindowFocusChanged(hasFocus);
        if(hasFocus)
        {
            View decorView = getWindow().getDecorView();
            decorView.setSystemUiVisibility(
                    View.SYSTEM_UI_FLAG_LAYOUT_STABLE//保持布局状态
                            | View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION//可以显示在导航栏后面
                            | View.SYSTEM_UI_FLAG_HIDE_NAVIGATION//隐藏导航栏
                            | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN//可以显示在状态栏后面
                            | View.SYSTEM_UI_FLAG_FULLSCREEN//隐藏状态栏
                            | View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY);//显示状态栏后几秒后消失
        }

    }
}
