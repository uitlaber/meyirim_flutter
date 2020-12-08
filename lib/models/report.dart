import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:meyirim/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'file.dart';
import 'user.dart';
import 'project.dart';
import 'package:meyirim/api_response.dart';

class Report {
  Report({
    this.id,
    this.title,
    this.description,
    this.projectId,
    this.videoUrl,
    this.fondId,
    this.isPublished,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.photos,
    this.project,
    this.fond,
  });

  int id;
  String title;
  String description;
  int projectId;
  String videoUrl;
  int fondId;
  int isPublished;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  List<File> photos;
  Project project;
  User fond;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    projectId: json["project_id"],
    videoUrl: json["video_url"],
    fondId: json["fond_id"],
    isPublished: json["is_published"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    photos: List<File>.from(json["photos"].map((x) => File.fromJson(x))),
    project: new Project.fromJson(json["project"]),
    fond: new User.fromJson(json["fond"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "project_id": projectId,
    "video_url": videoUrl,
    "fond_id": fondId,
    "is_published": isPublished,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "photos": List<File>.from(photos.map((x) => x.toJson())),
  };
}


Future <Report> findReport(int reportId) async {

  final response =  await http.get(
    globals.apiUrl+"/reports/$reportId",
    // headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
  );

  final responseJson =  jsonDecode(response.body);

  return Report.fromJson(responseJson);
}

Future<List<Report>> fetchReports() async {
  final response =  await http.get(
    globals.apiUrl+"/reports",
    // headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
  );
  // final apiResponse =  ApiResponse.fromJson(jsonDecode(response.body));
  final responseJson =  await jsonDecode(response.body);

  return List<Report>.from(responseJson['data'].map((x) => Report.fromJson(x)));
}