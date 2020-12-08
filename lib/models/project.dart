import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:meyirim/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'file.dart';
import 'user.dart';
import 'donation.dart';
import 'package:meyirim/api_response.dart';
import 'package:meyirim/helpers/api_manager.dart';

Project projectFromJson(String str) => Project.fromJson(json.decode(str));

String projectToJson(Project data) => json.encode(data.toJson());

class Project {
  Project({
    this.id,
    this.title,
    this.description,
    this.indigentId,
    this.requiredAmount,
    this.collectedAmount,
    this.fondId,
    this.endDate,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.isFinished,
    this.photos,
    this.fond,
    this.donations,
  });

  int id;
  String title;
  String description;
  int indigentId;
  double requiredAmount;
  double collectedAmount;
  int fondId;
  dynamic endDate;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int isFinished;
  List<File> photos;
  User fond;
  List<Donation> donations;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        indigentId: json["indigent_id"],
        requiredAmount: double.parse(json["required_amount"]),
        collectedAmount: double.parse(json["collected_amount"]),
        fondId: json["fond_id"],
        endDate: json["end_date"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        isFinished: json["is_finished"],
        photos: List<File>.from(json["photos"].map((x) => File.fromJson(x))),
        fond: new User.fromJson(json['fond']),
        donations: List<Donation>.from(
                json["donations"].map((x) => Donation.fromJson(x))) ??
            List<Donation>(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "indigent_id": indigentId,
        "required_amount": requiredAmount,
        "collected_amount": collectedAmount,
        "fond_id": fondId,
        "end_date": endDate,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "is_finished": isFinished,
        "photos": List<File>.from(photos.map((x) => x.toJson())),
        "fond": fond.toJson(),
        "donations": List<Donation>.from(donations.map((x) => x.toJson())),
      };
}

Future<Project> findProject(int projectId) async {
  final response = await http.get(
    globals.apiUrl + "/projects/$projectId",
    // headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
  );
  final responseJson = jsonDecode(response.body);
  return Project.fromJson(responseJson);
}

Future<dynamic> fetchProjects({int page = 1, int status = 1}) async {
  var url = globals.apiUrl + "/projects/?is_finished=$status&page=$page";
  var api = new APIManager();
  return await api.getAPICall(url);
}
