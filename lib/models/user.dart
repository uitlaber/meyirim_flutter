import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'file.dart';
import 'region.dart';
import 'package:meyirim/globals.dart' as globals;
import 'package:meyirim/helpers/api_manager.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User(
      {this.firstName,
      this.description,
      this.lastName,
      this.phone,
      this.title,
      this.id,
      this.email,
      this.avatar,
      this.userCode,
      this.region});

  dynamic firstName;
  dynamic description;
  dynamic lastName;
  String phone;
  String title;
  String id;
  String email;
  File avatar;
  String userCode;
  Region region;

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["first_name"],
        description: json["description"],
        lastName: json["last_name"],
        phone: json["phone"],
        title: json["title"],
        id: json["id"],
        email: json["email"],
        avatar: File.fromJson(json["avatar"]),
        userCode: json["user_code"],
        region: Region.fromJson(json["region_id"]),
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "description": description,
        "last_name": lastName,
        "phone": phone,
        "title": title,
        "id": id,
        "email": email,
        "avatar": avatar.toJson(),
        "user_code": userCode,
        "region": region.toJson(),
      };

  get getAvatar {
    if (avatar != null) {
      return globals.apiUrl + '/assets/' + avatar.directusFilesId;
    } else {
      return globals.dummyPhoto + '&id=${this.id}';
    }
  }
}

Future<User> fetchUser(int fondId) async {
  var url = globals.apiUrl + "/fonds/$fondId";
  var api = new APIManager();
  var result = await api.getAPICall(url);
  return User.fromJson(result);
}
