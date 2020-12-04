import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:meyirim/globals.dart' as globals;
import 'package:http/http.dart' as http;

class Project {
  final int projectId;
  final int indigentId;
  final int categoryId;
  final int fondId;
  final String title;
  final String text;
  final double requiredAmount;
  final double collectedAmount;
  final bool isFinished;
  final bool isPublished;

  Project({this.projectId, this.indigentId, this.categoryId, this.fondId, this.title, this.text, this.requiredAmount, this.collectedAmount, this.isFinished, this.isPublished});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      projectId: json['id'],
      indigentId: json['indigent_id'],
      categoryId: json['category_id'],
      fondId: json['fond_id'],
      title: json['title'],
      text: json['text'],
      requiredAmount: double.parse(json['required_amount']),
      collectedAmount: double.parse(json['collected_amount']),
      isFinished: (json['is_finished'] == '1')?true:false,
      isPublished: (json['is_published']== '1')?true:false,
    );
  }

}

Future<Project> findProject(int projectId) async {
  final response =  await http.get(
    globals.apiUrl+"/projects/${projectId}",
    // headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
  );
  final responseJson = jsonDecode(response.body);
  return Project.fromJson(responseJson);
}

// Future List<Project> publishedProjects() async {
//   final response =  await http.get(
//     globals.apiUrl+"/projects/published",
//     // headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
//   );
//   Iterable l = json.decode(response.body);
//   List<Project> projects = List<Project>.from(l).map((Map model)=> Project.fromJson(model)).toList();
//
//   return projects;
// }