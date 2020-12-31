import 'package:flutter/material.dart';
import 'package:meyirim/app_localizations.dart';
import 'package:meyirim/screens/home.dart';
import 'package:meyirim/screens/project.dart';
import 'package:meyirim/screens/report.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/reset.dart';
import 'screens/home.dart';
import 'screens/profile.dart';
import 'screens/donations.dart';
import 'screens/project.dart';
import 'screens/search.dart';
import 'screens/add_indigent.dart';
import 'package:splashscreen/splashscreen.dart';
import 'helpers/hex_color.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    initDynamicLinks();
  }

  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        print(deepLink);
        // Navigator.pushNamed(context, deepLink.path);
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      print(deepLink);
      //Navigator.pushNamed(context, deepLink.path);
    }
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
                  case 'Project':
                    return new ProjectScreen(arguments);
                  case 'Report':
                    return new ReportScreen(arguments);
                  case 'Login':
                    return LoginScreen();
                  case 'Register':
                    return RegisterScreen();
                  case 'Reset':
                    return ResetScreen();
                  case 'AddIndigent':
                    return AddIndigentScreen();
                  default:
                    return null;
                }
              },
              transitionDuration: const Duration(milliseconds: 200),
              transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) {
                switch (routeSettings.name) {
                  case 'Project':
                    return effectMap[PageTransitionType.slideInLeft](
                        Curves.linear, animation, secondaryAnimation, child);
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
