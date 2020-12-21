class Indigent {
  final int id;
  final String name;

  Indigent({this.id, this.name});

  factory Indigent.fromJson(Map<String, dynamic> json) {
    return Indigent(id: json['id'], name: json['name']);
  }
}
