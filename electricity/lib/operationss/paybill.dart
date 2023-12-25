import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:login_ui/models/apikey.dart';
import 'package:login_ui/models/billpayment.dart';
import 'package:login_ui/models/transection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PayBillScreen extends StatefulWidget {
  const PayBillScreen({Key? key}) : super(key: key);

  @override
  State<PayBillScreen> createState() => _PayBillScreenState();
}

class _PayBillScreenState extends State<PayBillScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color(0xFF2661FA);
  Color cl1 = const Color(0xFF95F1F0);
  Color cl2 = const Color(0xFFF4AAAA);
  Color cl3 = const Color(0xFFF9A46C);
  Color cl4 = const Color(0xFF65A9BB);
  final String _baseUrl = baseUrl;

  final TextEditingController meterNo = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController month = TextEditingController();
  final TextEditingController year = TextEditingController();
  final TextEditingController meterType = TextEditingController();
  final TextEditingController unit = TextEditingController();
  final TextEditingController totalBill = TextEditingController();
  final TextEditingController lastDate = TextEditingController();
  final TextEditingController receiveDate = TextEditingController();
  late final TextEditingController fineTotal = TextEditingController();
  final TextEditingController status = TextEditingController();

  final TextEditingController transactionIds = TextEditingController();
  final TextEditingController mobileBankings = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController pinNumber = TextEditingController();
  // String trnxId = '';

  String selectedMonth = 'Select a month'; // Default value for the month
  String selectedYear = 'Select a year'; // Default value for the year
  bool paymentMethodVisible = true;
  bool showTransactionIdField = false;

  List<String> months = [
    'Select a month',
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
    'December',
  ];

  List<String> years = [
    'Select a year',
    '2023',
    '2024',
    '2025',
    '2026',
    '2027',
    // Add more years as needed
  ];

  String formatDate(DateTime? date) {
    if (date == null) {
      return '';
    }
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    return dateFormat.format(date);
  }

  void calculateFine(String month, String year) async{
    final billPayment = await fetchBillInformation(month, year);
    DateTime? lastDateTime = billPayment?.lastDate;
    int? daysDifference = DateTime.now().difference(lastDateTime!).inDays;
    double totalBillValue = double.parse(totalBill.text);
    double fine;
    if(daysDifference <= 0){
      setState(() {
        fineTotal.text = totalBill.text;
      });
    }else if(daysDifference <= 5) {
      fine = totalBillValue * 0.07; // 2% of totalBill
      fineTotal.text = (totalBillValue + fine).toStringAsFixed(2);
      showSnackBar('For Delay You have to Pay 7% Fine of Total Bill');
    } else if (daysDifference > 5 && daysDifference <= 10) {
      fine = totalBillValue * 0.10; // 2% of totalBill
      fineTotal.text = (totalBillValue + fine).toStringAsFixed(2);
      showSnackBar('For Delay You have to Pay 10% Fine of Total Bill');
    } else if (daysDifference > 10 && daysDifference <= 20) {
      fine = totalBillValue * 0.15; // 2% of totalBill
      fineTotal.text = (totalBillValue + fine).toStringAsFixed(2);
      showSnackBar('For Delay You have to Pay 15% Fine of Total Bill');
    } else {
      fine = totalBillValue * 0.20; // 2% of totalBill
      fineTotal.text = (totalBillValue + fine).toStringAsFixed(2);
      showSnackBar('For Delay You have to Pay 20% Fine of Total Bill');
    }

  }

  Future<void> fetchDataAndPopulateFields(String month, String year) async {
    final billPayment = await fetchBillInformation(month, year);
    if (billPayment != null) {
      name.text = billPayment.name!;
      meterNo.text = billPayment.meterNo!;
      meterType.text = billPayment.meterType!;
      unit.text = billPayment.unit.toString();
      totalBill.text = billPayment.totalBill.toString();
      lastDate.text = formatDate(billPayment.lastDate);
      fineTotal.text = billPayment.fineTotal.toString();
      status.text = billPayment.status!;
      if(billPayment.receiveDate != null){
        receiveDate.text = formatDate(billPayment.receiveDate);
      }else{
        receiveDate.text = formatDate(DateTime.now());
        setState(() {
          calculateFine(month, year);
        });
      }
      // Update the selectedMonth and selectedYear dropdowns
      selectedMonth = months.contains(billPayment.month)
          ? billPayment.month!
          : 'Select a month';
      selectedYear = years.contains(billPayment.year)
          ? billPayment.year!
          : 'Select a year';

      // Check if the status is 'Paid' and hide the payment method section if needed
      if (billPayment.status == 'Paid') {
        setState(() {
          paymentMethodVisible = false;
        });
      } else {
        setState(() {
          paymentMethodVisible = true;
          receiveDate.text = formatDate(DateTime.now());
        });
      }
    } else {
      clearFields();
      showSnackBar(
          "No data found for the selected month and year"); // Show a message
    }
  }

  //Bill Collection Method

  Future<void> updatePaymentStatus() async {
    final response = await http.post(
      Uri.parse('$_baseUrl/collectBillFlutter'), // Include customerId in the URL
      body: jsonEncode({
        'meterNo':meterNo.text,
        'month': selectedMonth,
        'year': selectedYear,
        'status': status.text,
        'receiveDate': receiveDate.text,
        'fineTotal': fineTotal.text,
      }),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      setState(() {
        status.text = 'Paid';
      });
      // Handle successful profile update, e.g., show a success message
      showSnackBar('Successfully Paid');
    } else {
      // Handle profile update failure, e.g., show an error message
      showSnackBar('Failed To Paid');
    }
  }

  //Insert Data Into Transaction Table
  Future<void> createTransaction() async {
    try {
      final String transactionId = generateTransactionId();
      String selectedMobileBanking;
      if (selectedPayment == 0) {
        selectedMobileBanking = 'Bkash';
      } else {
        selectedMobileBanking = 'Nagad';
      }
      Transaction transaction = Transaction(
        tnxId: transactionId,
        meterNo: meterNo.text,
        mobileBanking: selectedMobileBanking,
        phone: phoneNumber.text,
        totalBill: double.parse(fineTotal.text),
        month: selectedMonth,
        year: selectedYear
      );
      final response = await http.post(
        Uri.parse('$_baseUrl/saveTransectionFlutter'),
        body: jsonEncode(transaction.toJson()),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        String trnxId = transactionId;
        setState(() {
          trnxId = transactionIds.text;
          transactionIds.text = trnxId;
          showTransactionIdField = true;
        });
        showSnackBar('Transaction saved successfully. Transaction ID: $transactionId');
      } else {
        showSnackBar('Transaction failed');
      }
    } catch (e) {
      print('Error: $e');
      showSnackBar('An error occurred while creating the transaction.');
    }

  }

