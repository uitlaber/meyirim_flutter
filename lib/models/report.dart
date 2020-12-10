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
import 'package:meyirim/helpers/api_manager.dart';

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
        photos: (json["photos"] != null && json["photos"] is Iterable)
            ? List<File>.from(json["photos"].map((x) => File.fromJson(x)))
            : null,
        project:
            json["project"] != null ? Project.fromJson(json["project"]) : null,
        fond: json["fond"] != null ? User.fromJson(json["fond"]) : null,
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
        "photos": (photos != null && photos is Iterable)
            ? List<File>.from(photos.map((x) => x.toJson()))
            : null,
      };

  String get firstPhotoUrl {
    if (photos != null &&
            photos.asMap().containsKey(0) &&
            photos[0].path?.isNotEmpty ??
        false) {
      return photos[0].path;
    } else {
      return 'https://via.placeholder.com/400x300/?text=meyirim';
    }
  }
}

Future<Report> findReport(int reportId) async {
  final response = await http.get(
    globals.apiUrl + "/reports/$reportId",
    // headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
  );

  final responseJson = jsonDecode(response.body);

  return Report.fromJson(responseJson);
}

Future<dynamic> fetchReports({page: 1}) async {
  var url = globals.apiUrl + "/reports?page=$page";
  var api = new APIManager();
  return await api.getAPICall(url);

  final response = await http.get(
    globals.apiUrl + "/reports?page=$page",
    // headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
  );
  // final apiResponse =  ApiResponse.fromJson(jsonDecode(response.body));
  final responseJson = await jsonDecode(response.body);

  return List<Report>.from(responseJson['data'].map((x) => Report.fromJson(x)));
}
