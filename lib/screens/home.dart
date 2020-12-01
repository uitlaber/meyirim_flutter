import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/screens/home/lenta.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeStatefullWidgetState createState() => _HomeStatefullWidgetState();
}


class _HomeStatefullWidgetState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    int _selectedIndex = 0;
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
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
                  padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
                  child: SizedBox(
                    height: 45,
                    child:  Image.asset('assets/images/logo.png'),
                  ),
                ),
                backgroundColor: HexColor('#00D7FF'),
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  // isScrollable: true,
                  tabs: [
                    Tab( text: 'Лента',),
                    Tab( text: 'Завершенные',),
                    Tab( text: 'Отчеты',),

                  ],
                ),
              )
          ),
          body: TabBarView(
            children: [
              LentaScreen(),
              LentaScreen(),
              LentaScreen(),
            ],
          ),
          bottomNavigationBar: new Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.white,
              primaryColor: Colors.green,
                textTheme: Theme
                    .of(context)
                    .textTheme
                    .copyWith(caption: new TextStyle(color: Colors.yellow)),
            ),
            child: BottomNavigationBar(
                selectedItemColor: Colors.red,

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
          )
      ),
    );
  }

}