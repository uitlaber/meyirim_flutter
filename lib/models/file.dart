import 'dart:convert';
import 'package:meyirim/globals.dart' as globals;

class File {
  File({
    this.id,
    this.directusFilesId,
  });

  int id;
  String directusFilesId;

  factory File.fromJson(Map<String, dynamic> json) => File(
        id: json["id"],
        directusFilesId: json["directus_files_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "directus_files_id": directusFilesId,
      };

  String get path {
    return globals.apiUrl + '/assets/' + directusFilesId;
  }
}
