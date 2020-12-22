import 'package:flutter/material.dart';
import 'package:meyirim/models/project.dart';
import 'package:meyirim/screens/project/card.dart';
import 'file:///C:/Users/uitlaber/Desktop/meyirim_flutter/meyirim/lib/helpers/api_response.dart';
import 'dart:convert';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/components/bottom_nav.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:meyirim/helpers/api_manager.dart';

class SearchResult extends StatefulWidget {
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  String query;
  ScrollController _scrollController = ScrollController();
  TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;
  int _maxPage = 2;
  bool _isLoading = false;
  bool _hasError = false;
  List<Project> projects = [];
  //loadMore();

  @override
  void initState() {
    super.initState();
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
    return Scaffold(
      backgroundColor: HexColor('#F2F2F7'),
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        title: Container(
          height: 36,
          padding: EdgeInsets.only(
            left: 10.0,
          ),
          child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() => query = value);
                search();
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: HexColor('#00D7FF'),
                  ),
                  contentPadding: const EdgeInsets.symmetric(),
                  border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(30.0),
                      ),
                      borderSide: new BorderSide(color: Colors.transparent)),
                  enabledBorder: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(30.0),
                      ),
                      borderSide: new BorderSide(color: Colors.transparent)),
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey[600]),
                  hintText: "Поиск проектов ",
                  fillColor: Colors.white)),
        ),
        backgroundColor: HexColor('#00D7FF'),
        automaticallyImplyLeading: false,
        actions: [
          RawMaterialButton(
            constraints: BoxConstraints.tight(Size(36, 36)),
            onPressed: () => setState(() {
              query = '';
              _searchController.text = '';
            }),
            child: Icon(Icons.clear, size: 18),
            shape: new CircleBorder(side: BorderSide(color: Colors.white)),
            elevation: 0.0,
          ),
        ],
      ),
      body: Container(
        child: createListView(context),
      ),
      bottomNavigationBar: BottomNav(1),
    );
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
    if (query?.isEmpty ?? true) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            color: Colors.grey,
            size: 44,
          ),
          Text(
            'Введите наименование проекта, \nили текст',
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ));
    }
    if (_isLoading) {
      return Center(
        child: new CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(HexColor('#00D7FF'))),
      );
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
        : Container(
            child: Center(
                child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 5,
            children: [
              Icon(
                Icons.search_off_outlined,
                color: Colors.grey,
                size: 44,
              ),
              Text(
                'Проекты не найдены',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          )));
  }

  search() async {
    if (query?.isEmpty ?? true) {
      setState(() {
        projects = [];
        _isLoading = false;
        _currentPage = 1;
      });
      return;
    }

    if (!_isLoading) {
      setState(() {
        _hasError = false;
        _isLoading = true;
        _currentPage = 1;
      });

      try {
        var result = await searchProjects(page: _currentPage, query: query);
        List<Project> newProjects =
            List<Project>.from(result['data'].map((x) => Project.fromJson(x)));

        setState(() {
          _currentPage++;
          _maxPage = result['meta']['pagination']['total_pages'];
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

  loadMore() async {
    if (!_isLoading && _maxPage > _currentPage) {
      setState(() => _isLoading = true);
      try {
        var result = await searchProjects(page: _currentPage, query: query);

        ApiResponse response = ApiResponse.fromJson(result);

        List<Project> newProjects =
            List<Project>.from(response.data.map((x) => Project.fromJson(x)));

        // print(newProjects);
        setState(() {
          _currentPage++;
          _maxPage = 3;
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
