import "vxuser.dart";
import "package:flutter/material.dart";

class Friend{
  String pre;
  VXUser user;
  VXUser friendUser;
  Friend({@required this.pre,@required this.user,@required this.friendUser});
  Friend.fromJson(Map<String, dynamic> json)
      : pre=json['pre'],user = json['user'],friendUser = json['friendUser'];

  Map<String, dynamic> toJson() =>
      {
        'pre':pre,
        'user': user,
        'friendUser': friendUser
      };
}