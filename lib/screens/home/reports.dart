import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/models/project.dart';
import 'package:meyirim/models/report.dart';
import 'package:meyirim/screens/report/card.dart';
import 'file:///C:/Users/uitlaber/Desktop/meyirim_flutter/meyirim/lib/helpers/api_response.dart';
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
    if (_isLoading && reports.length == 0) {
      return Center(
        child: new CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(HexColor('#00D7FF'))),
      );
    }
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
        : !_isLoading
            ? Center(
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
                    'Список пуст',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ))
            : Container();
  }

  loadMore() async {
    if (!_isLoading && _maxPage > _currentPage) {
      setState(() => _isLoading = true);
      try {
        var result = await fetchReports(page: _currentPage);

        List<Report> results =
            List<Report>.from(result['data'].map((x) => Report.fromJson(x)));
        setState(() {
          _currentPage++;
          _maxPage = result['meta']['pagination']['total_pages'] + 1;
          reports.addAll(results);
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }
  }
}
