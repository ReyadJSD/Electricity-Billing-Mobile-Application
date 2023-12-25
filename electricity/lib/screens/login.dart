import 'package:flutter/material.dart';
import 'package:login_ui/components/background.dart';
import 'package:login_ui/models/apikey.dart';
import 'package:login_ui/models/customer.dart';
import 'package:login_ui/screens/homescreen.dart';
import 'package:login_ui/screens/registration.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _customerId = TextEditingController();
  TextEditingController _meterNo = TextEditingController();
  TextEditingController _customerName = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _customerEmail = TextEditingController();
  TextEditingController _customerPhone = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  bool _obscureText = true;
  final String _baseUrl = baseUrl;
  Future<Customer?> loginCustomer() async {
    if (_customerId.text.isEmpty ||
        _meterNo.text.isEmpty ||
        _confirmPassword.text.isEmpty) {
      // Handle input validation, e.g., show an error message
      return null;
    }

    Customer customer = Customer(
      customerId: _customerId.text,
      meterNo: _meterNo.text,
      customerName: _customerName.text,
      address: _address.text,
      customerEmail: _customerEmail.text,
      customerPhone: _customerPhone.text,
      confirmPassword: _confirmPassword.text,
    );

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/cstmlogin'),
        body: jsonEncode(customer.toJson()),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200 && response.body != "") {
        print(response.body);
        Customer c = Customer.fromJson(jsonDecode(response.body));
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('meterNo', customer.meterNo);
        await prefs.setString('customerId', c.customerId);
        await prefs.setString('meterNO', c.meterNo);
        await prefs.setString('name', c.customerName);
        await prefs.setString('address', c.address);
        await prefs.setString('email', c.customerEmail);
        await prefs.setString('phone', c.customerPhone);
        return customer;

      } else {
        // Handle login failure or show an error message to the user
        return null;
      }
    } catch (e) {
      // Handle any errors that occurred during the login process
      print("Login error: $e");
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    checkLoggedIn();
  }

  void checkLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String meterNo = prefs.getString('meterNo') ?? "";
    if(meterNo != "") {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Color primary = const Color(0xFF2661FA);

    return Scaffold(
      body: SingleChildScrollView(
        child: Background(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2661FA),
                    fontSize: 36,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              SizedBox(height: size.height * 0.02),

              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: _customerId,
                  decoration: InputDecoration(
                    labelText: "User Id",
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: _meterNo,
                  decoration: InputDecoration(
                    labelText: "Meter No",
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.03),

              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    TextField(
                      controller: _confirmPassword,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(
                            _obscureText ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      obscureText: _obscureText,
                    ),
                  ],
                ),
              ),

              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Text(
                  "Forgot your password?",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0XFF2661FA),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.04),

              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: ElevatedButton(
                  onPressed: () async {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => HomeScreen()),
                    // );
                    try {
                      Customer? customer = await loginCustomer();
                      if (customer != null) {
                        if (customer.customerId == _customerId.text &&
                            customer.meterNo == _meterNo.text &&
                            customer.confirmPassword == _confirmPassword.text) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomeScreen()),
                          );
                        } else {
                          // Handle invalid login credentials, e.g., show an error message
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Login Failed"),
                                content: Text("Invalid credentials. Please try again."),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      } else {
                        // Handle login failure, e.g., show an error message
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Login Failed"),
                              content: Text("Unable to log in. Please try again later."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    } catch (e) {
                      // Handle any errors that occurred during the login process
                      print("Login error: $e");
                    }
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 255, 136, 34),
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: size.width * 0.5,
                    child: Text(
                      "LOGIN",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()))
                  },
                  child: Text(
                    "Don't Have an Account? Sign up",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
