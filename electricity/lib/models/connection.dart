class Connection {
  Connection({
    required this.name,
    required this.gender,
    required this.male,
    required this.female,
    required this.meterNo,
    required this.meterType,
    required this.issueDate,
    required this.district,
    required this.address,
    required this.email,
    required this.phone,
  });

  final String? name;
  final String? gender;
  final dynamic male;
  final dynamic female;
  final String? meterNo;
  final String? meterType;
  final String? issueDate;
  final String? district;
  final String? address;
  final String? email;
  final String? phone;

  factory Connection.fromJson(Map<String, dynamic> json){
    return Connection(
      name: json["name"],
      gender: json["gender"],
      male: json["male"],
      female: json["female"],
      meterNo: json["meterNo"],
      meterType: json["meterType"],
      issueDate: json["issueDate"] ?? "",
      district: json["district"],
      address: json["address"],
      email: json["email"],
      phone: json["phone"],
    );
  }
}
