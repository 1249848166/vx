import 'package:flutter/material.dart';
import "package:vx/library/constant.dart";
import "weixin.dart";
import "tongxunlu.dart";
import "faxian.dart";
import "wo.dart";
import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:async';
import "models/vxuser.dart";
import "secondary/loginpwdenter.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '家唯信',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        result: null,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String result;

  BuildContext context;

  MyHomePage({Key key, @required this.result,VXUser user}) : super(key: key) {
    if(user==null) {
      //搜索是否设备id已经存在，如果存在提示登录
      _getDeviceIDStatus();
    }else{
      Constant.user=user;
      platform_device.invokeMethod("login");
    }
  }

  static const platform_device = const MethodChannel("Device");

  //调用安卓方法：搜索当前设备ID是否已经注册
  Future<Null> _getDeviceIDStatus() async {
    final String result = await platform_device.invokeMethod("queryDeviceID");
    if (result != null) {
      if (result.trim().startsWith("{")) {
        //是json
        Map<String, dynamic> userMap = json.decode(result);
        VXUser user = VXUser.fromJson(userMap);
        Navigator.pushAndRemoveUntil(
            context, new MaterialPageRoute(builder: (BuildContext context) {
          return LoginPasswordEnterPage(
            user: user,
          );
        }), (route) => route == null);
      } else {
        //是字符串
        showAlertDialog(context, "提示", result, () {
          //确定
          Navigator.of(context).pop();
          if(result!=Constant.no_device_msg) {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          }
        }, () {
          //取消
          Navigator.of(context).pop();
          if(result!=Constant.no_device_msg) {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          }
        });
      }
    }
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

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _barIndex = 0;
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "家唯信",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          Container(
            width: 60.0,
            child: FlatButton(
              onPressed: () {
                if(_barIndex==0){

                }else if(_barIndex==1){//前往搜索好友页面
                  //todo 搜索好友
                }else if(_barIndex==2){

                }else{

                }
              },
              child: Image.asset(//搜索
                "auf.png",
                width: 30.0,
                height: 30.0,
              ),
            ),
          ),
          Container(
            width: 60.0,
            margin: EdgeInsets.only(right: 10.0),
            child: FlatButton(
              onPressed: () {
                if(_barIndex==0){

                }else if(_barIndex==1){//前往添加好友界面
                  //todo 添加好友
                }else if(_barIndex==2){

                }else{

                }
              },
              child: Image.asset(//添加
                "aua.png",
                width: 30.0,
                height: 30.0,
              ),
            ),
          ),
        ],
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index) {
          setState(() {
            _barIndex = index;
          });
        },
        children: <Widget>[
          Weixin(),
          Tongxunlu(),
          Faxian(),
          Wo(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _barIndex,
        selectedItemColor: Color.fromARGB(255, 100, 200, 100),
        onTap: (index) {
          setState(() {
            _barIndex = index;
            if (_controller != null) {
              _controller.jumpToPage(index);
            }
          });
        },
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(
              IconData(IconFont.weixin_light, fontFamily: "IconFont"),
            ),
            icon: Icon(IconData(IconFont.weixin, fontFamily: "IconFont")),
            title: Text("唯信"),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              IconData(IconFont.tongxunlu_light, fontFamily: "IconFont"),
            ),
            icon: Icon(
              IconData(IconFont.tongxunlu, fontFamily: "IconFont"),
            ),
            title: Text("通讯录"),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              IconData(IconFont.faxian_light, fontFamily: "IconFont"),
            ),
            icon: Icon(
              IconData(IconFont.faxian, fontFamily: "IconFont"),
            ),
            title: Text("发现"),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              IconData(IconFont.wo_light, fontFamily: "IconFont"),
            ),
            icon: Icon(
              IconData(IconFont.wo, fontFamily: "IconFont"),
            ),
            title: Text("我"),
          ),
        ],
      ),
    );
  }
}
