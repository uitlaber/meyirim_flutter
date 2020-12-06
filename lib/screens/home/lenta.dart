import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/models/project.dart';
import 'package:meyirim/screens/project/card.dart';
import '../payment_popup.dart';
import 'package:flutter_share/flutter_share.dart';

class LentaScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LentaScreenState();
  }
}

class LentaScreenState extends State<LentaScreen> {

  @override
  Widget build(BuildContext context) {

    final GlobalKey<AnimatedListState> _key = GlobalKey();
    return FutureBuilder(
        future: fetchActiveProjects(),
        builder: (BuildContext context, AsyncSnapshot<List<Project>> snapshot) {
          if (snapshot.hasData){
            var projects = snapshot.data;
            return Container(
                child: ListView.builder(
                    itemCount: projects.length,
                    itemBuilder: (BuildContext context, int index) {
                    return ProjectCard(projects[index]);
                  },
                )
            );
          }else if(snapshot.hasError){
            return Center(
              child: Text('Ошибка при загрузке, проверьте интернет'),
            );
          }else{
            return Center(
                child: new CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(HexColor('#00D7FF'))
                ),
            );
          }
        }
    );

    // Container(
    //     child: ListView.builder(
    //       itemCount: charityList.length,
    //       itemBuilder: (BuildContext context, int index) {
    //         return ProjectCard();
    //       },
    //     )
    // )
  }
}

class CharityModel {
  CharityModel(
    this.id,
    this.title,
    this.text,
    this.needSum,
    this.collectedSum,
    this.photo,
    this.fond,
  );

  var id = "";
  var title = "";
  var text = "";
  var needSum = "";
  var collectedSum = "";
  var photo = "";
  var fond = "";
}
