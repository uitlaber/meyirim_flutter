import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/models/project.dart';
import 'package:meyirim/models/response.dart';
import 'package:meyirim/screens/project/card.dart';

import 'package:meyirim/helpers/api_manager.dart';
import 'package:meyirim/globals.dart' as global;
import 'dart:convert';

class LentaScreen extends StatefulWidget {
  int isFinished = 0;

  LentaScreen({this.isFinished});

  @override
  State<StatefulWidget> createState() {
    return LentaScreenState();
  }
}

class LentaScreenState extends State<LentaScreen> {
  ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  int _maxPage = 2;
  bool _isLoading = false;
  bool _hasError = false;
  List<Project> projects = [];
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
    if (_isLoading && projects.length == 0)
      return Center(
        child: new CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(HexColor('#00D7FF'))),
      );
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
    return (projects.length > 0)
        ? Container(
            child: ListView.builder(
            controller: _scrollController,
            itemCount: projects.length,
            itemBuilder: (BuildContext context, int index) {
              return ProjectCard(projects[index]);
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
      setState(() {
        _isLoading = true;
      });
      try {
        var result =
            await fetchProjects(page: _currentPage, status: widget.isFinished);
        List<Project> newProjects =
            List<Project>.from(result['data'].map((x) => Project.fromJson(x)));
        setState(() {
          _currentPage++;
          _maxPage = result['meta']['pagination']['total_pages'] + 1;
          projects.addAll(newProjects);
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