// Transaction Id Generate Here
  String generateTransactionId() {
    final String characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final Random random = Random();
    final int length = 10; // Adjust the length as needed
    String transactionId = '';
    for (int i = 0; i < length; i++) {
      transactionId += characters[random.nextInt(characters.length)];
    }
    return transactionId;
  }

  //Get Transaction Id
  Future<Transaction?> getTransactionId(String month, String year) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String meterNo = prefs.getString('meterNO') ?? "";
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/transactionIdForFlutter/$meterNo/$month/$year'),
      );

      if (response.statusCode == 200) {
        return Transaction.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print('Error1: $e');
      return null; // Return null or another appropriate value in case of an error.
    }
  }

  Future<void> fetchTransactionIdFields(String month, String year) async {
    final transaction = await getTransactionId(month, year);
    if (transaction != null) {
      setState(() {
        transactionIds.text = transaction.tnxId;
        showTransactionIdField = true; // Set it to true when you have transaction IDs
      });
    } else {
      setState(() {
        showTransactionIdField = false;
        showSnackBar('No Transaction Id Found');
      });
    }
  }

  void clearFields() {
    name.clear();
    meterNo.clear();
    meterType.clear();
    unit.clear();
    totalBill.clear();
    lastDate.clear();
    receiveDate.clear();
    fineTotal.clear();
    status.clear();
    transactionIds.clear();
    // selectedMonth = 'Select a month';
    // selectedYear = 'Select a year';
  }

  @override
  void initState() {
    super.initState();
    fetchDataAndPopulateFields(selectedMonth, selectedYear);
    fetchTransactionIdFields(selectedMonth, selectedYear);
  }


  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay Your Bill'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Month',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        height: 50,
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 1.5, bottom: 1.5),
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(5)),
                        child: DropdownButton<String>(
                          value: selectedMonth,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedMonth = newValue!;
                              if (selectedMonth != 'Select a month' &&
                                  selectedYear != 'Select a year') {
                                fetchDataAndPopulateFields(selectedMonth,
                                    selectedYear);
                                fetchTransactionIdFields(selectedMonth, selectedYear);// Fetch data when month changes
                              }
                            });
                          },
                          items: months
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20), // Add some spacing between the fields
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Year',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 3, bottom: 3),
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(5)),
                        child: DropdownButton<String>(
                          value: selectedYear,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedYear = newValue!;
                              if (selectedMonth != 'Select a month' &&
                                  selectedYear != 'Select a year') {
                                fetchDataAndPopulateFields(selectedMonth,
                                    selectedYear);
                                fetchTransactionIdFields(selectedMonth, selectedYear);// Fetch data when year changes
                              }
                            });
                          },
                          items: years
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          textField('Name', 'Name', name,true, false),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: textField('Meter No', 'Meter number', meterNo,true, false),
              ),
              SizedBox(width: 10), // Add some spacing between the fields
              Expanded(
                child: textField('Meter Type', 'Meter type', meterType,true, false),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: textField('Unit', 'Unit', unit,true, false),
              ),
              SizedBox(width: 10), // Add some spacing between the fields
              Expanded(
                child: textField('Total Bill', 'Total Bill', totalBill,true,false),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: textField('Last Date', 'Last Date', lastDate,true,false),
              ),
              SizedBox(width: 10), // Add some spacing between the fields
              Expanded(
                child: textField('Receive Date', 'Receive Date', receiveDate,false,false),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: textField('Fine Total', 'Fine Total', fineTotal,true, false),
              ),
              SizedBox(width: 10), // Add some spacing between the fields
              Expanded(
                child: textField('Status', 'Status', status,true, false),
              ),
            ],
          ),
          Visibility(
            visible: showTransactionIdField, // Only visible when showTransactionIdField is true
            child: textField('Transaction Id', 'Transaction Id', transactionIds, true, false),
          ),
          Visibility(
            visible: status.text == 'Paid',
              child: Text(
                'This month\'s bill has already been paid',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red
                ),
              )
          ),
          Visibility(
            visible: status.text == 'Paid',
              child: SizedBox(height: 15,)
          ),
          Visibility(
            visible: status.text != 'Paid',
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Select Your Payment Methode',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child:
                              CustomPaymentCardButton("assets/images/bkash.png", 0),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child:
                              CustomPaymentCardButton("assets/images/nagad.png", 1),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                      visible: selectedPayment == 0,
                      child: Row(
                        children: [
                          Expanded(child: textField('Bkash Account No', 'Enter bkash acccount no', phoneNumber,false, false)),
                          SizedBox(width: 9,),
                          Expanded(child: textField('Pin Number', 'Enter your pin', pinNumber, false, true))
                        ],
                      )
                  ),
                  Visibility(
                      visible: selectedPayment == 1,
                      child: Row(
                        children: [
                          Expanded(child: textField('Nagad Account No', 'Enter nagad acccount no', phoneNumber,false, false)),
                          SizedBox(width: 9,),
                          Expanded(child: textField('Pin Number', 'Enter your pin', pinNumber, false, true))
                        ],
                      )
                  ),

                  GestureDetector(
                    onTap: (){
                      if (selectedPayment == 0) {
                        if (phoneNumber.text.isEmpty || pinNumber.text.isEmpty) {
                          Fluttertoast.showToast(
                            msg: 'Bkash Account No and Pin Number are required.',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            backgroundColor: Colors.cyan,
                            textColor: Colors.white,
                          );
                        } else {
                          // Perform payment process here
                          updatePaymentStatus();
                          createTransaction();
                        }
                      } else if (selectedPayment == 1) {
                        if (phoneNumber.text.isEmpty || pinNumber.text.isEmpty) {
                          Fluttertoast.showToast(
                            msg: 'Nagad Account No & Pin Number are required.',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            backgroundColor: Colors.cyan,
                            textColor: Colors.white,
                          );
                        } else {
                          // Perform payment process here
                          updatePaymentStatus();
                          createTransaction();
                        }
                      }
                    },
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(
                        left: 8,
                        right: 8,
                        bottom: 20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.cyan,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Click to Pay',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ),
        ],
      )),
    );
  }

  Future<BillPayment?> fetchBillInformation(String month, String year) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String meterNo = prefs.getString('meterNO') ?? "";

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/getFlutterBillInfo/$meterNo/$month/$year'),
      );

      if (response.statusCode == 200) {
        return BillPayment.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print('Error1: $e');
      return null; // Return null or another appropriate value in case of an error.
    }
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            text,
          )),
    );
  }


  Widget textField(String title, String hint, TextEditingController controller, bool isReadOnly, bool obstext) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            // height: 40,
            margin: EdgeInsets.only(bottom: 12, top: 6),
            child: TextFormField(
              obscureText: obstext,
              style: TextStyle(
                  fontSize: 20
              ),
              controller: controller,
              cursorColor: Colors.black54,
              maxLines: 1,
              readOnly: isReadOnly, // Set readOnly property based on the 'isReadOnly' parameter
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 6),
                hintText: hint,
                hintStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int selectedPayment = 0;

  Widget CustomPaymentCardButton(String assetName, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          selectedPayment = index;
        });
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        side: BorderSide(
            width: (selectedPayment == index) ? 2.0 : 0.5,
            color: (selectedPayment == index) ? Colors.green : Colors.black54),
      ),
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              assetName,
              fit: BoxFit.contain,
              width: 50,
              height: 50,
            ),
          ),
          if (selectedPayment == index)
            Positioned(
              top: 5,
              right: 5,
              child: Image.asset(
                "assets/images/tick-circle.png",
                width: 25,
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    );
  }

}
