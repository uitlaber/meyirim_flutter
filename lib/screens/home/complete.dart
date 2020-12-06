import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/models/project.dart';
import 'package:meyirim/screens/project/card.dart';
import '../payment_popup.dart';
import 'package:flutter_share/flutter_share.dart';

class CompleteScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CompleteScreenState();
  }
}

class CompleteScreenState extends State<CompleteScreen> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchFinishedProjects(),
        builder: (BuildContext context, AsyncSnapshot<List<Project>> snapshot) {
          if (snapshot.hasData){
            var projects = snapshot.data;
            if(projects.length > 0) {
              return Container(
                  child: ListView.builder(
                    itemCount: projects.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProjectCard(projects[index]);
                    },
                  )
              );
            }else{
              return Center(
                  child: Text('Проекты не найдены'),
              );
            }
          }else{
            return Center(
              child: Text('Загрузка...'),
            );
          }
        }
    );

  }
}
