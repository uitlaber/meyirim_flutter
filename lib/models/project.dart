import 'dart:convert';
import 'package:meyirim/models/file.dart';
import 'package:meyirim/models/user.dart';
import 'package:meyirim/globals.dart' as globals;

Project projectFromJson(String str) => Project.fromJson(json.decode(str));

String projectToJson(Project data) => json.encode(data.toJson());

class Project {
  Project({
    this.id,
    this.status,
    // this.userCreated,
    // this.dateCreated,
    // this.userUpdated,
    // this.dateUpdated,
    this.title,
    this.description,
    this.requiredAmount,
    this.collectedAmount,
    this.isFinished,
    this.indigentId,
    this.videoUrl,
    this.fond,
    this.photos,
  });

  int id;
  String status;
  // String userCreated;
  // DateTime dateCreated;
  // String userUpdated;
  // DateTime dateUpdated;
  String title;
  String description;
  double requiredAmount;
  double collectedAmount;
  bool isFinished;
  dynamic indigentId;
  dynamic videoUrl;
  User fond;
  List<File> photos;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        status: json["status"],
        // userCreated: json["user_created"],
        // dateCreated: DateTime.parse(json["date_created"]),
        // userUpdated: json["user_updated"],
        // dateUpdated: DateTime.parse(json["date_updated"]),
        title: json["title"],
        description: json["description"],
        requiredAmount: double.parse(json['required_amount']),
        collectedAmount: double.parse(json['collected_amount']),
        isFinished: json["is_finished"],
        indigentId: json["indigent_id"],
        videoUrl: json["video_url"],
        fond: User.fromJson(json["fond_id"]),
        photos: json["photos"] != null
            ? List<File>.from(json["photos"].map((x) => File.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        // "user_created": userCreated,
        // "date_created": dateCreated.toIso8601String(),
        // "user_updated": userUpdated,
        // "date_updated": dateUpdated.toIso8601String(),
        "title": title,
        "description": description,
        "required_amount": requiredAmount,
        "collected_amount": collectedAmount,
        "is_finished": isFinished,
        "indigent_id": indigentId,
        "video_url": videoUrl,
        "fond": fond.toJson(),
        "photos": photos != null
            ? List<dynamic>.from(photos.map((x) => x.toJson()))
            : null,
      };

  get firstPhotoUrl {
    if (photos != null &&
            photos.asMap().containsKey(0) &&
            // ignore: null_aware_in_logical_operator
            photos[0].path?.isNotEmpty ??
        false) {
      return photos[0].path;
    } else {
      return globals.dummyPhoto + '&id=${this.id}';
    }
  }
}
