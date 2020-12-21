import 'dart:convert';

class Region {
  Region({
    this.id,
    this.name,
    this.countryId,
    this.parentId,
  });

  int id;
  String name;
  int countryId;
  dynamic parentId;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        id: json["id"],
        name: json["name"],
        countryId: json["country_id"],
        parentId: json["parent_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_id": countryId,
        "parent_id": parentId,
      };
}
