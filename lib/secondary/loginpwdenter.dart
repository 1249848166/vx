import "package:flutter/material.dart";
import 'dart:math';
import '../main.dart';
import "../library/constant.dart";
import 'package:crypto/crypto.dart';
import 'dart:convert';
import "../models/vxuser.dart";
import 'package:flutter/services.dart';
import 'dart:async';

class LoginPasswordEnterPage extends StatefulWidget {

  final VXUser user;

  LoginPasswordEnterPage({@required this.user});

  @override
  State<StatefulWidget> createState() {
    return LoginPasswordEnterPageState();
  }
}

class LoginPasswordEnterPageState extends State<LoginPasswordEnterPage> {
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
        title: Text("设备登录界面"),
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
                "请输入六位登录密码",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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

  onSureDown() async {
    //print("点击了确定");
    if (index == 6) {
      //print("密码输入完成,密码是：${pwds[0]}${pwds[1]}${pwds[2]}${pwds[3]}${pwds[4]}${pwds[5]}");
      String pwd="${pwds[0]}${pwds[1]}${pwds[2]}${pwds[3]}${pwds[4]}${pwds[5]}";
      String dmd5;
      _getImeiMacEncodePwd(pwd).then((md5){//获取设备信息
        dmd5=md5;
      });
      final String result = await platform_device.invokeMethod("queryDeviceID");
      if (result != null) {
        if (result.trim().startsWith("{")) {
          //是json
          Map<String, dynamic> userMap = json.decode(result);
          VXUser user = VXUser.fromJson(userMap);
          if(user.id==dmd5) {
            print("前往登录后的页面");
            Constant.hasId=true;
            Navigator.pushAndRemoveUntil(
                context, new MaterialPageRoute(builder: (BuildContext context) {
              return MyHomePage(
                result: null,
                user: widget.user,
              );
            }), (route) => route == null);
          }else{
            print("密码错误");
            showDialog(
                context: context,
                builder: (_) => new AlertDialog(
                    title: new Text("提示"),
                    content: new Text("密码错误"),
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
      }
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
