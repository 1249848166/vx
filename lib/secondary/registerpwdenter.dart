import "package:flutter/material.dart";
import 'dart:math';
import '../main.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import "package:vx/library/constant.dart";

class RegisterPasswordEnterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterPasswordEnterPageState();
  }
}

class RegisterPasswordEnterPageState extends State<RegisterPasswordEnterPage> {
  List<String> pwds = [];
  List<int> keys = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 30; i++) {
      int a = Random().nextInt(10);
      int b = Random().nextInt(10);
      if (a != b) {
        keys[a] = keys[a] + keys[b];
        keys[b] = keys[a] - keys[b];
        keys[a] = keys[a] - keys[b];
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("注册密码界面"),
      ),
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "请注册六位登录密码",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.red),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 40.0,
                    height: 40.0,
                    alignment: Alignment.center,
                    child: OutlineButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                      borderSide:
                      new BorderSide(color: Color(0xff999999), width: 2.0),
                      child: new Text(
                        "${index >= 1 ? "*" : ""}",
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            color: Color(0xff333333),
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    width: 40.0,
                    height: 40.0,
                    alignment: Alignment.center,
                    child: OutlineButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                      borderSide:
                      new BorderSide(color: Color(0xff999999), width: 2.0),
                      child: new Text(
                        "${index >= 2 ? "*" : ""}",
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            color: Color(0xff333333),
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    width: 40.0,
                    height: 40.0,
                    alignment: Alignment.center,
                    child: OutlineButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                      borderSide:
                      new BorderSide(color: Color(0xff999999), width: 2.0),
                      child: new Text(
                        "${index >= 3 ? "*" : ""}",
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            color: Color(0xff333333),
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    width: 40.0,
                    height: 40.0,
                    alignment: Alignment.center,
                    child: OutlineButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                      borderSide:
                      new BorderSide(color: Color(0xff999999), width: 2.0),
                      child: new Text(
                        "${index >= 4 ? "*" : ""}",
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            color: Color(0xff333333),
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    width: 40.0,
                    height: 40.0,
                    alignment: Alignment.center,
                    child: OutlineButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                      borderSide:
                      new BorderSide(color: Color(0xff999999), width: 2.0),
                      child: new Text(
                        "${index >= 5 ? "*" : ""}",
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            color: Color(0xff333333),
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    width: 40.0,
                    height: 40.0,
                    alignment: Alignment.center,
                    child: OutlineButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                      borderSide:
                      new BorderSide(color: Color(0xff999999), width: 2.0),
                      child: new Text(
                        "${index >= 6 ? "*" : ""}",
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            color: Color(0xff333333),
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 80.0,
            ),
            //输入键盘
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Positioned(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          getNumButton("${keys[0]}"),
                          getNumButton("${keys[1]}"),
                          getNumButton("${keys[2]}"),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          getNumButton("${keys[3]}"),
                          getNumButton("${keys[4]}"),
                          getNumButton("${keys[5]}"),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          getNumButton("${keys[6]}"),
                          getNumButton("${keys[7]}"),
                          getNumButton("${keys[8]}"),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          getNumButton("删除"),
                          getNumButton("${keys[9]}"),
                          getNumButton("确定"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  onNumDown(String key) {
    //print("点击了数字");
    if (index < 6) {
      setState(() {
        pwds.add(key);
        index++;
      });
    }
  }

  onDeleteDown() {
    //print("点击了删除");
    if (index > 0) {
      setState(() {
        pwds.removeLast();
        index--;
      });
    }
  }

  static const platform_device = const MethodChannel("Device");

  //调用安卓端方法：获取设备相关信息
  Future<String> _getImeiMacEncodePwd(String pwd) async {
    final String result = await platform_device.invokeMethod("getImeiMac");
    //print("imei_mac:$result");
    final List<String> results = result.split(",");
    final String imei = results[0];
    final String mac = results[1];
    String imeimd5=md5.convert(utf8.encode(imei)).toString();
    String macmd5=md5.convert(utf8.encode(mac)).toString();
    final String md51 = md5.convert(utf8.encode(imeimd5+macmd5)).toString();
    //print("md51:$md51");
    String md52;
    if(pwd!=null) {
      md52 = md5.convert(utf8.encode(md51 + pwd)).toString();
      //print("md52:$md52");
    }
    return md52;
  }

  Future<Null> _register(String md52) async {
    //提交设备id到服务器,调用安卓方法
    final String result2 = await platform_device.invokeMethod("register", md52);
    if (result2 == "注册成功") {
      //注册成功
      print("注册成功");
      _setLoginStatus();
      //Constant.hasId = true;
      //重新跳转本页面
      Navigator.pushAndRemoveUntil(context,
          new MaterialPageRoute(builder: (BuildContext context) {
            return MyHomePage(
              result: null,
            );
          }), (route) => route == null);
    } else {
      print("注册失败");
      showAlertDialog(context, "注册失败", "原因：$result2", () {
        //点击确定
        Navigator.of(context).pop();
      }, () {
        //点击取消
        Navigator.of(context).pop();
      });
    }
  }

  //调用安卓方法：设置登录状态
  Future<Null> _setLoginStatus() {
    platform_device.invokeMethod("setLoginStatus");
  }

  //显示弹框
  void showAlertDialog(BuildContext context, String title, String content,
      VoidCallback ok, VoidCallback cancel) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
            title: new Text(title),
            content: new Text(content),
            actions: <Widget>[
              new FlatButton(
                child: new Text("取消"),
                onPressed: cancel,
              ),
              new FlatButton(
                child: new Text("确定"),
                onPressed: ok,
              )
            ]));
  }

  onSureDown() {
    //print("点击了确定");
    if (index == 6) {
      //print("密码输入完成,密码是：${pwds[0]}${pwds[1]}${pwds[2]}${pwds[3]}${pwds[4]}${pwds[5]}");
      String pwd="${pwds[0]}${pwds[1]}${pwds[2]}${pwds[3]}${pwds[4]}${pwds[5]}";
      _getImeiMacEncodePwd(pwd).then((md5){
        _register(md5);
      });
    }else{
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
              title: new Text("提示"),
              content: new Text("请输入完整密码"),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("取消"),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text("确定"),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                )
              ]));
    }
  }

  getNumButton(String txt) {
    return Expanded(
      child: Container(
        height: 80.0,
        child: OutlineButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(0.0)),
          borderSide: new BorderSide(color: Color(0xffdddddd), width: 1.0),
          child: new Text(
            "$txt",
            textAlign: TextAlign.center,
            style: new TextStyle(
                color: Color(0xff333333),
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            print("点击了按钮");
            if (txt == "删除" || txt == "确定") {
              if (txt == "删除") {
                onDeleteDown();
              } else {
                onSureDown();
              }
            } else { //点击数字
              onNumDown(txt);
            }
          },
        ),
      ),
    );
  }
}
