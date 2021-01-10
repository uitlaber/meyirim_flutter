import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/models/project.dart';
import 'package:meyirim/screens/project/card.dart';
import 'package:meyirim/components/fond_card.dart';
import 'package:meyirim/models/user.dart';

// ignore: must_be_immutable
class FondScreen extends StatefulWidget {
  bool isFinished = false;
  int fondId;

  FondScreen({Key key, this.isFinished, this.fondId}) : super(key: key);

  @override
  _FondScreenState createState() => _FondScreenState();
}

class _FondScreenState extends State<FondScreen> {
  ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  int _maxPage = 2;
  bool _isLoading = false;
  bool _hasError = false;
  List<Project> projects = [];
  User fond;

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
    return Scaffold(
        backgroundColor: HexColor('#F2F2F7'),
        appBar: AppBar(
            backgroundColor: HexColor('#00D7FF'),
            title: Text('Все активные проекты фонда'),
            titleSpacing: 0,
            elevation: 0),
        body: SafeArea(
            child: (_isLoading && projects.length == 0)
                ? Center(
                    child: new CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(HexColor('#00D7FF'))),
                  )
                : ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: FondCard(fond: fond),
                      ),
                      createListView(context)
                    ],
                  )));
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
        ? ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: projects.length,
            itemBuilder: (BuildContext context, int index) {
              return ProjectCard(
                project: projects[index],
                hideFond: true,
              );
            },
          )
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
        if (fond == null) {
          User resultFond = await fetchUser(widget.fondId);
          setState(() {
            fond = resultFond;
          });
        }
        // var result = await fetchProjects(
        //     page: _currentPage,
        //     status: widget.isFinished,
        //     fondId: widget.fondId);
        //
        // List<Project> newProjects = List<Project>.from(result['data'].map((x) {
        //   // print(x.runtimeType);
        //   // x.forEach((k, v) => print('${k}: ${v.runtimeType}'));
        //   return Project.fromJson(x);
        // }));
        //
        // setState(() {
        //   _currentPage++;
        //   _maxPage = result['meta']['pagination']['total_pages'] + 1;
        //   projects.addAll(newProjects);
        //   _isLoading = false;
        // });
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
