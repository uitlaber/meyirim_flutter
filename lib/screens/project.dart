import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'payment_popup.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:meyirim/models/project.dart';

import 'package:meyirim/components/loading.dart';
import 'package:meyirim/components/message.dart';
import 'package:meyirim/screens/project/info.dart';
import 'package:meyirim/globals.dart' as globals;

class ProjectScreen extends StatefulWidget {
  final Map params;

  const ProjectScreen(this.params);

  @override
  State<StatefulWidget> createState() {
    return ProjectScreenState();
  }
}

class ProjectScreenState extends State<ProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#F2F2F7'),
        appBar: AppBar(
            backgroundColor: HexColor('#00D7FF'),
            title: Text('Проект'),
            elevation: 0),
        body: Container(
            child: FutureBuilder<Project>(
                future: findProject(widget.params['id']),
                builder:
                    (BuildContext context, AsyncSnapshot<Project> snapshot) {
                  Widget body;
                  // print(snapshot.data);
                  if (snapshot.hasData) {
                    body = ProjectInfo(snapshot.data);
                  } else if (snapshot.hasError) {
                    // Navigator.of(context).pushNamed('Home');
                    body = Message('Проект не найден');
                  } else {
                    body = Loading();
                  }
                  return body;
                })));
  }

  Future<Project> findProject(String id) async {
    try {
      final sdk = await globals.sdk();
      final result = await sdk.items('projects').readOne(id);
      return Project.fromJson(result.data);
    } catch (e) {
      print(e);
    }
  }
}
