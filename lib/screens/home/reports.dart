import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/models/project.dart';
import 'package:meyirim/models/report.dart';
import 'package:meyirim/screens/report/card.dart';
import 'package:meyirim/api_response.dart';
import 'package:meyirim/helpers/api_manager.dart';
import 'package:meyirim/globals.dart' as global;
import 'dart:convert';

class ReportScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ReportScreenState();
  }
}

class ReportScreenState extends State<ReportScreen> {
  ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  int _maxPage = 2;
  bool _isLoading = false;
  bool _hasError = false;
  List<Report> reports = [];
  //loadMore();

  @override
  void initState() {
    super.initState();
    loadMore();
    _scrollController
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          loadMore();
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return createListView(context);
  }

  Widget createListView(BuildContext context) {
    if (_hasError) {
      return Center(
          child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 5,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.grey,
            size: 44,
          ),
          Text(
            'Ошибка при загрузке,\nпожалуйста проверьте интернет',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ));
    }
    return (reports.length > 0)
        ? Container(
            child: ListView.builder(
            controller: _scrollController,
            itemCount: reports.length,
            itemBuilder: (BuildContext context, int index) {
              return ReportCard(reports[index]);
            },
          ))
        : Center(
            child: new CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(HexColor('#00D7FF'))),
          );
  }

  loadMore() async {
    if (!_isLoading) {
      setState(() => _isLoading = true);
      fetchReports(page: _currentPage).then((value) {
        switch (value.statusCode) {
          case 200:
            ApiResponse response = ApiResponse.fromJson(jsonDecode(value.body));
            List<Report> results =
                List<Report>.from(response.data.map((x) => Report.fromJson(x)));
            setState(() {
              _currentPage++;
              _maxPage = response.lastPage;
              reports.addAll(results);
              _isLoading = false;
            });
            break;
          default:
            setState(() => _isLoading = false);
        }
      }, onError: (error) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
        print("Error == $error");
      });
    }
  }
}
