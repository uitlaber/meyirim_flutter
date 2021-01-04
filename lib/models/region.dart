import 'dart:convert';
import 'package:meyirim/globals.dart' as globals;
import 'package:meyirim/helpers/api_manager.dart';

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

  static Map<String, dynamic> toMap(Region region) => {
        "id": region.id,
        "name": region.name,
        "country_id": region.countryId,
        "parent_id": region.parentId,
      };

  static String encode(List<Region> regions) => json.encode(
        regions
            .map<Map<String, dynamic>>((region) => Region.toMap(region))
            .toList(),
      );

  static List<Region> decode(String regions) =>
      (json.decode(regions) as List<dynamic>)
          .map<Region>((item) => Region.fromJson(item))
          .toList();
}

Future<List<Region>> fetchRegions(countryId) async {
  var url = globals.apiUrl + "/countries/$countryId?include=regions";
  var api = new APIManager();
  var result = await api.getAPICall(url);

  List<Region> regions = List<Region>.from(result['regions']['data'].map((x) {
    return Region.fromJson(x);
  }));

  return regions;
}
