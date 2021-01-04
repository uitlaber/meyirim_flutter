import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'file.dart';
import 'region.dart';
import 'package:meyirim/globals.dart' as globals;
import 'package:meyirim/helpers/api_manager.dart';

import 'package:http/http.dart' as http;

class User {
  User(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.phone,
      this.userCode,
      this.avatar,
      this.region});

  int id;
  dynamic name;
  String email;
  String phone;
  String username;
  String userCode;
  String avatar;
  Region region;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"] != null ? json["name"] : 'Аноним',
        email: json["email"],
        phone: json["phone"],
        username: json["username"],
        userCode: json["user_code"],
        avatar: json["avatar"],
        region: json["region"] != null && json["region"].length > 0
            ? Region.fromJson(json["region"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "username": username,
        "user_code": userCode,
        "avatar": avatar,
        "region": region.toJson(),
      };
}

Future<User> fetchUser(int fondId) async {
  var url = globals.apiUrl + "/fonds/$fondId";
  var api = new APIManager();
  var result = await api.getAPICall(url);
  return User.fromJson(result);
}
