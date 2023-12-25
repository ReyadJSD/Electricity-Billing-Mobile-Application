class Dashboards {
  Dashboards({
    required this.meterNo,
    required this.month,
    required this.totalBill,
    required this.fineTotal,
    required this.lastDate,
    required this.status,
    required this.rowCount,
    required this.pendingBills,
    required this.pendingCustomer,
  });

  final dynamic meterNo;
  final dynamic month;
  final dynamic totalBill;
  final String? fineTotal;
  final dynamic lastDate;
  final dynamic status;
  final dynamic rowCount;
  final dynamic pendingBills;
  final dynamic pendingCustomer;

  factory Dashboards.fromJson(Map<String, dynamic> json){
    return Dashboards(
      meterNo: json["meterNo"],
      month: json["month"],
      totalBill: json["totalBill"],
      fineTotal: json["fineTotal"],
      lastDate: json["lastDate"],
      status: json["status"],
      rowCount: json["rowCount"],
      pendingBills: json["pendingBills"],
      pendingCustomer: json["pendingCustomer"],
    );
  }

}
