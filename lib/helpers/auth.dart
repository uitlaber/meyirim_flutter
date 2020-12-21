import 'package:meyirim/globals.dart' as globals;
import 'dart:convert';
import 'package:meyirim/models/user.dart';
import 'package:uuid/uuid.dart';
import 'api_manager.dart';

User userData;

/// Уникальный код пользователя
Future<String> userCode() async {
  var userCode = await globals.storage.read(key: "user_code");
  if (userCode?.isEmpty ?? true) {
    var uuid = Uuid();
    userCode = uuid.v1();
    await globals.storage.write(key: "user_code", value: userCode);
  }
  return userCode;
}

/// Парсинг токена
Map<String, dynamic> parseJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    userData = null;
    throw Exception('invalid payload');
  }
  return payloadMap;
}

/// Парсинг токена на валидность
bool jwtValidate(String token) {
  var payload = parseJwt(token);
  return DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
      .isAfter(DateTime.now());
}

/// Возвращаем токен из хранилищ
Future<String> jwtOrEmpty() async {
  var jwt = await globals.storage.read(key: "jwt");
  if (jwt == null) return "";
  return jwt;
}

/// Проверка авторизации
Future<bool> authCheck() async {
  String jwt = await jwtOrEmpty();
  var result = jwtValidate(jwt);
  if (result == null) return false;
  return result;
}

Future<dynamic> attemptLogIn(Map<String, dynamic> data) async {
  var url = globals.loginUrl;
  var api = new APIManager();
  return await api.postAPICall(url, data);
}

Future<dynamic> attemptRegister(Map<String, dynamic> data) async {
  var url = globals.registerUrl;
  var api = new APIManager();
  data['user_code'] = await globals.userCode();
  return await api.postAPICall(url, data);
}

/// Выход
void logout() async {
  await globals.storage.delete(key: 'jwt');
  userData = null;
}

/// Расшифровка токена
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