import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:meyirim/globals.dart' as globals;
import 'package:http/http.dart' as http;

class City {

  final int cityId;
  final String name;
  final int parentId;

  City({this.cityId, this.name, this.parentId});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      cityId: json['id'],
      name: json['name'],
      parentId: json['parent_id'],
    );
  }

}

Future<City> findCity(int cityId) async {
  final response =  await http.get(
    globals.apiUrl+"/city/${cityId}",
    // headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
  );
  final responseJson = jsonDecode(response.body);
  return City.fromJson(responseJson);
}