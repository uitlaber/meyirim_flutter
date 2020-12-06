
import 'dart:convert';

class Donation {
  Donation({
    this.id,
    this.projectId,
    this.userId,
    this.amount,
    this.note,
    this.paidAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.userCode,
    this.statusId,
  });

  int id;
  int projectId;
  int userId;
  String amount;
  String note;
  DateTime paidAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String userCode;
  dynamic statusId;

  factory Donation.fromJson(Map<String, dynamic> json) => Donation(
    id: json["id"],
    projectId: json["project_id"],
    userId: json["user_id"],
    amount: json["amount"],
    note: json["note"],
    paidAt: DateTime.parse(json["paid_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    userCode: json["user_code"],
    statusId: json["status_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "project_id": projectId,
    "user_id": userId,
    "amount": amount,
    "note": note,
    "paid_at": paidAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "user_code": userCode,
    "status_id": statusId,
  };
}
