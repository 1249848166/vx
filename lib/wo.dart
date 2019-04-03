import "package:flutter/material.dart";
import 'package:vx/library/constant.dart';
import 'dart:ui';
import 'library/deviceidcreatbutton.dart';
import 'package:flutter/services.dart';
import "models/vxuser.dart";
import 'dart:convert';

class Wo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WoState();
  }
}

class WoState extends State<Wo> {
  @override
  Widget build(BuildContext context) {
    return getColums();
  }

  static const platform_device = const MethodChannel("Device");

  Future<Null> _getUserInfo() async {
    String j=await platform_device.invokeMethod("getUserInfo");
    if(j==""){

    }else {
      VXUser user = VXUser.fromJson(json.decode(j));
      setState(() {
        Constant.user=user;
      });
    }
  }

  getColums() {
    Container container = Container(
      color: Color.fromARGB(255, 240, 240, 240),
      child: ListView(
        children: <Widget>[
          Constant.hasId
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerRight,
                  color: Color.fromARGB(255, 240, 240, 240),
                  padding: EdgeInsets.all(10.0),
                  child:
                      Icon(IconData(IconFont.paiizhao, fontFamily: "IconFont")),
                )
              : DeviceIdCreateButton(),
          Constant.hasId
              ? Container(
                  height: 120.0,
                  color: Color.fromARGB(255, 240, 240, 240),
                  child: Container(
                    margin: EdgeInsets.only(top: 50.0),
                    height: 70.0,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Positioned(
                          left: 20.0,
                          top: -40.0,
                          child: Material(
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(5.0),
                            child: Constant.user==null?
                            Image.asset(
                              "bcn.png",
                              width: 70.0,
                              height: 70.0,
                            ):Image.network(
                              Constant.user.avatar,
                              width: 70.0,
                              height: 70.0,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 100.0,
                          top: -34.0,
                          child: Text(
                            Constant!=null?Constant.user.nickname:"",//昵称
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                        ),
                        Positioned(
                          left: 100.0,
                          top: 5.0,
                          child: Text(
                            Constant.user!=null?"唯信号:${Constant.user.username}":"",//唯信号
                            style: TextStyle(fontSize: 15.0),
                            maxLines: 1,
                          ),
                        ),
                        Positioned(
                          right: 40.0,
                          top: 5.0,
                          child: Icon(
                            IconData(IconFont.erweima, fontFamily: "IconFont"),
                            size: 25.0,
                            color: Colors.grey,
                          ),
                        ),
                        Positioned(
                          right: 10.0,
                          top: 10.0,
                          child: Image.asset(
                            "b7d.png",
                            width: 16.0,
                            height: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
          Constant.hasId
              ? Container(
                  padding: EdgeInsets.all(20.0),
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        IconData(IconFont.zhifu, fontFamily: "IconFont"),
                        color: Colors.green,
                        size: 30.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "支付",
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            "b7d.png",
                            width: 16.0,
                            height: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          Constant.hasId
              ? Container(
                  padding: EdgeInsets.all(20.0),
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        IconData(IconFont.shoucang, fontFamily: "IconFont"),
                        color: Colors.orange,
                        size: 30.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "收藏",
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            "b7d.png",
                            width: 16.0,
                            height: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          Constant.hasId
              ? Divider(
                  height: 0.5,
                )
              : Container(),
          Constant.hasId
              ? Container(
                  padding: EdgeInsets.all(20.0),
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        IconData(IconFont.xiangce, fontFamily: "IconFont"),
                        color: Colors.blue,
                        size: 30.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "相册",
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            "b7d.png",
                            width: 16.0,
                            height: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          Constant.hasId
              ? Divider(
                  height: 0.5,
                )
              : Container(),
          Constant.hasId
              ? Container(
                  padding: EdgeInsets.all(20.0),
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        IconData(IconFont.biaoqing, fontFamily: "IconFont"),
                        color: Colors.yellow,
                        size: 30.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "表情",
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            "b7d.png",
                            width: 16.0,
                            height: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          Constant.hasId
              ? Container(
                  padding: EdgeInsets.all(20.0),
                  margin: EdgeInsets.only(top: 10.0),
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        IconData(IconFont.shezhi, fontFamily: "IconFont"),
                        color: Colors.blueAccent,
                        size: 30.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "设置",
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            "b7d.png",
                            width: 16.0,
                            height: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
    return container;
  }
}
