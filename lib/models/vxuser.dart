import "package:flutter/material.dart";

class VXUser{
  final String id;
  final String imei;
  final String mac;
  final String phone;
  final String nickname;
  final String avatar;
  final String username;
  final String password;
  VXUser({@required this.id,@required this.imei,@required this.mac,
  @required this.phone,@required this.nickname,@required this.avatar,
  @required this.username,@required this.password});

  VXUser.fromJson(Map<String, dynamic> json)
      : id = json['id'],imei = json['imei'],mac=json['mac'],phone=json['phone'],
  nickname=json['nickname'],avatar=json['avatar'],username=json['username'],
  password=json['password'];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'imei': imei,
        'mac':mac,
        'phone':phone,
        'nickname':nickname,
        'avatar':avatar,
        'username':username,
        'password':password
      };
}