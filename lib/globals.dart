import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:flutter_share/flutter_share.dart';
import 'package:meyirim/models/project.dart';

String apiUrl = 'http://10.0.2.2/api.meyirim/api';
String loginUrl = apiUrl+'/login';
String registerUrl = apiUrl+'/register';


final storage = new FlutterSecureStorage();



Map<String, dynamic> parseJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }
  print(payloadMap);
  return payloadMap;
}

bool jwtValidate(String token){
  var payload = parseJwt(token);
  return DateTime.fromMillisecondsSinceEpoch(payload["exp"]*1000).isAfter(DateTime.now());
}

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}

String makeProjectUrl(project){
  return '';
}


Future shareProject(Project project) async {
  await FlutterShare.share(
      title: project.title,
      text: project.description,
      linkUrl: makeProjectUrl(project),
      chooserTitle:  project.title);
}