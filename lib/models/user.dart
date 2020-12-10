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
      this.surname,
      this.username,
      this.email,
      this.permissions,
      // this.isActivated,
      // this.activatedAt,
      // this.lastLogin,
      // this.createdAt,
      // this.updatedAt,

      // this.deletedAt,
      // this.lastSeen,
      // this.isGuest,
      // this.isSuperuser,
      // this.createdIpAddress,
      // this.lastIpAddress,
      // this.calledBy,
      this.userCode,
      this.avatar,
      this.region});

  int id;
  dynamic name;
  String email;
  dynamic permissions;
  String username;
  String userCode;
  dynamic surname;
  File avatar;
  Region region;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        email: json["email"],
        // permissions: json["permissions"],
        username: json["username"],
        // isActivated: json["is_activated"],
        // activatedAt: DateTime.parse(json["activated_at"]),
        // lastLogin: json["last_login"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),

        // deletedAt: json["deleted_at"],
        // lastSeen: json["last_seen"],
        // isGuest: json["is_guest"],
        // isSuperuser: json["is_superuser"],
        // createdIpAddress: json["created_ip_address"],
        // lastIpAddress: json["last_ip_address"],
        // calledBy: json["сalled_by"],
        userCode: json["user_code"],
        avatar: json["avatar"] != null ? File.fromJson(json["avatar"]) : null,
        region: json["region"] != null ? Region.fromJson(json["region"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "permissions": permissions,
        // "is_activated": isActivated,
        // "activated_at": activatedAt.toIso8601String(),
        // "last_login": lastLogin,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        "username": username,
        "surname": surname,
        // "deleted_at": deletedAt,
        // "last_seen": lastSeen,
        // "is_guest": isGuest,
        // "is_superuser": isSuperuser,
        // "created_ip_address": createdIpAddress,
        // "last_ip_address": lastIpAddress,
        // "сalled_by": calledBy,
        "user_code": userCode,
        "avatar": avatar.toJson(),
        "region": region.toJson(),
      };

  String get getPhotoUrl {
    if (avatar != null && avatar.path.isNotEmpty) {
      return avatar.path;
    } else {
      return globals.dummyAvatar + '?name=$name';
    }
  }
}

Future<dynamic> attemptLogIn(Map<String, dynamic> data) async {
  var url = globals.loginUrl;
  var api = new APIManager();

  // try {
  //   _deviceId = await PlatformDeviceId.getDeviceId;
  // } on PlatformException {
  //   _deviceId = 'Failed to get deviceId.';
  // }
  // data['user_code'] = _deviceId;

  return await api.postAPICall(url, data);
}

Future<dynamic> attemptRegister(Map<String, dynamic> data) async {
  var url = globals.registerUrl;
  var api = new APIManager();
  data['user_code'] = await globals.userCode();
  return await api.postAPICall(url, data);
}

// Future<String> attemptLogIn(Map<String, dynamic> data) async {
//   var res = await http.post(globals.loginUrl, body: data);
//   if (res.statusCode == 200) return res.body;
//   return null;
// }

// Future<User> fetchUser() async {
//   final response = await http.get(
//     'https://jsonplaceholder.typicode.com/albums/1',
//     headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
//   );
//   final responseJson = jsonDecode(response.body);
//
//   return Album.fromJson(responseJson);
// }
