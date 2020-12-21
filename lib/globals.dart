import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:meyirim/models/project.dart';
import 'package:meyirim/models/report.dart';
import 'app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

// const String apiUrl = 'http://192.168.1.4/api.meyirim/api';
const String apiUrl = 'http://10.0.2.2/api.meyirim/api';
const String siteUrl = 'http://meyirim.com';
const String loginUrl = apiUrl + '/login';
const String registerUrl = apiUrl + '/signup';
const String paymentUrl = apiUrl + '/pay';
const String dummyAvatar = 'https://ui-avatars.com/api/';
const String dummyPhoto = 'https://via.placeholder.com/468x300?text=meyirim.kz';

/// Уникальный код пользователя
Future<String> userCode() async {
  var userCode = await storage.read(key: "user_code");
  if (userCode?.isEmpty ?? true) {
    var uuid = Uuid();
    userCode = uuid.v1();
    await storage.write(key: "user_code", value: userCode);
  }
  return userCode;
}

/// Форматирование суммы
String formatCur(dynamic amount) {
  return new NumberFormat.currency(symbol: '₸', decimalDigits: 0, locale: 'kk')
      .format(amount);
}

/// Форматирование цифр
String formatNum(dynamic amount) {
  return new NumberFormat.compact(locale: 'kk').format(amount);
}

/// Безопасное хранилище
final storage = new FlutterSecureStorage();

/// Первод текста из папки /lang
String _t(String text, BuildContext context) {
  return AppLocalizations.of(context).translate(text);
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
