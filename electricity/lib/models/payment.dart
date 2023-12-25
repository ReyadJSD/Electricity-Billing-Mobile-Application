import 'dart:convert';

List<Payment> welcomeFromJson(String str) => List<Payment>.from(json.decode(str).map((x) => Payment.fromJson(x)));

String allBillToJson(List<Payment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Payment {
  Payment({
    required this.id,
    required this.meterNo,
    required this.name,
    required this.month,
    required this.year,
    required this.meterType,
    required this.unit,
    required this.totalBill,
    required this.lastDate,
    required this.receiveDate,
    required this.fineTotal,
    required this.status,
  });

  final int? id;
  final String? meterNo;
  final String? name;
  final String? month;
  final String? year;
  final String? meterType;
  final double? unit;
  final double? totalBill;
  final String? lastDate;
  final String? receiveDate;
  final double? fineTotal;
  final String? status;

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json["id"],
      meterNo: json["meterNo"],
      name: json["name"],
      month: json["month"],
      year: json["year"],
      meterType: json["meterType"],
      unit: json["unit"],
      totalBill: json["totalBill"],
      lastDate: json["lastDate"] ?? "",
      receiveDate: json["receiveDate"] ?? "",
      fineTotal: json["fineTotal"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "meterNo": meterNo,
    "name": name,
    "month": month,
    "year": year,
    "meterType": meterType,
    "unit": unit,
    "totalBill": totalBill,
    "lastDate": lastDate,
    "receiveDate": receiveDate,
    "fineTotal": fineTotal,
    "status": status,
  };
}
