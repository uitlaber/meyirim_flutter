import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class User {
  final int id;
  final String name;
  final String photo;
  final String phone;
  final String email;
  final String address;
  final bool isFond;

  User({this.id, this.name, this.photo, this.phone, this.email, this.address, this.isFond});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      photo: json['photo'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      isFond: (json['is_fond'] == '1')?true:false,
    );
  }
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