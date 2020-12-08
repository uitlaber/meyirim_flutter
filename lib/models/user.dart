import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'file.dart';
import 'region.dart';

import 'package:http/http.dart' as http;

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.permissions,
    this.isActivated,
    this.activatedAt,
    this.lastLogin,
    this.createdAt,
    this.updatedAt,
    this.username,
    this.surname,
    this.deletedAt,
    this.lastSeen,
    this.isGuest,
    this.isSuperuser,
    this.createdIpAddress,
    this.lastIpAddress,
    this.calledBy,
    this.userCode,
    this.avatar,
    this.region
  });

  int id;
  dynamic name;
  String email;
  dynamic permissions;
  bool isActivated;
  DateTime activatedAt;
  dynamic lastLogin;
  DateTime createdAt;
  DateTime updatedAt;
  String username;
  dynamic surname;
  dynamic deletedAt;
  dynamic lastSeen;
  int isGuest;
  int isSuperuser;
  dynamic createdIpAddress;
  dynamic lastIpAddress;
  dynamic calledBy;
  dynamic userCode;
  File avatar;
  Region region;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    permissions: json["permissions"],
    isActivated: json["is_activated"],
    activatedAt: DateTime.parse(json["activated_at"]),
    lastLogin: json["last_login"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    username: json["username"],
    surname: json["surname"],
    deletedAt: json["deleted_at"],
    lastSeen: json["last_seen"],
    isGuest: json["is_guest"],
    isSuperuser: json["is_superuser"],
    createdIpAddress: json["created_ip_address"],
    lastIpAddress: json["last_ip_address"],
    calledBy: json["сalled_by"],
    userCode: json["user_code"],
    avatar: File.fromJson(json["avatar"]),
    region: Region.fromJson(json["region"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "permissions": permissions,
    "is_activated": isActivated,
    "activated_at": activatedAt.toIso8601String(),
    "last_login": lastLogin,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "username": username,
    "surname": surname,
    "deleted_at": deletedAt,
    "last_seen": lastSeen,
    "is_guest": isGuest,
    "is_superuser": isSuperuser,
    "created_ip_address": createdIpAddress,
    "last_ip_address": lastIpAddress,
    "сalled_by": calledBy,
    "user_code": userCode,
    "avatar": avatar.toJson(),
    "region": region.toJson(),

  };
}

// Future<User> fetchUser() async {
//   final response = await http.get(
//     'https://jsonplaceholder.typicode.com/albums/1',
//     headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
//   );
//   final responseJson = jsonDecode(response.body);
//
//   return Album.fromJson(responseJson);
// }