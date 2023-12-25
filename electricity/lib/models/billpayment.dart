class BillPayment {
  BillPayment({
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

  final String? meterNo;
  final String? name;
  final String? month;
  final String? year;
  final String? meterType;
  final double? unit;
  final double? totalBill;
  final DateTime? lastDate;
  final DateTime? receiveDate;
  late final double? fineTotal;
  final String? status;

  factory BillPayment.fromJson(Map<String, dynamic> json){
    return BillPayment(
      meterNo: json["meterNo"],
      name: json["name"],
      month: json["month"],
      year: json["year"],
      meterType: json["meterType"],
      unit: json["unit"],
      totalBill: json["totalBill"],
      lastDate: DateTime.tryParse(json["lastDate"] ?? ""),
      receiveDate: DateTime.tryParse(json["receiveDate"] ?? ""),
      fineTotal: json["fineTotal"],
      status: json["status"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'meterNo': meterNo,
      'meterType': meterType,
      'unit': unit,
      'totalBill': totalBill,
      'lastDate': lastDate?.toIso8601String(),
      'receiveDate': receiveDate?.toIso8601String(),
      'fineTotal': fineTotal,
      'status': status,
    };
  }

}