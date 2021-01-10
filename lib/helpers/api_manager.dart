import 'dart:collection';

import 'package:meyirim/exeptions/exeptions.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:meyirim/globals.dart' as globals;
import 'auth.dart' as auth;
import 'package:async/async.dart';
import 'package:dio/dio.dart';

class APIManager {
  Future<dynamic> postAPICall(String url, dynamic param) async {
    print("Calling API: $url");
    print("Calling parameters: $param");
    Map<String, String> headers = new HashMap();
    headers['user-code'] = await auth.userCode();
    headers['Authorization'] = 'Bearer ' + await auth.jwtOrEmpty();
    print("Calling headers: $headers");

    var response;
    try {
      response = await Dio()
          .post(url, data: param, options: Options(headers: headers));
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return _response(response);
  }

  Future<dynamic> getAPICall(String url) async {
    var userCode = await auth.userCode();
    var token = await auth.jwtOrEmpty();
    Map<String, String> headers = new HashMap();
    headers['user-code'] = userCode;
    headers['Authorization'] = 'Bearer ' + token;
    print("Calling API: $url");
    print("Calling headers: $headers");
    Response response = await Dio().get(
      url,
      options: Options(headers: headers),
    );
    return _response(response);
  }

  dynamic _response(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.data.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
