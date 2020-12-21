class Response {
  Response({this.data, this.meta});

  var meta;
  var data;

  factory Response.fromJson(Map<String, dynamic> json) =>
      Response(data: json["data"], meta: json["meta"]);

  Map<String, dynamic> toJson() => {
        "data": data,
        "meta": meta,
        // // "data": List<dynamic>.from(data.map((x) => x.toJson())),
        // "data": firstPageUrl,
      };
}
