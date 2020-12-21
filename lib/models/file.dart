class File {
  File({
    this.id,
    this.title,
    this.path,
  });

  int id;
  dynamic title;
  String path;

  factory File.fromJson(Map<String, dynamic> json) => File(
        id: json["id"],
        title: json["title"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "path": path,
      };
}
