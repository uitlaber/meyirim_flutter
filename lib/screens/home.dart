import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/screens/home/lenta.dart';
import 'package:meyirim/screens/home/reports.dart';
import 'package:meyirim/components/bottom_nav.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeStatefullWidgetState createState() => _HomeStatefullWidgetState();
}

class _HomeStatefullWidgetState extends State<HomeScreen> {
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
        Navigator.of(context).pushNamed(deepLink.queryParameters['page']);
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      Navigator.of(context).pushNamed(deepLink.queryParameters['page']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: HexColor('#F2F2F7'),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(120.0),
            child: AppBar(
              automaticallyImplyLeading: false,
              elevation: 2,
              shadowColor: HexColor('#069AFC'),
              centerTitle: true,
              title: Padding(
                padding: EdgeInsets.only(top: 21.0, bottom: 10.0),
                child: SizedBox(
                    height: 45,
                    child: Hero(
                      tag: 'logo',
                      child: Image.asset('assets/images/logo_main.png'),
                    )),
              ),
              backgroundColor: HexColor('#00D7FF'),
              // actions: [
              //   IconButton(
              //     icon: Icon(
              //       Icons.mail,
              //       color: Colors.white70,
              //     ),
              //   ),
              // ],
              bottom: TabBar(
                indicatorColor: Colors.white,
                labelPadding: EdgeInsets.only(left: 2, right: 2),
                labelStyle: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1),
                // isScrollable: true,
                tabs: [
                  Tab(
                    text: 'Лента'.toUpperCase(),
                  ),
                  Tab(
                    text: 'Завершенные'.toUpperCase(),
                  ),
                  Tab(
                    text: 'Отчеты'.toUpperCase(),
                  ),
                ],
              ),
            )),
        body: TabBarView(
          children: [
            LentaScreen(isFinished: 0),
            LentaScreen(isFinished: 1),
            ReportScreen(),
          ],
        ),
        extendBody: true,
        bottomNavigationBar: BottomNav(0),
      ),
    );
  }
}
