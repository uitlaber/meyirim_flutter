import 'package:flutter_share/flutter_share.dart';
import 'package:meyirim/models/project.dart';
import 'package:meyirim/models/report.dart';
import 'app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'helpers/auth.dart';

const String apiUrl = 'https://dev.meyirim.kz/api';
// const String apiUrl = 'http://10.0.2.2/api.meyirim/api';
const String siteUrl = 'https://dev.meyirim.kz';
const String loginUrl = apiUrl + '/login';
const String registerUrl = apiUrl + '/signup';
const String paymentUrl = apiUrl + '/payment/pay';
const String addIndigentUrl = apiUrl + '/indigent/store';

const String dummyAvatar = 'https://ui-avatars.com/api/';
const String dummyPhoto = 'https://via.placeholder.com/468x300?text=meyirim.kz';

/// Уникальный код пользователя
// Future<String> userCode() async {
//   SharedPreferences storage = await SharedPreferences.getInstance();
//   var userCode = await storage.get("user_code");
//   if (userCode?.isEmpty ?? true) {
//     var uuid = Uuid();
//     userCode = uuid.v1();
//     await storage.setString("user_code", userCode);
//   }
//   return userCode;
// }

/// Форматирование суммы
String formatCur(dynamic amount) {
  return new NumberFormat.currency(symbol: '₸', decimalDigits: 0, locale: 'kk')
      .format(amount);
}

String formatDate(DateTime date, {String format: 'dd-MM-yyyy'}) {
  final DateFormat formatter = DateFormat(format);
  return formatter.format(date);
}

/// Форматирование цифр
String formatNum(dynamic amount) {
  return new NumberFormat.compact(locale: 'kk').format(amount);
}

/// Первод текста из папки /lang
String _t(String text, BuildContext context) {
  return AppLocalizations.of(context).translate(text);
}

Future<String> makeReportUrl(report) async {
  String url = await _createDynamicLink(
      siteUrl +
          '?page=Report/' +
          report.id.toString() +
          '&user_code=' +
          await userCode(),
      true);
  return url;
}

Future<String> makeProjectUrl(project) async {
  String url = await _createDynamicLink(
      siteUrl +
          '?page=Project/' +
          project.id.toString() +
          '&user_code=' +
          await userCode(),
      true);
  return url;
}

Future shareReport(Report report) async {
  await FlutterShare.share(
      title: report.title,
      text: report.description.length > 50
          ? report.description
              .replaceRange(50, report.description.length, '...')
          : report.description.length,
      linkUrl: await makeReportUrl(report),
      chooserTitle: report.title);
}

Future shareProject(Project project) async {
  await FlutterShare.share(
      title: project.title,
      text: project.description.length > 50
          ? project.description
              .replaceRange(50, project.description.length, '...')
          : project.description,
      linkUrl: await makeProjectUrl(project),
      chooserTitle: project.title);
}

Future<String> _createDynamicLink(String link, bool short) async {
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: 'https://beyit.page.link',
    link: Uri.parse(link),
    androidParameters: AndroidParameters(
      packageName: 'com.beyit.meyirim',
      minimumVersion: 0,
    ),
    dynamicLinkParametersOptions: DynamicLinkParametersOptions(
      shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
    ),
    iosParameters: IosParameters(
      bundleId: 'com.beyit.meyirim',
      minimumVersion: '0',
    ),
  );

  Uri url;
  if (short) {
    final ShortDynamicLink shortLink = await parameters.buildShortLink();
    url = shortLink.shortUrl;
  } else {
    url = await parameters.buildUrl();
  }

  return url.toString();
}
