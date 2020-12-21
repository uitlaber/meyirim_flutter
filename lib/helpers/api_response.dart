// import 'dart:convert';
// import 'package:http/http.dart' as http;
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'globals.dart' as globals;

class ApiResponse {
  ApiResponse({this.data, this.meta});

  var meta;
  var data;

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      ApiResponse(data: json["data"], meta: json["meta"]);

  Map<String, dynamic> toJson() => {
        "data": data,
        "meta": meta,
        // // "data": List<dynamic>.from(data.map((x) => x.toJson())),
        // "data": firstPageUrl,
      };
}
