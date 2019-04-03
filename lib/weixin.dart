import "package:flutter/material.dart";
import "package:vx/library/constant.dart";
import 'library/deviceidcreatbutton.dart';

class Weixin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WeixinState();
  }
}

class WeixinState extends State<Weixin> {
  List<ListItemData> datas = [
    ListItemData(
        icon: Avartar.avartar1,
        name: "tom",
        desc: "你好",
        time: "08:55",
        unreadnum: 10,
        isImportant: true),
    ListItemData(
        icon: Avartar.avartar2,
        name: "tim",
        desc: "在吗",
        time: "08:59",
        unreadnum: 0,
        isImportant: true),
    ListItemData(
        icon: Avartar.avartar3,
        name: "lory",
        desc: "现在过的怎样",
        time: "07:50",
        unreadnum: 99,
        isImportant: true),
    ListItemData(
        icon: Avartar.avartar4,
        name: "jack",
        desc: "最近还好吗",
        time: "06:45",
        unreadnum: 1000,
        isImportant: true),
    ListItemData(
        icon: Avartar.avartar5,
        name: "mike",
        desc: "很久不见了",
        time: "05:05",
        unreadnum: 10,
        isImportant: false),
    ListItemData(
        icon: Avartar.avartar6,
        name: "json",
        desc: "早上好啊",
        time: "04:43",
        unreadnum: 10,
        isImportant: true),
    ListItemData(
        icon: Avartar.avartar7,
        name: "kom",
        desc: "朋友，出来玩吧,快出来玩吧，不然我要把你家给拆了啦啦啦啦啦啦啦啦哈哈哈哈哈哈哈",
        time: "03:21",
        unreadnum: 10,
        isImportant: true),
    ListItemData(
        icon: Avartar.avartar8,
        name: "top",
        desc: "好的，收到",
        time: "2019.03.21-08:35",
        unreadnum: 10,
        isImportant: true),
    ListItemData(
        icon: Avartar.avartar9,
        name: "hello",
        desc: "明天联系你",
        time: "2019.03.21-08:45",
        unreadnum: 10,
        isImportant: true),
    ListItemData(
        icon: Avartar.avartar10,
        name: "lily",
        desc: "以后再说吧",
        time: "2019.03.21-08:05",
        unreadnum: 10,
        isImportant: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Constant.hasId
        ? getListItemViews(datas)
        : DeviceIdCreateButton();
  }

  getListItemViews(List<ListItemData> list) {
    List<Widget> widgets = [];
    for (int i = 0; i < list.length + 1; i++) {
      if (i == 0) {
        //添加顶部提示
        widgets.add(getTopTitleView());
      } else {
        //添加聊天项
        widgets.add(getListItemView(list[i - 1]));
      }
    }
    ListView listview = ListView(
      children: widgets,
    );
    return listview;
  }

  getTopTitleView() {
    return Container(
      padding: EdgeInsets.all(15.0),
      color: Color.fromARGB(255, 240, 240, 240),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child:
                Icon(IconData(IconFont.weixin_light, fontFamily: "IconFont")),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Text(
              "小苏欢迎您使用家唯信app!!!",
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  getListItemView(ListItemData data) {
    Container container = Container(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5.0),
                child: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.network(
                          data.icon,
                          width: 60.0,
                          height: 60.0,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Positioned(
                      top: -5.0,
                      left: 50.0,
                      child: getMessageDot(data.unreadnum, data),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          data.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 3.0),
                        child: Text(
                          data.desc,
                          style: TextStyle(color: Colors.black, fontSize: 12.0),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                  margin: EdgeInsets.only(left: 20.0),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Container(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        data.time,
                        style: TextStyle(fontSize: 12.0),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 3.0),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                data.isImportant = !data.isImportant;
                                print("点击了按钮${data.isImportant}");
                              });
                            },
                            icon: Icon(IconData(
                                data.isImportant
                                    ? IconFont.tongzhi
                                    : IconFont.tongzhi_no,
                                fontFamily: "IconFont"))),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
    return container;
  }

  getMessageDot(int unreadnum, ListItemData data) {
    if (unreadnum <= 0) {
      return Container();
    } else {
      if (unreadnum >= 99) {
        return Container(
          width: 25.0,
          decoration: BoxDecoration(
              color: data.isImportant ? Colors.red : Colors.grey,
              borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            padding: EdgeInsets.all(4.0),
            child: Text(
              "99+",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10.0, color: Colors.white),
            ),
          ),
        );
      } else {
        return Container(
          width: 25.0,
          decoration: BoxDecoration(
              color: data.isImportant ? Colors.red : Colors.grey,
              borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            padding: EdgeInsets.all(4.0),
            child: Text(
              "$unreadnum",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10.0, color: Colors.white),
            ),
          ),
        );
      }
    }
  }
}

class ListItemData {
  final String icon;
  final String name;
  final String desc;
  final String time;
  final int unreadnum;
  dynamic isImportant;

  ListItemData(
      {Key key,
      @required this.icon,
      @required this.name,
      @required this.desc,
      @required this.time,
      @required this.unreadnum,
      @required this.isImportant});
}
