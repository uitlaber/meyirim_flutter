import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';

import 'package:meyirim/models/report.dart';

import 'package:meyirim/components/loading.dart';
import 'package:meyirim/components/message.dart';
import 'package:meyirim/screens/report/info.dart';

class ReportScreen extends StatefulWidget {
  final Map params;

  const ReportScreen(this.params);

  @override
  State<StatefulWidget> createState() {
    return ReportScreenState();
  }
}

class ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#F2F2F7'),
        appBar: AppBar(
            backgroundColor: HexColor('#00D7FF'),
            titleSpacing: 0,
            elevation: 0),
        body: Container(
            child: FutureBuilder<Report>(
                future: findReport(widget.params['id']),
                builder:
                    (BuildContext context, AsyncSnapshot<Report> snapshot) {
                  Widget body;
                  if (snapshot.hasData) {
                    body = ReportInfo(snapshot.data);
                  } else if (snapshot.hasError) {
                    // Navigator.of(context).pushNamed('Home');
                    body = Message('Отчет не найден');
                  } else {
                    body = Loading();
                  }
                  return body;
                })));
  }
}
