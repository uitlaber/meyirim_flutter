import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/screens/home/lenta.dart';
import 'package:meyirim/screens/home/complete.dart';
import 'package:meyirim/screens/home/reports.dart';

import '../app_localizations.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeStatefullWidgetState createState() => _HomeStatefullWidgetState();
}

class _HomeStatefullWidgetState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });

      if (_selectedIndex == 2) {
        Navigator.of(context).pushNamed('Login');
      }
    }

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
                  )
                ),
              ),
              backgroundColor: HexColor('#00D7FF'),
              bottom: TabBar(
                indicatorColor: Colors.white,
                labelStyle: TextStyle(fontSize: 14.0),
                // isScrollable: true,
                tabs: [
                  Tab(
                    text: AppLocalizations.of(context).translate('lenta'),
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
            LentaScreen(),
            CompleteScreen(),
            ReportScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: HexColor('#00D7FF'),
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Главная',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Поиск',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Профиль',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
