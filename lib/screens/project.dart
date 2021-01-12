import 'dart:async';
import 'dart:convert';
import 'package:directus/directus.dart';
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
  bool _isLoading = false;
  bool _hasError = false;
  Project project;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findProject(widget.params['id']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F2F2F7'),
      appBar: AppBar(
          backgroundColor: HexColor('#00D7FF'),
          title: Text('Проект'),
          elevation: 0),
      body: Container(
          child: (_isLoading)
              ? Loading()
              : (_hasError)
                  ? Message('Проект не найден')
                  : ProjectInfo(project)),
    );
  }

  Future<Project> findProject(int id) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final sdk = await globals.sdk();
      final result = await sdk
          .items('projects')
          .readOne(id.toString(), query: Query(fields: ['*.*']));
      setState(() {
        _isLoading = false;
        project = Project.fromJson(result.data);
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }
}
