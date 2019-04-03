import "package:flutter/material.dart";
import "package:vx/library/constant.dart";
import 'library/deviceidcreatbutton.dart';
import 'package:flutter/services.dart';
import "package:vx/models/friend.dart";

class Tongxunlu extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return TongxunluState();
  }
}

class TongxunluState extends State<Tongxunlu> {

  static const platform_device = const MethodChannel("Device");

  //从安卓端获取好友列表
  Future<Null> _getFriends() async{
    List<Friend> friends=await platform_device.invokeMethod("queryFriends");
    setState(() {
      datas=friends;
    });
  }

  List<Friend> datas=[];

//  final List<ItemData> datas = [
//    ItemData(icon: Avartar.avartar1, name: "tom", pre: "T"),
//    ItemData(icon: Avartar.avartar2, name: "tim", pre: "T"),
//    ItemData(icon: Avartar.avartar3, name: "lory", pre: "L"),
//    ItemData(icon: Avartar.avartar4, name: "jack", pre: "J"),
//    ItemData(icon: Avartar.avartar5, name: "mike", pre: "M"),
//    ItemData(icon: Avartar.avartar6, name: "json", pre: "J"),
//    ItemData(icon: Avartar.avartar7, name: "kom", pre: "K"),
//    ItemData(icon: Avartar.avartar8, name: "top", pre: "T"),
//    ItemData(icon: Avartar.avartar9, name: "hello", pre: "H"),
//    ItemData(icon: Avartar.avartar10, name: "lily", pre: "L"),
//    ItemData(icon: Avartar.avartar1, name: "tom", pre: "T"),
//    ItemData(icon: Avartar.avartar2, name: "tim", pre: "T"),
//    ItemData(icon: Avartar.avartar3, name: "lory", pre: "L"),
//    ItemData(icon: Avartar.avartar4, name: "jack", pre: "J"),
//    ItemData(icon: Avartar.avartar5, name: "mike", pre: "M"),
//    ItemData(icon: Avartar.avartar6, name: "json", pre: "J"),
//    ItemData(icon: Avartar.avartar7, name: "kom", pre: "K"),
//    ItemData(icon: Avartar.avartar8, name: "top", pre: "T"),
//    ItemData(icon: Avartar.avartar9, name: "hello", pre: "H"),
//    ItemData(icon: Avartar.avartar10, name: "lily", pre: "L"),
//    ItemData(icon: Avartar.avartar1, name: "tom", pre: "T"),
//    ItemData(icon: Avartar.avartar2, name: "tim", pre: "T"),
//    ItemData(icon: Avartar.avartar3, name: "lory", pre: "L"),
//    ItemData(icon: Avartar.avartar4, name: "jack", pre: "J"),
//    ItemData(icon: Avartar.avartar5, name: "mike", pre: "M"),
//    ItemData(icon: Avartar.avartar6, name: "json", pre: "J"),
//    ItemData(icon: Avartar.avartar7, name: "kom", pre: "K"),
//    ItemData(icon: Avartar.avartar8, name: "top", pre: "T"),
//    ItemData(icon: Avartar.avartar9, name: "hello", pre: "H"),
//    ItemData(icon: Avartar.avartar10, name: "lily", pre: "L"),
//    ItemData(icon: Avartar.avartar1, name: "tom", pre: "T"),
//    ItemData(icon: Avartar.avartar2, name: "tim", pre: "T"),
//    ItemData(icon: Avartar.avartar3, name: "lory", pre: "L"),
//    ItemData(icon: Avartar.avartar4, name: "jack", pre: "J"),
//    ItemData(icon: Avartar.avartar5, name: "mike", pre: "M"),
//    ItemData(icon: Avartar.avartar6, name: "json", pre: "J"),
//    ItemData(icon: Avartar.avartar7, name: "kom", pre: "K"),
//    ItemData(icon: Avartar.avartar8, name: "top", pre: "T"),
//    ItemData(icon: Avartar.avartar9, name: "hello", pre: "H"),
//    ItemData(icon: Avartar.avartar10, name: "lily", pre: "L"),
//  ];

