import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:meyirim/screens/home.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/reset.dart';
import 'screens/home.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'helpers/hex_color.dart';

void main() {
  runApp(MaterialApp(
      title: 'Named Routes Demo',
      // initialRoute: 'Home',
      home: new MyApp(),
      onGenerateRoute: (RouteSettings routeSettings) {
        return new PageRouteBuilder<dynamic>(
            settings: routeSettings,
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
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
              return effectMap[PageTransitionType.transferUp](
                  Curves.linear, animation, secondaryAnimation, child);
            });
      }));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 5,
        navigateAfterSeconds: 'Home',
        image: new Image.asset('assets/images/logo.png'),
        backgroundColor: HexColor("#00D7FF"),
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 130.0,
        onClick: () => print("Flutter Egypt"),
        loaderColor: Colors.white);
  }
}
