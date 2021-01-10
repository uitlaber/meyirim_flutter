import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/models/project.dart';
import 'package:meyirim/screens/project/card.dart';
import 'package:dio/dio.dart';
import 'package:directus/directus.dart';
import 'package:meyirim/globals.dart' as globals;
import 'package:directus/src/data_classes/one_query.dart';

// ignore: must_be_immutable
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
              return ProjectCard(project: projects[index]);
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
        final sdk = await globals.sdk();

        final result = await sdk.items('projects').readMany(
            query: Query(limit: 5, offset: 0, fields: ['*.*']),
            filters: Filters({'is_finished': Filter.eq(widget.isFinished)}));
        List<Project> newProjects;
        result.data.forEach((item) {
          //Project project = Project.fromJson(item);
          //print(project);
          // newProjects.add(Project.fromJson(project));
          item.forEach((key, value) {
            if (key == 'fond_id') {
              print(value);
            }
          });
        });

        setState(() {
          _currentPage++;
          projects.addAll(newProjects);
          _isLoading = false;
        });
      } catch (e) {
        print(e);
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }
  }
}
