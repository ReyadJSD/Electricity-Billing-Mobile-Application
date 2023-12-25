import 'dart:convert';
class Customer {
  String customerId;
  String meterNo;
  String customerName;
  String address;
  String customerEmail;
  String customerPhone;
  String? confirmPassword;

  Customer({
    required this.customerId,
    required this.meterNo,
    required this.customerName,
    required this.address,
    required this.customerEmail,
    required this.customerPhone,
    required this.confirmPassword,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    customerId: json["customerId"],
    meterNo: json["meterNo"],
    customerName: json["customerName"],
    address: json["address"],
    customerEmail: json["customerEmail"],
    customerPhone: json["customerPhone"],
    confirmPassword: json["confirmPassword"],
  );

  Map<String, dynamic> toJson() => {
    "customerId": customerId,
    "meterNo": meterNo,
    "customerName": customerName,
    "address": address,
    "customerEmail": customerEmail,
    "customerPhone": customerPhone,
    "confirmPassword": confirmPassword,
  };
}