class Transaction {
  String tnxId;
  String meterNo;
  String mobileBanking;
  String phone;
  double totalBill;
  String month;
  String year;

  Transaction({
    required this.tnxId,
    required this.meterNo,
    required this.mobileBanking,
    required this.phone,
    required this.totalBill,
    required this.month,
    required this.year
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    tnxId: json["tnxId"],
    meterNo: json["meterNo"],
    mobileBanking: json["mobileBanking"],
    phone: json["phone"],
    totalBill: json["totalBill"].toDouble(),
    month: json["month"],
    year: json["year"],
  );

  Map<String, dynamic> toJson() => {
    "tnxId": tnxId,
    "meterNo": meterNo,
    "mobileBanking": mobileBanking,
    "phone": phone,
    "totalBill": totalBill,
    "month": month,
    "year": year,
  };
}
