import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:meyirim/app_localizations.dart';
import 'package:meyirim/screens/home.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/reset.dart';
import 'screens/home.dart';
import 'package:splashscreen/splashscreen.dart';
import 'helpers/hex_color.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meyirim/globals.dart';




void main()  {

  runApp(MyApp());
}

class MyApp extends StatelessWidget  {



  @override
  Widget build(BuildContext context)  {
    return MaterialApp(
        title: 'Named Routes Demo',
        // initialRoute: 'Home',
        home:   new SplashScreen(
        seconds: 5,
        navigateAfterSeconds: 'Home',
        image: new Image.asset('assets/images/logo.png'),
        backgroundColor: HexColor("#00D7FF"),
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 130.0,
        onClick: () => print("Flutter Egypt"),
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
        onGenerateRoute: (RouteSettings routeSettings)  {

          return new PageRouteBuilder<dynamic>  (
              settings: routeSettings,
              pageBuilder:  (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation)   {
                switch (routeSettings.name) {
                  case 'Home':
                    return HomeScreen();
                  case 'Login':
                    return LoginScreen();
                  case 'Register':
                    return RegisterScreen();
                  case 'Reset':
                    return ResetScreen();
                  default:
                    return null;
                }
              },
              transitionDuration: const Duration(milliseconds: 500),
              transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) {
                return effectMap[PageTransitionType.transferRight](
                    Curves.linear, animation, secondaryAnimation, child);
              });
        }
    );
  }
  // @override
  // _MyAppState createState() => new _MyAppState();
}

// class _MyAppState extends State<MyApp> {
//   @override
//    Widget build(BuildContext context) {
//
//    }
// }


