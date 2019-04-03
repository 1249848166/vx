import "package:flutter/material.dart";
import "../secondary/registerpwdenter.dart";

class DeviceIdCreateButton extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 40.0,
          width: MediaQuery.of(context).size.width,
          color: Colors.red,
          margin: EdgeInsets.all(10.0),
          child: FlatButton(
            color: Colors.green,
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=>RegisterPasswordEnterPage(),
              ));
            },
            child: Text(
              "点击生成设备唯一账号",
              style:
              TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}