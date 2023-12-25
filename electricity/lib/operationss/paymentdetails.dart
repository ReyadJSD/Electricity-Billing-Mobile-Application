import 'dart:convert';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login_ui/models/apikey.dart';
import 'package:login_ui/models/payment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({Key? key}) : super(key: key);

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color(0xFF2661FA);
  late Future<List<Payment>> futureBills;
  final String _baseUrl = baseUrl;
  List<Payment> billsList = [];

  @override
  void initState() {
    super.initState();
    futureBills = fetchBills('$_baseUrl/showPaymentForCustomer');
  }

  String searchValue = '';
  String selectedMonth = ''; // Added to store the selected month
  final List<String> _suggestions = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: EasySearchBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Payment Details',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        onSearch: (value) {
          setState(() {
            searchValue = value;
            selectedMonth = ''; // Clear selectedMonth when searching by name
          });
        },
        asyncSuggestions: (value) async {
          if (searchValue.isEmpty) {
            return _fetchSuggestions(value);
          } else {
            return [];
          }
        },
        onSuggestionTap: (suggestion) {
          // When a suggestion is selected, fetch bills for the selected month
          _fetchBillsForMonth(suggestion);
          setState(() {

          });
        },
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: primary,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: FutureBuilder<List<Payment>>(
            future: futureBills,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return Center(child: Text('No data available'));
              } else {
                print(snapshot.data![4].receiveDate != null);
                List<Payment> bills = snapshot.data!;
                if (selectedMonth.isNotEmpty) {
                  // Filter bills by the selected month
                  bills = bills.where((bill) => bill.month == selectedMonth).toList();
                }

                return DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Meter No',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Month',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Year',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Meter Type',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Unit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Total Bill',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Last Date',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Receive Date',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Fine Total',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Status',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                  rows: bills.map((bill) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text(
                            bill.meterNo ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            bill.name ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            bill.month ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            bill.year ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            bill.meterType ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            bill.unit?.toString() ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            bill.totalBill?.toString() ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            bill.lastDate ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            bill.receiveDate ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            bill.fineTotal?.toString() ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            bill.status ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                );
              }
            },
          ),
        ),
      ),
    );
  }


  Future<void> _fetchBillsForMonth(String month) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String meterNo = prefs.getString('meterNo') ?? "";

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/searchpayments/$meterNo/$month'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<Payment> bills =
        data.map((json) => Payment.fromJson(json)).toList();

        setState(() {
          selectedMonth = month;
          billsList = bills;
        });
      } else {
        throw Exception('Failed to load bills');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<List<Payment>> fetchBills(String url) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String meterNo = prefs.getString('meterNo') ?? "";
    final response = await http.get(Uri.parse(url + '/' + meterNo));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Payment> bills =
      data.map((json) => Payment.fromJson(json)).toList();
      return bills;
    } else {
      throw Exception('Failed to load bills');
    }
  }

  Future<List<String>> _fetchSuggestions(String searchValue) async {
    await Future.delayed(const Duration(milliseconds: 750));

    return _suggestions.where((element) {
      return element.toLowerCase().contains(searchValue.toLowerCase());
    }).toList();
  }
}



