import 'dart:convert';

List<AllBill> welcomeFromJson(String str) => List<AllBill>.from(json.decode(str).map((x) => AllBill.fromJson(x)));

String allBillToJson(List<AllBill> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllBill {
  String meterNo;
  String name;
  String address;
  String meterType;
  double lmu;
  double cmu;
  double unit;
  double result;
  double netBill;
  double rentCharge;
  double tax;
  String month;
  String year;
  double totalBill;
  String status;

  AllBill({
    required this.meterNo,
    required this.name,
    required this.address,
    required this.meterType,
    required this.lmu,
    required this.cmu,
    required this.unit,
    required this.result,
    required this.netBill,
    required this.rentCharge,
    required this.tax,
    required this.month,
    required this.year,
    required this.totalBill,
    required this.status,
  });

  factory AllBill.fromJson(Map<String, dynamic> json) => AllBill(
    meterNo: json["meterNo"],
    name: json["name"],
    address: json["address"],
    meterType: json["meterType"],
    lmu: json["lmu"],
    cmu: json["cmu"],
    unit: json["unit"],
    result: json["result"]?.toDouble(),
    netBill: json["netBill"]?.toDouble(),
    rentCharge: json["rentCharge"],
    tax: json["tax"]?.toDouble(),
    month: json["month"],
    year: json["year"],
    totalBill: json["totalBill"]?.toDouble(),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "meterNo": meterNo,
    "name": name,
    "address": address,
    "meterType": meterType,
    "lmu": lmu,
    "cmu": cmu,
    "unit": unit,
    "result": result,
    "netBill": netBill,
    "rentCharge": rentCharge,
    "tax": tax,
    "month": month,
    "year": year,
    "totalBill": totalBill,
    "status": status,
  };
}
