import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:meyirim/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'file.dart';
import 'user.dart';
import 'project.dart';
import 'file:///C:/Users/uitlaber/Desktop/meyirim_flutter/meyirim/lib/helpers/api_response.dart';
import 'package:meyirim/helpers/api_manager.dart';

class Report {
  Report({
    this.id,
    this.title,
    this.description,
    this.videoUrl,
    this.isPublished,
    this.photos,
    this.project,
    this.fond,
    this.createdAt,
  });

  int id;
  String title;
  String description;
  String videoUrl;
  int isPublished;
  DateTime createdAt;
  List<File> photos;
  Project project;
  User fond;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        videoUrl: json["video_url"],
        isPublished: json["is_published"],
        createdAt: DateTime.parse(json["created_at"]),
        photos: (json["photos"]["data"] != null &&
                json["photos"]["data"] is Iterable)
            ? List<File>.from(
                json["photos"]["data"].map((x) => File.fromJson(x)))
            : null,
        project:
            json["project"] != null ? Project.fromJson(json["project"]) : null,
        fond: json["fond"] != null ? User.fromJson(json["fond"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "video_url": videoUrl,
        "is_published": isPublished,
        "created_at": createdAt.toIso8601String(),
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
      return globals.dummyPhoto;
    }
  }
}

Future<Report> findReport(int reportId) async {
  var url = globals.apiUrl + "/reports/$reportId";
  var api = new APIManager();
  var result = await api.getAPICall(url);
  return Report.fromJson(result);
}

Future<dynamic> fetchReports({page: 1}) async {
  var url = globals.apiUrl + "/reports?page=$page";
  var api = new APIManager();
  return await api.getAPICall(url);
}
