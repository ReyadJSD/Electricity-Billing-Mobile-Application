import 'package:flutter/material.dart';
import 'package:login_ui/operationss/bills.dart';
import 'package:login_ui/operationss/connections.dart';
import 'package:login_ui/operationss/paybill.dart';
import 'package:login_ui/operationss/paymentdetails.dart';
import 'package:login_ui/operationss/receipt.dart';

class Operations extends StatefulWidget {
  const Operations({Key? key}) : super(key: key);

  @override
  State<Operations> createState() => _OperationsState();
}

class _OperationsState extends State<Operations> {
  Color primary = const Color(0xFF2661FA);
  Color cl1 = const Color(0xFF95F1F0);
  Color cl2 = const Color(0xFFFC594F);
  Color cl3 = const Color(0xFFF9A46C);
  Color cl4 = const Color(0xFF65A9BB);
  Color cl5 = const Color(0xFF915354);
  Color cl6 = const Color(0xFFB4B6FF);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ConnectionsScreen()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top:10, left: 10),
                      height: 200,
                      width: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                        color: Colors.blue, // Change the background color as needed
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                              child: Image.asset(
                                "assets/images/connection.PNG",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Connection Details",
                                style: TextStyle(
                                  color: Colors.white, // Change the text color as needed
                                  fontSize: 18.0, // Change the text size as needed
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BillsScreen()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10, right: 10),
                      height: 200,
                      width: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                        color: Colors.blue, // Change the background color as needed
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                              child: Image.asset(
                                "assets/images/billdetails.PNG",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Bill Details",
                                style: TextStyle(
                                  color: Colors.white, // Change the text color as needed
                                  fontSize: 20.0, // Change the text size as needed
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PaymentDetails()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10, left: 10),
                      height: 200,
                      width: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                        color: Colors.blue, // Change the background color as needed
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                              child: Image.asset(
                                "assets/images/payment.PNG",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Payment Details",
                                style: TextStyle(
                                  color: Colors.white, // Change the text color as needed
                                  fontSize: 20.0, // Change the text size as needed
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PayBillScreen()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10, right: 10),
                      height: 200,
                      width: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                        color: Colors.blue
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                              child: Image.asset(
                                "assets/images/paybill.PNG",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Pay Bill",
                                style: TextStyle(
                                  color: Colors.white, // Change the text color as needed
                                  fontSize: 20.0, // Change the text size as needed
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 12,),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Receipt()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10, right: 10),
                  height: 200,
                  width: 180,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                      color: Colors.blue
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                          child: Image.asset(
                            "assets/images/receipt1.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Take Receipt",
                            style: TextStyle(
                              color: Colors.white, // Change the text color as needed
                              fontSize: 20.0, // Change the text size as needed
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
