import 'dart:collection';

import 'package:flutter_share/flutter_share.dart';
import 'package:meyirim/models/project.dart';
import 'package:meyirim/models/report.dart';
import 'app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'helpers/auth.dart';
import 'models/region.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:directus/directus.dart';
import 'package:dio/dio.dart';

const String apiUrl = 'https://dev.meyirim.kz:8055';

const String siteUrl = 'https://dev.meyirim.kz';
const String loginUrl = apiUrl + '/login';
const String registerUrl = apiUrl + '/signup';
const String paymentUrl = apiUrl + '/payment/pay';
const String addIndigentUrl = apiUrl + '/indigent/store';
const String updateProfile = apiUrl + '/users/update';
const String checkAuth = apiUrl + '/check';
const String resetUrl = apiUrl + '/reset';

const String defaultToken = 'tokenuser';

var lastReset = null;

const String dummyAvatar = 'https://ui-avatars.com/api/';
const String dummyPhoto = 'https://via.placeholder.com/468x300?text=meyirim.kz';

/**
 * Initial data
 */

List<Region> regions;

Future<Directus> sdk() async {
  Map<String, String> headers = new HashMap();
  headers['Authorization'] = 'Bearer ' + defaultToken;
  final sdk = await Directus('https://dev.meyirim.kz').init();
  return sdk;
}

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

loadInitialData() async {
  SharedPreferences storage = await SharedPreferences.getInstance();
  try {
    regions = await fetchRegions(1);
    final String encodedData = Region.encode(regions);
    storage.setString('regions', encodedData);
  } catch (e) {
    throw 'Не удалось загрузить регионы';
  }
  authCheck();
}
