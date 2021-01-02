import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:meyirim/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'file.dart';
import 'user.dart';
import 'report.dart';
import 'donation.dart';
import 'package:meyirim/helpers/api_manager.dart';
import 'package:meyirim/models/indigent.dart';

Project projectFromJson(String str) => Project.fromJson(json.decode(str));

String projectToJson(Project data) => json.encode(data.toJson());

class Project {
  Project(
      {this.id,
      this.title,
      this.description,
      this.requiredAmount,
      this.collectedAmount,
      this.videoUrl,
      this.isFinished,
      this.isPublished,
      this.fondId,
      this.createdAt,
      this.photos,
      this.fond,
      this.indigent,
      this.donations,
      this.donationsCount});

  int id;
  String title;
  String description;
  double requiredAmount;
  double collectedAmount;
  String videoUrl;
  int isFinished;
  int isPublished;
  int fondId;
  DateTime createdAt;
  List<File> photos;
  User fond;
  Indigent indigent;
  int donationsCount;
  List<Donation> donations;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        requiredAmount: double.parse(json["required_amount"]),
        collectedAmount: double.parse(json["collected_amount"]),
        videoUrl: json["video_url"],
        isFinished: json["is_finished"],
        isPublished: json["is_published"],
        fondId: json["fond_id"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        donationsCount: json["donations_count"],
        photos: (json["photos"]["data"] != null &&
                json["photos"]["data"] is Iterable)
            ? List<File>.from(
                json["photos"]["data"].map((x) => File.fromJson(x)))
            : null,
        fond: json["fond"] != null ? User.fromJson(json['fond']) : null,
        indigent: json["indigent"] != null
            ? Indigent.fromJson(json['indigent'])
            : null,
        donations:
            (json["donations"] != null && json["donations"]["data"] is Iterable)
                ? List<Donation>.from(
                    json["donations"]["data"].map((x) => Donation.fromJson(x)))
                : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "required_amount": requiredAmount,
        "collected_amount": collectedAmount,
        "video_url": videoUrl,
        "created_at": createdAt.toIso8601String(),
        "is_finished": isFinished,
        "donations_count": donationsCount,
        "photos": List<File>.from(photos.map((x) => x.toJson())),
        "fond": fond.toJson(),
        "donations": List<Donation>.from(donations.map((x) => x.toJson())),
      };

  String get firstPhotoUrl {
    if (photos != null &&
            photos.asMap().containsKey(0) &&
            // ignore: null_aware_in_logical_operator
            photos[0].path?.isNotEmpty ??
        false) {
      return photos[0].path;
    } else {
      return globals.dummyPhoto;
    }
  }
}

Future<Project> findProject(int projectId) async {
  var url = globals.apiUrl + "/projects/$projectId?include=donations";
  var api = new APIManager();
  var result = await api.getAPICall(url);
  return Project.fromJson(result);
}

Future<dynamic> searchProjects(
    {int page = 1, int status = 0, query = ''}) async {
  var url = globals.apiUrl +
      "/search/projects/?include=donations&page=$page&query=$query";
  var api = new APIManager();

  var result = await api.getAPICall(url);

  return result;
}

Future<dynamic> fetchProjects(
    {int page = 1, int status = 1, query = ''}) async {
  var url = globals.apiUrl +
      "/projects/?include=donations&is_finished=$status&page=$page&query=$query";
  var api = new APIManager();

  var result = await api.getAPICall(url);
  return result;
}
