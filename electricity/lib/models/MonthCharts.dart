import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class MonthCharts {
  final String january;
  final String february;
  final String march;
  final String april;
  final String may;
  final String june;
  final String july;
  final String august;
  final String september;
  final String october;
  final String november;
  final String december;
  final String value;

  MonthCharts({
    required this.january,
    required this.february,
    required this.march,
    required this.april,
    required this.may,
    required this.june,
    required this.july,
    required this.august,
    required this.september,
    required this.october,
    required this.november,
    required this.december,
    required this.value,
  });

  factory MonthCharts.fromJson(Map<String, dynamic> json) {
    return MonthCharts(
      january: json['january'] ?? '',
      february: json['february'] ?? '',
      march: json['march'] ?? '',
      april: json['april'] ?? '',
      may: json['may'] ?? '',
      june: json['june'] ?? '',
      july: json['july'] ?? '',
      august: json['august'] ?? '',
      september: json['september'] ?? '',
      october: json['october'] ?? '',
      november: json['november'] ?? '',
      december: json['december'] ?? '',
      value: json['value'] ?? '',
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'january': january,
  //     'february': february,
  //     'march': march,
  //     'april': april,
  //     'may': may,
  //     'june': june,
  //     'july': july,
  //     'august': august,
  //     'september': september,
  //     'october': october,
  //     'november': november,
  //     'december': december,
  //   };
  //}


}