  List<String> list = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];
  Color _currentBarColor = Colors.transparent;
  Map<String, double> preMap = {
    "A": 0.0,
    "B": 0.0,
    "C": 0.0,
    "D": 0.0,
    "E": 0.0,
    "F": 0.0,
    "G": 0.0,
    "H": 0.0,
    "I": 0.0,
    "J": 0.0,
    "K": 0.0,
    "L": 0.0,
    "M": 0.0,
    "N": 0.0,
    "O": 0.0,
    "P": 0.0,
    "Q": 0.0,
    "R": 0.0,
    "S": 0.0,
    "T": 0.0,
    "U": 0.0,
    "V": 0.0,
    "W": 0.0,
    "X": 0.0,
    "Y": 0.0,
    "Z": 0.0
  };
  final Color untouchColor = Colors.transparent;
  final Color touchColor = Colors.black26;

  ScrollController _scrollController;

  double totalHeight = 0.0;

  Container title;

  String _selectedPre="A";

  bool _barPressed=false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Constant.hasId?Container(
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          getItemViews(datas),
          _barPressed?Positioned(
            child: Center(
              child: Material(
                borderRadius: BorderRadius.circular(10.0),
                elevation: 10.0,
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  alignment: Alignment.center,
                  child: Text(
                    _selectedPre,
                    style: TextStyle(fontSize: 60.0),
                  ),
                ),
              ),
            ),
          ):Container(),
          Positioned(
            right: 0.0,
            top: 0.0,
            bottom: 0.0,
            child: Container(
              color: _currentBarColor,
              width: 50.0,
              alignment: Alignment.center,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraint) =>
                    GestureDetector(
                      onVerticalDragDown: (DragDownDetails details) {
                        RenderBox box = context.findRenderObject();
                        double localDy =
                            box.globalToLocal(details.globalPosition).dy;
                        //print("${constraint.maxHeight~/list.length}:${localDy}");
                        int index =
                            localDy ~/ (constraint.maxHeight / list.length);
                        _scrollController.animateTo(getPreMapDy(list[index]),
                            duration: Duration(milliseconds: 300),
                            curve: Curves.ease);
                        setState(() {
                          _currentBarColor = touchColor;
                          _selectedPre=list[index];
                          _barPressed=true;
                        });
                      },
                      onVerticalDragUpdate: (DragUpdateDetails details) {
                        RenderBox box = context.findRenderObject();
                        double localDy =
                            box.globalToLocal(details.globalPosition).dy;
                        //print("${constraint.maxHeight~/list.length}:${localDy}");
                        int index =
                            localDy ~/ (constraint.maxHeight / list.length);
                        _scrollController.animateTo(getPreMapDy(list[index]),
                            duration: Duration(milliseconds: 300),
                            curve: Curves.ease);
                        setState(() {
                          _selectedPre=list[index];
                        });
                      },
                      onVerticalDragEnd: (DragEndDetails details) {
                        setState(() {
                          _currentBarColor = untouchColor;
                          _barPressed=false;
                        });
                      },
                      onVerticalDragCancel: () {
                        setState(() {
                          _currentBarColor = untouchColor;
                          _barPressed=false;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: getColumIndexViews(list),
                      ),
                    ),
              ),
            ),
          ),
        ],
      ),
    ):DeviceIdCreateButton();
  }

  getColumIndexViews(List<String> list) {
    List<Widget> widgets = [];
    for (int i = 0; i < list.length; i++) {
      widgets.add(Text(
        list[i],
        style: TextStyle(
          fontSize: 14.0,
        ),
      ));
    }
    return widgets;
  }

  getItemViews(List<Friend> datas) {
    datas.sort((Friend a, Friend b) {
      return a.pre.compareTo(b.pre);
    });
    List<Widget> widgets = [];
    for (int i = 0; i < datas.length; i++) {
      widgets.add(getItemView(datas[i], i - 1, i));
    }
    Container container = Container(
      child: ListView(
        controller: _scrollController,
        children: widgets,
      ),
    );
    return container;
  }

  getItemView(Friend data, int last, int curr) {
    if (curr > 0) {
      if (datas[last].pre == datas[curr].pre) {
        title = Container();
        totalHeight += 70.0;
      } else {
        if (preMap[data.pre] == 0.0) {
          preMap[data.pre] = totalHeight;
        }
        //print("${data.pre}:${widget.preMap[data.pre]}");
        title = Container(
          height: 30.0,
          padding: EdgeInsets.only(left: 10.0),
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width,
          color: Color.fromARGB(255, 220, 220, 220),
          child: Text(
            data.pre,
            style: TextStyle(
                fontSize: 19.0,
                color: Colors.grey,
                fontWeight: FontWeight.bold),
          ),
        );
        totalHeight += 100.0;
      }
    } else {
      //第一项
      title = Container(
        height: 30.0,
        padding: EdgeInsets.only(left: 10.0),
        alignment: Alignment.centerLeft,
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(255, 220, 220, 220),
        child: Text(
          data.pre,
          style: TextStyle(
              fontSize: 19.0, color: Colors.grey, fontWeight: FontWeight.bold),
        ),
      );
      totalHeight += 100.0;
    }
    Container container = Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        children: <Widget>[
          title,
          Container(
            height: 70.0,
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(25.0),
                  child: ClipOval(
                    child: Image.network(
                      data.friendUser.avatar,
                      width: 50.0,
                      height: 50.0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Text(
                    data.friendUser.nickname,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return container;
  }

  getPreMapDy(String key) {
    print("${key}:${preMap[key]}");
    return preMap[key];
  }
}

class ItemData {
  final String icon;
  final String name;
  final String pre;

  const ItemData(
      {Key key, @required this.icon, @required this.name, @required this.pre});
}
