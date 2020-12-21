import 'dart:convert';
import 'package:meyirim/helpers/api_manager.dart';
import 'package:meyirim/globals.dart' as globals;

DonationAmount donationAmountFromJson(String str) =>
    DonationAmount.fromJson(json.decode(str));

String donationAmountToJson(DonationAmount data) => json.encode(data.toJson());

class DonationAmount {
  DonationAmount({
    this.amount,
    this.referal,
  });

  int amount;
  int referal;

  factory DonationAmount.fromJson(Map<String, dynamic> json) => DonationAmount(
        amount: json["amount"],
        referal: json["referal"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "referal": referal,
      };
}

Future<DonationAmount> fetchDonationAmounts() async {
  var url = globals.apiUrl + "/donations_amount/";
  var api = new APIManager();
  var result = await api.getAPICall(url);
  return new DonationAmount.fromJson(result);
}
