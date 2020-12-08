import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:flutter_share/flutter_share.dart';
import 'package:meyirim/models/project.dart';
import 'package:meyirim/models/report.dart';
import 'app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// String apiUrl = 'http://10.0.2.2/api.meyirim/api';
String apiUrl = 'http://192.168.1.4/api.meyirim/api';
String loginUrl = apiUrl + '/login';
String registerUrl = apiUrl + '/register';
String siteUrl = 'http://meyirim.com';

String formatCur(dynamic amount) {
  return new NumberFormat.currency(symbol: '₸', decimalDigits: 0, locale: 'kk')
      .format(amount);
}

String formatNum(dynamic amount) {
  return new NumberFormat.compact(locale: 'kk').format(amount);
}

final storage = new FlutterSecureStorage();

String _t(String text, BuildContext context) {
  return AppLocalizations.of(context).translate(text);
}

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

bool jwtValidate(String token) {
  var payload = parseJwt(token);
  return DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
      .isAfter(DateTime.now());
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

String makeProjectUrl(project) {
  return '';
}

Future shareReport(Report report) async {
  await FlutterShare.share(
      title: report.title,
      text: report.description,
      linkUrl: siteUrl + '/report/' + report.id.toString(),
      chooserTitle: report.title);
}

Future shareProject(Project project) async {
  await FlutterShare.share(
      title: project.title,
      text: project.description,
      linkUrl: makeProjectUrl(project),
      chooserTitle: project.title);
}
