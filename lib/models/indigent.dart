class Indigent {

  final int id;
  final String fullName;
  final int cityId;
  final String address;
  final String note;
  final String phone;
  final String photo;

  Indigent({this.id, this.fullName, this.cityId, this.address, this.note, this.phone, this.photo});

  factory Indigent.fromJson(Map<String, dynamic> json) {
    return Indigent(
      id: json['id'],
      fullName: json['fullname'],
      cityId: json['city_id'],
      phone: json['phone'],
      address: json['address'],
      note: json['note']
    );
  }

}