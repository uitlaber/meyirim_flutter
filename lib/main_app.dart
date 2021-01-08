import 'package:flutter/material.dart';
import 'package:meyirim/app_localizations.dart';
import 'package:meyirim/screens/home.dart';
import 'package:meyirim/screens/project.dart';
import 'package:meyirim/screens/report.dart';
import 'package:meyirim/screens/success.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/reset.dart';
import 'screens/home.dart';
import 'screens/profile.dart';
import 'screens/donations.dart';
import 'screens/project.dart';
import 'screens/fond.dart';
import 'screens/search.dart';
import 'screens/test.dart';
import 'screens/add_indigent.dart';
import 'package:splashscreen/splashscreen.dart';
import 'helpers/hex_color.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'screens/update_profile.dart';
import 'globals.dart' as globals;

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    globals
        .loadInitialData(); // continue your work in the `fetchSavedItemNo` function
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Meyirim',
        home: new SplashScreen(
            seconds: 5,
            navigateAfterSeconds: 'Home',
            image: new Image.asset('assets/images/logo.png'),
            backgroundColor: HexColor("#00D7FF"),
            styleTextUnderTheLoader: new TextStyle(),
            photoSize: 130.0,
            useLoader: false,
            loaderColor: Colors.white),

        //Поддерживаемые языки
        supportedLocales: [
          const Locale('kk', 'KZ'),
          const Locale('ru', 'RU'),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],

        //Язык по умолчанию
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        onGenerateRoute: (RouteSettings routeSettings) {
          // MaterialPageRoute _buildRoute(
          //     RouteSettings settings, Widget builder) {
          //   return new MaterialPageRoute(
          //     settings: settings,
          //     builder: (ctx) => builder,
          //   );
          // }

          return new PageRouteBuilder<dynamic>(
              settings: routeSettings,
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                final dynamic arguments = routeSettings.arguments;

                final List<String> path = routeSettings.name.split('/');

                if (path[0] != '') {
                  if (path[0].startsWith('Project')) {
                    Map params = {'id': int.parse(path[1])};
                    return new ProjectScreen(params);
                  }
                  if (path[0].startsWith('Report')) {
                    Map params = {'id': int.parse(path[1])};
                    return new ReportScreen(params);
                  }

                  if (path[0].startsWith('Fond')) {
                    return new FondScreen(
                        fondId: int.parse(path[1]), isFinished: 0);
                  }
                }

                switch (routeSettings.name) {
                  case 'Home':
                    return HomeScreen();
                  case 'Search':
                    return SearchScreen();
                  case 'Profile':
                    return ProfileScreen();
                  case 'Donations':
                    return DonationsScreen(isReferal: false);
                  case 'Referals':
                    return DonationsScreen(isReferal: true);
                  case 'Login':
                    return LoginScreen();
                  case 'Register':
                    return RegisterScreen();
                  case 'Reset':
                    return ResetScreen();
                  case 'AddIndigent':
                    return AddIndigentScreen();
                  case 'UpdateProfile':
                    return UpdateProfileScreen();
                  case 'Success':
                    return SuccessScreen(
                      title: 'Спасибо',
                      message: 'Ваша оплата успешно отправлено',
                    );
                  default:
                    return Container();
                }

                // case 'Project':
                // return new ProjectScreen(arguments);
                // case 'Report':
                // return new ReportScreen(arguments);
              },
              transitionDuration: const Duration(milliseconds: 200),
              transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) {
                final List<String> path = routeSettings.name.split('/');
                if (path[0] != '') {
                  if (path[0].startsWith('Project')) {
                    return effectMap[PageTransitionType.slideInLeft](
                        Curves.linear, animation, secondaryAnimation, child);
                  }
                  if (path[0].startsWith('Report')) {
                    return effectMap[PageTransitionType.slideInLeft](
                        Curves.linear, animation, secondaryAnimation, child);
                  }
                }

                switch (routeSettings.name) {
                  case 'Donations':
                    return effectMap[PageTransitionType.slideInLeft](
                        Curves.linear, animation, secondaryAnimation, child);
                  case 'Referals':
                    return effectMap[PageTransitionType.slideInLeft](
                        Curves.linear, animation, secondaryAnimation, child);
                  default:
                    return effectMap[PageTransitionType.fadeIn](
                        Curves.linear, animation, secondaryAnimation, child);
                }
              });
        });
  }
}
