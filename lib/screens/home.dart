import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/screens/home/_lenta.dart';
import 'package:meyirim/screens/home/reports.dart';
import 'package:meyirim/components/bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeStatefullWidgetState createState() => _HomeStatefullWidgetState();
}

class _HomeStatefullWidgetState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: HexColor('#F2F2F7'),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(120.0), // here the desired height
            child: AppBar(
              leading: Container(child: null),
              centerTitle: true,
              elevation: 0,
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
              bottom: TabBar(
                indicatorColor: Colors.white,
                labelStyle: TextStyle(fontSize: 14.0),
                // isScrollable: true,
                tabs: [
                  Tab(
                    text: 'Лента',
                  ),
                  Tab(
                    text: 'Завершенные',
                  ),
                  Tab(
                    text: 'Отчеты',
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
