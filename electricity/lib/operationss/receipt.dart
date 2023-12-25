import 'package:flutter/material.dart';
import 'package:login_ui/models/apikey.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Receipt extends StatefulWidget {
  const Receipt({Key? key}) : super(key: key);

  @override
  State<Receipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  String? selectedMonth;
  Color primary = const Color(0xFF2661FA);
  Color cl1 = const Color(0xFF95F1F0);
  Color cl2 = const Color(0xFFF4AAAA);
  Color cl3 = const Color(0xFFF9A46C);
  Color cl4 = const Color(0xFF65A9BB);
  Color cl5 = const Color(0xFF4B807F);
  final String _baseUrl = baseUrl;

  final List<String> months = [
    'Select a month','January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  Future<void> openInvoicePdf() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String meterNo = prefs.getString('meterNO') ?? "";
    String month = "your_selected_month"; // Replace with the selected month
    final url = "$_baseUrl/invoicePdf?meterNo=$meterNo&month=$selectedMonth";

    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: Text('Receipt Generate'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [cl1, cl2], // Main container gradient
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    offset: Offset(5, 5),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
                child: Image.asset(
                  "assets/images/receipt1.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 35,
              width: 300,
              decoration: BoxDecoration(
                color: cl5,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    offset: Offset(5, 5),
                    blurRadius: 6,
                  ),
                ],
              ),
              alignment: Alignment.center,
            ),
            SizedBox(height: 20,),
            Text(
              'Select A Month For Receipt',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              height: 50,
              width: 200,
              padding: EdgeInsets.only(
                  left: 10, right: 10, top: 1.5, bottom: 1.5),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5)),
              child: DropdownButton<String>(
                padding: EdgeInsets.all(8),
                dropdownColor: Colors.cyan,
                icon: Icon(Icons.calendar_month_sharp),
                hint: Text('Select A Month'),
                value: selectedMonth,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedMonth = newValue;
                  });
                },
                items: months.map((String month) {
                  return DropdownMenuItem<String>(
                    value: month,
                    child: Text(
                        month,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20), // Add spacing

            // Container with ElevatedButton
            Container(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  openInvoicePdf();
                },
                child: Text('Click for Receipt'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

