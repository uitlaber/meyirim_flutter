
class File {
  File({
    this.id,
    this.diskName,
    this.fileName,
    this.fileSize,
    this.contentType,
    this.title,
    this.description,
    this.field,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
    this.path,
    this.extension,
  });

  int id;
  String diskName;
  String fileName;
  int fileSize;
  String contentType;
  dynamic title;
  dynamic description;
  String field;
  int sortOrder;
  DateTime createdAt;
  DateTime updatedAt;
  String path;
  String extension;

  factory File.fromJson(Map<String, dynamic> json) => File(
    id: json["id"],
    diskName: json["disk_name"],
    fileName: json["file_name"],
    fileSize: json["file_size"],
    contentType: json["content_type"],
    title: json["title"],
    description: json["description"],
    field: json["field"],
    sortOrder: json["sort_order"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    path: json["path"],
    extension: json["extension"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "disk_name": diskName,
    "file_name": fileName,
    "file_size": fileSize,
    "content_type": contentType,
    "title": title,
    "description": description,
    "field": field,
    "sort_order": sortOrder,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "path": path,
    "extension": extension,
  };
}
