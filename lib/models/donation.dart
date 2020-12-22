import 'dart:convert';
import 'package:meyirim/globals.dart' as globals;
import 'package:meyirim/helpers/api_manager.dart';
import 'package:meyirim/models/project.dart';

class Donation {
  Donation(
      {this.id,
      this.amount,
      this.note,
      this.paidAt,
      this.referal,
      this.project});

  int id;
  double amount;
  String note;
  DateTime paidAt;
  String referal;
  Project project;

  factory Donation.fromJson(Map<String, dynamic> json) => Donation(
        id: json["id"],
        amount: double.parse(json["amount"]),
        note: json["note"],
        paidAt: DateTime.parse(json["paid_at"]),
        referal: json["referal"],
        project:
            json["project"] != null ? Project.fromJson(json["project"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "note": note,
        "paid_at": paidAt.toIso8601String(),
        "referal": referal,
        "project": project.toJson()
      };
}

Future<dynamic> fetchDonations({int page = 1, bool isRef = false}) async {
  var url = '';
  if (isRef) {
    url = globals.apiUrl + "/donations?include=donations&ref=1&page=$page";
  } else {
    url = globals.apiUrl + "/donations?include=donations&page=$page";
  }
  var api = new APIManager();
  return await api.getAPICall(url);
}
