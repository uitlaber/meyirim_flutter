import 'dart:collection';

import 'package:meyirim/exeptions/exeptions.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:meyirim/globals.dart' as globals;

class APIManager {
  Future<dynamic> postAPICall(String url, dynamic param) async {
    print("Calling API: $url");
    print("Calling parameters: $param");

    Map<String, String> headers = new HashMap();

    var userCode = await globals.userCode();
    var token = await globals.jwtOrEmpty();

    headers['user-code'] = userCode;
    headers['token'] = token;

    print("Calling headers: $headers");

    var response;
    try {
      response = await http.post(url, body: param);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return response;
  }

  Future<dynamic> getAPICall(String url) async {
    print("Calling API: $url");

    var response;
    try {
      response = await http.get(url);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return response;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
