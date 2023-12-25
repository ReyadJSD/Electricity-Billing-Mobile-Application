import 'package:flutter/material.dart';
import 'package:login_ui/models/apikey.dart';
import 'package:login_ui/models/billdetails.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_search_bar/easy_search_bar.dart';

class BillsScreen extends StatefulWidget {
  const BillsScreen({Key? key}) : super(key: key);

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color(0xFF2661FA);
  Color cl1 = const Color(0xFF95F1F0);
  Color cl2 = const Color(0xFFF4AAAA);
  late Future<List<AllBill>> futureBills;
  final String _baseUrl = baseUrl;
  List<AllBill> billsList = [];

  @override
  void initState() {
    super.initState();
    futureBills = fetchBills('$_baseUrl/showAllBillForCustomer');
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
          'Bill Details',
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
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              // Container(
              //   alignment: Alignment.centerLeft,
              //     margin: EdgeInsets.only(left: 0, right: 1570,top: 20, bottom: 10),
              //     width: MediaQuery.of(context).size.width,
              //     child: ListView(
              //       shrinkWrap: true,
              //       children: [
              //         TextField(
              //           decoration: InputDecoration(
              //             contentPadding: EdgeInsets.symmetric(vertical: 15.0),
              //             border: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(30.0),
              //               borderSide: BorderSide(width: 0.8),
              //             ),
              //             hintText: 'Search Individual Month Bill',
              //             prefixIcon: Icon(
              //               Icons.search,
              //               size: 30.0,
              //             ),
              //             suffixIcon: IconButton(
              //               icon: Icon(Icons.clear),
              //               onPressed: () {
              //                 // Clear the search field and reset the bill list
              //                 setState(() {
              //                   searchValue = '';
              //                   selectedMonth = ''; // Reset selected month
              //                 });
              //               },
              //             ),
              //           ),
              //           onChanged: (value) {
              //             // Update the searchValue as the user types
              //             setState(() {
              //               searchValue = value;
              //               selectedMonth = ''; // Clear selected month when searching by name
              //             });
              //           },
              //         ),
              //       ],
              //     ),
              //   ),
              Container(
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
                child: FutureBuilder<List<AllBill>>(
                  future: futureBills,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData) {
                      return Center(child: Text('No data available'));
                    } else {
                      List<AllBill> bills = snapshot.data!;

                      // Filter bills by selected month if it's not empty
                      if (selectedMonth.isNotEmpty) {
                        bills = bills.where((bill) => bill.month == selectedMonth).toList();
                      }

                      // Filter bills by searchValue if it's not empty
                      if (searchValue.isNotEmpty) {
                        bills = bills.where((bill) => bill.month.toLowerCase().contains(searchValue.toLowerCase())).toList();
                      }

                      return DataTable(
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text(
                              'Meter No',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Name',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Address',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text('Meter Type',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text('LMU',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text('CMU',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text('Unit',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text('Bill Per Unit',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text('Net Bill',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text('Rent Charge',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text('Tax',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text('Month',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text('Year',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text('Total Bill',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text('Status',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                              ),
                            ),
                          ),
                        ],
                        rows: bills.map((bill) {
                          return DataRow(
                            cells: <DataCell>[
                              DataCell(Text(bill.meterNo,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18
                                ),)),
                              DataCell(Text(bill.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18
                                ),)),
                              DataCell(Text(bill.address,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18
                                ),)),
                              DataCell(Text(bill.meterType,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18
                                ),)),
                              DataCell(Text(bill.lmu.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18
                                ),)),
                              DataCell(Text(bill.cmu.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18
                                ),)),
                              DataCell(Text(bill.unit.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18
                                ),)),
                              DataCell(Text(bill.result.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18
                                ),)),
                              DataCell(Text(bill.netBill.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18
                                ),)),
                              DataCell(Text(bill.rentCharge.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18
                                ),)),
                              DataCell(Text(bill.tax.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18
                                ),)),
                              DataCell(Text(bill.month,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18
                                ),)),
                              DataCell(Text(bill.year,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18
                                ),)),
                              DataCell(Text(bill.totalBill.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18
                                ),)),
                              DataCell(Text(bill.status,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18
                                ),)),
                            ],
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
              ),

            ],
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
        Uri.parse('$_baseUrl/showAllBillBymonth/$meterNo/$month'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<AllBill> bills =
        data.map((json) => AllBill.fromJson(json)).toList();

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

  Future<List<AllBill>> fetchBills(String url) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String meterNo = prefs.getString('meterNo') ?? "";
    final response = await http.get(Uri.parse(url + '/' + meterNo));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<AllBill> bills =
      data.map((json) => AllBill.fromJson(json)).toList();
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
