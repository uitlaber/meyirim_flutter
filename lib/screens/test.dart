import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

import 'home/lenta.dart';
import 'home/reports.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final controller = ScrollController();

  bool notification = false;

  @override
  void initState() {
    super.initState();
    notification = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: ScrollAppBar(
            controller: controller, // Note the controller here
            title: Text("App Bar"),
            actions: [
              IconButton(
                icon: Icon(
                  notification ? Icons.notifications : Icons.notifications_off,
                ),
                onPressed: () {
                  setState(() => notification = !notification);
                },
              ),
            ],
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
          ),
          body: Snap(
            controller: controller.appBar,
            child: TabBarView(
              children: [
                LentaScreen(isFinished: 0),
                LentaScreen(isFinished: 1),
                ReportScreen(),
              ],
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Widget _listBuildItem(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50),
      color: Colors.red,
      child: Center(child: Text("$index")),
    );
  }
}
