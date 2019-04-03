package com.su.vx.activity;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.Toast;

import com.su.vx.R;
import com.su.vx.callback.QueryCallback;
import com.su.vx.models.VXUser;
import com.su.vx.utils.DeviceUtils;
import com.su.vx.utils.UserUtils;

public class LoginActivity extends Activity implements View.OnClickListener {

    EditText usn,pwd;
    Button btn;
    CheckBox checkBox;

    SharedPreferences sp;

    @SuppressLint("CommitPrefEdits")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        if(!DeviceUtils.isNetworkConnected(this)){
            AlertDialog dialog=new AlertDialog.Builder(this).create();
            dialog.setTitle("提示");
            dialog.setMessage("网络未连接");
            dialog.setButton(AlertDialog.BUTTON_POSITIVE, "确定", (dialog1, which) -> {
                dialog1.dismiss();
                System.exit(0);
            });
            dialog.setCancelable(false);
            dialog.show();
        }

        usn=findViewById(R.id.usn);
        pwd=findViewById(R.id.pwd);
        btn=findViewById(R.id.btn);
        checkBox=findViewById(R.id.check);

        sp=getSharedPreferences("vx", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor=sp.edit();

        ProgressDialog progressDialog=new ProgressDialog(this);
        progressDialog.setMessage("检查登录状态...");
        progressDialog.setCancelable(false);
        progressDialog.show();

        if(sp.getString("username",null)!=null
                &&sp.getString("password",null)!=null){
            UserUtils.getInstance().queryUsername(sp.getString("username", ""), (success, e, user) -> {
                if(success){
                    progressDialog.dismiss();
                    if(user==null){
                        editor.remove("username");
                        editor.remove("password");
                        editor.apply();
                    }else{
                        Intent intent=new Intent(this,MainActivity.class);
                        intent.putExtra("username",sp.getString("username",null));
                        intent.putExtra("password",sp.getString("password",null));
                        startActivity(intent);
                        finish();
                    }
                }else{
                    progressDialog.dismiss();
                    AlertDialog dialog=new AlertDialog.Builder(this).create();
                    dialog.setTitle("提示");
                    dialog.setMessage("服务器出错");
                    dialog.setButton(AlertDialog.BUTTON_POSITIVE, "确定", (dialog12, which) -> {
                        dialog12.dismiss();
                        System.exit(0);
                    });
                    dialog.setCancelable(false);
                    dialog.show();
                }
            });
        }else{
            progressDialog.dismiss();
        }

        btn.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()){
            case R.id.btn:
                String username=usn.getText().toString();
                String password=pwd.getText().toString();
                if(TextUtils.isEmpty(username)||TextUtils.isEmpty(password)){
                    Toast.makeText(this, "请输入用户名和密码", Toast.LENGTH_SHORT).show();
                    return;
                }
                String passwordmd5=DeviceUtils.getMD5(password);
                UserUtils.getInstance().queryUsername(username, (success, e, user) -> {
                    if(success){
                        if(user!=null) {
                            Toast.makeText(LoginActivity.this, "用户名已经存在", Toast.LENGTH_SHORT).show();
                        } else{//用户名不存在
                            if(checkBox.isChecked()) {
                                SharedPreferences.Editor editor=sp.edit();
                                editor.putString("username", username);
                                editor.putString("password", passwordmd5);
                                editor.apply();
                            }
                            Intent intent=new Intent(LoginActivity.this,MainActivity.class);
                            intent.putExtra("username",username);
                            intent.putExtra("password",passwordmd5);
                            startActivity(intent);
                            finish();
                        }
                    }else {
                        Toast.makeText(LoginActivity.this, "服务器错误", Toast.LENGTH_SHORT).show();
                    }
                });
                break;
        }
    }
}
