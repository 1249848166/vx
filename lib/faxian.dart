import "package:flutter/material.dart";
import "package:vx/library/constant.dart";
import 'library/deviceidcreatbutton.dart';

class Faxian extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FaxianState();
  }
}

class FaxianState extends State<Faxian> {
  @override
  Widget build(BuildContext context) {
    if (Constant.hasId) {
      List<ColumData> datas = [
        ColumData(icon: IconFont.pengyouquan, name: "朋友圈", color: Colors.green),
        ColumData(icon: IconFont.saoyisao, name: "扫一扫", color: Colors.blue),
        ColumData(
            icon: IconFont.yaoyiyao, name: "摇一摇", color: Colors.blueAccent),
        ColumData(icon: IconFont.kanyikan, name: "看一看", color: Colors.orange),
        ColumData(
            icon: IconFont.souyisou, name: "搜一搜", color: Colors.orangeAccent),
        ColumData(icon: IconFont.fujinderen, name: "附近的人", color: Colors.blue),
        ColumData(
            icon: IconFont.piaoliuping, name: "漂流瓶", color: Colors.blueAccent),
        ColumData(icon: IconFont.gouwu, name: "购物", color: Colors.orange),
        ColumData(icon: IconFont.youxi, name: "游戏", color: Colors.orangeAccent),
        ColumData(icon: IconFont.xiaochengxu, name: "小程序", color: Colors.pink),
      ];
      return getColumViews(datas);
    } else {
      return DeviceIdCreateButton();
    }
  }

  getColumViews(List<ColumData> datas) {
    List<Widget> widgets = [];
    for (int i = 0; i < datas.length; i++) {
      if (i == 0 || (i > 0 && (i) % 2 == 0)) {
        widgets.add(getColumView(datas[i]));
        widgets.add(Container(
          height: 10.0,
          color: Color.fromARGB(255, 240, 240, 240),
        ));
      } else {
        widgets.add(getColumView(datas[i]));
        if (i % 2 == 1) {
          widgets.add(Divider());
        }
      }
    }
    Container container = Container(
      child: ListView(
        children: widgets,
      ),
    );
    return container;
  }

  getColumView(ColumData data) {
    Container container = Container(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Icon(
            IconData(data.icon, fontFamily: "IconFont"),
            color: data.color,
            size: 30.0,
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Text(
              data.name,
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
    );
    return container;
  }
}

class ColumData {
  final int icon;
  final String name;
  final Color color;

  const ColumData(
      {Key key,
      @required this.icon,
      @required this.name,
      @required this.color});
}
