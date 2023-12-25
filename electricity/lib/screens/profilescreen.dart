// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:login_ui/models/apikey.dart';
// import 'package:login_ui/models/customer.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   double screenHeight = 0;
//   double screenWidth = 0;
//   Color primary = const Color(0xFF2661FA);
//   Color cl6 = const Color(0xFFFBCBBC);
//   String? userName;
//
//   void getUserName() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     userName = prefs.getString('name') ?? "";
//     setState(() {});
//   }
//
//
//   TextEditingController _customerId = TextEditingController();
//   TextEditingController _meterNo = TextEditingController();
//   TextEditingController _customerName = TextEditingController();
//   TextEditingController _address = TextEditingController();
//   TextEditingController _customerEmail = TextEditingController();
//   TextEditingController _customerPhone = TextEditingController();
//   TextEditingController _confirmPassword = TextEditingController();
//   final String _baseUrl = baseUrl;
//   Future<void> updateProfile() async {
//     final response = await http.post(
//       Uri.parse('$_baseUrl/updateCustomers'),
//       body: jsonEncode({
//         'customerId': _customerId.text,
//         'customerName': _customerName.text,
//         'address': _address.text,
//         'customerEmail': _customerEmail.text,
//         'customerPhone': _customerPhone.text,
//         'confirmPassword': _confirmPassword.text,
//       }),
//       headers: {"Content-Type": "application/json"},
//     );
//
//     if (response.statusCode == 200) {
//       // Handle successful profile update, e.g., show a success message
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text('Success'),
//             content: Text('Profile updated successfully.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   // You can navigate to another screen after a successful update
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       // Handle profile update failure, e.g., show an error message
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text('Error'),
//             content: Text('Failed to update profile. Please try again.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     screenHeight = MediaQuery.of(context).size.height;
//     screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       // backgroundColor: cl6,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               margin: EdgeInsets.only(top: 10, bottom: 10),
//               alignment: Alignment.center,
//               height: 150,
//               width: 150,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: primary,
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Image.asset(
//                   "assets/images/myimage1.jpg",
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   height: double.infinity,
//                 ),
//               ),
//             ),
//             // Align(
//             //   alignment: Alignment.center,
//             //   child: buildTextFormField(
//             //     hintText: 'Customer Name',
//             //     dataKey: 'name',
//             //   ),
//             // ),
//
//             SizedBox(height: 15,),
//             Container(
//               alignment: Alignment.centerLeft,
//               margin: EdgeInsets.only(left: 10),
//               child: Text(
//                 'User Id',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold
//                 ),
//               ),
//             ),
//             buildTextFormField(
//               hintText: 'Customer Id',
//               dataKey: 'customerId',
//             ),
//             SizedBox(height: 15,),
//             Container(
//               alignment: Alignment.centerLeft,
//               margin: EdgeInsets.only(left: 10),
//               child: Text(
//                 'Meter NO',
//                 style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold
//                 ),
//               ),
//             ),
//             buildTextFormField(
//               hintText: 'Meter No',
//               dataKey: 'meterNo',
//             ),
//             SizedBox(height: 15,),
//             Container(
//               alignment: Alignment.centerLeft,
//               margin: EdgeInsets.only(left: 10),
//               child: Text(
//                 'User Name',
//                 style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold
//                 ),
//               ),
//             ),
//             buildTextFormField(
//               hintText: 'Customer Name',
//               dataKey: 'name',
//             ),
//             SizedBox(height: 15,),
//             Container(
//               alignment: Alignment.centerLeft,
//               margin: EdgeInsets.only(left: 10),
//               child: Text(
//                 'User Address',
//                 style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold
//                 ),
//               ),
//             ),
//             buildTextFormField(
//               hintText: 'Customer Address',
//               dataKey: 'address',
//             ),
//             SizedBox(height: 15,),
//             Container(
//               alignment: Alignment.centerLeft,
//               margin: EdgeInsets.only(left: 10),
//               child: Text(
//                 'User Email',
//                 style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold
//                 ),
//               ),
//             ),
//             buildTextFormField(
//               hintText: 'Customer Email',
//               dataKey: 'email',
//             ),
//             SizedBox(height: 15,),
//             Container(
//               alignment: Alignment.centerLeft,
//               margin: EdgeInsets.only(left: 10),
//               child: Text(
//                 'User Phone',
//                 style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold
//                 ),
//               ),
//             ),
//             buildTextFormField(
//               hintText: 'Customer Phone',
//               dataKey: 'phone',
//             ),
//             SizedBox(height: 10),
//             GestureDetector(
//               onTap: (){
//
//               },
//               child: Container(
//                 alignment: Alignment.centerLeft,
//                 margin: EdgeInsets.only(left: 10,right: 10, top: 8, bottom: 20),
//                 height: 50,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20.0),
//                   color: Colors.cyan,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 10,
//                       offset: Offset(2, 2),
//                     ),
//                   ],
//                 ),
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: Text(
//                     'Update',
//                     style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       color: Colors.white
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Helper method to build a TextFormField with data from SharedPreferences.
//   Widget buildTextFormField({
//     required String hintText,
//     required String dataKey,
//   }) {
//     return FutureBuilder<String?>(
//       future: SharedPreferences.getInstance().then((prefs) => prefs.getString(dataKey)),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator(); // Show a loading indicator while waiting for data
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           // Populate the TextFormField with the retrieved data
//           return Container(
//             margin: EdgeInsets.only(left: 10, right: 10),
//             child: TextFormField(
//               cursorColor: Colors.black,
//               maxLines: 1,
//               decoration: InputDecoration(
//                 hintText: hintText,
//                 hintStyle: TextStyle(
//                   fontSize: 20,
//                   color: Colors.black,
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.black,
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               initialValue: snapshot.data ?? '',
//             ),
//           );
//         }
//       },
//     );
//   }
// }






// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:login_ui/models/apikey.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   double screenHeight = 0;
//   double screenWidth = 0;
//   TextEditingController _customerId = TextEditingController();
//   TextEditingController _meterNo = TextEditingController();
//   TextEditingController _customerName = TextEditingController();
//   TextEditingController _address = TextEditingController();
//   TextEditingController _customerEmail = TextEditingController();
//   TextEditingController _customerPhone = TextEditingController();
//   TextEditingController _confirmPassword = TextEditingController();
//   final String _baseUrl = baseUrl; // Replace with your API base URL
//
//   @override
//   void initState() {
//     super.initState();
//     // Fetch and set initial values from SharedPreferences
//     fetchInitialValues();
//   }
//
//   Future<void> fetchInitialValues() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     _customerId.text = prefs.getString('customerId') ?? "";
//     _meterNo.text = prefs.getString('meterNo') ?? "";
//     _customerName.text = prefs.getString('customerName') ?? "";
//     _address.text = prefs.getString('address') ?? "";
//     _customerEmail.text = prefs.getString('customerEmail') ?? "";
//     _customerPhone.text = prefs.getString('customerPhone') ?? "";
//     _confirmPassword.text = prefs.getString('confirmPassword') ?? "";
//   }
//
//   Future<void> updateProfile() async {
//     final response = await http.post(
//       Uri.parse('$_baseUrl/updateCustomers'),
//       body: jsonEncode({
//         'customerId': _customerId.text,
//         'customerName': _customerName.text,
//         'address': _address.text,
//         'customerEmail': _customerEmail.text,
//         'customerPhone': _customerPhone.text,
//         'confirmPassword': _confirmPassword.text,
//       }),
//       headers: {"Content-Type": "application/json"},
//     );
//
//     if (response.statusCode == 200) {
//       // Handle successful profile update, e.g., show a success message
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text('Success'),
//             content: Text('Profile updated successfully.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   // You can navigate to another screen after a successful update
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       // Handle profile update failure, e.g., show an error message
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text('Error'),
//             content: Text('Failed to update profile. Please try again.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     screenHeight = MediaQuery.of(context).size.height;
//     screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               margin: EdgeInsets.only(top: 10, bottom: 10),
//               alignment: Alignment.center,
//               height: 150,
//               width: 150,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: Colors.blue,
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Image.asset(
//                   "assets/images/myimage1.jpg",
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   height: double.infinity,
//                 ),
//               ),
//             ),
//
//             SizedBox(height: 15),
//             Container(
//               alignment: Alignment.centerLeft,
//               margin: EdgeInsets.only(left: 10),
//               child: Text(
//                 'User Id',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             buildTextFormField(
//               hintText: 'Customer Id',
//               controller: _customerId,
//             ),
//             SizedBox(height: 15,),
//             Container(
//               alignment: Alignment.centerLeft,
//               margin: EdgeInsets.only(left: 10),
//               child: Text(
//                 'Meter NO',
//                 style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold
//                 ),
//               ),
//             ),
//             buildTextFormField(
//               hintText: 'Meter No',
//               controller: _meterNo
//             ),
//             SizedBox(height: 15,),
//             Container(
//               alignment: Alignment.centerLeft,
//               margin: EdgeInsets.only(left: 10),
//               child: Text(
//                 'User Name',
//                 style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold
//                 ),
//               ),
//             ),
//             buildTextFormField(
//               hintText: 'Customer Name',
//               controller: _customerName
//             ),
//             SizedBox(height: 15,),
//             Container(
//               alignment: Alignment.centerLeft,
//               margin: EdgeInsets.only(left: 10),
//               child: Text(
//                 'User Address',
//                 style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold
//                 ),
//               ),
//             ),
//             buildTextFormField(
//               hintText: 'Customer Address',
//               controller: _address
//             ),
//             SizedBox(height: 15,),
//             Container(
//               alignment: Alignment.centerLeft,
//               margin: EdgeInsets.only(left: 10),
//               child: Text(
//                 'User Email',
//                 style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold
//                 ),
//               ),
//             ),
//             buildTextFormField(
//               hintText: 'Customer Email',
//               controller: _customerEmail
//             ),
//             SizedBox(height: 15,),
//             Container(
//               alignment: Alignment.centerLeft,
//               margin: EdgeInsets.only(left: 10),
//               child: Text(
//                 'User Phone',
//                 style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold
//                 ),
//               ),
//             ),
//             buildTextFormField(
//               hintText: 'Customer Phone',
//               controller: _customerPhone
//             ),
//             SizedBox(height: 10),
//
//             SizedBox(height: 15),
//             GestureDetector(
//               onTap: () {
//                 // Call the updateProfile method to update customer information
//                 updateProfile();
//               },
//               child: Container(
//                 alignment: Alignment.centerLeft,
//                 margin: EdgeInsets.only(
//                   left: 10,
//                   right: 10,
//                   top: 8,
//                   bottom: 20,
//                 ),
//                 height: 50,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20.0),
//                   color: Colors.cyan,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 10,
//                       offset: Offset(2, 2),
//                     ),
//                   ],
//                 ),
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: Text(
//                     'Update',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildTextFormField({
//     required String hintText,
//     required TextEditingController controller,
//   }) {
//     return Container(
//       margin: EdgeInsets.only(left: 10, right: 10),
//       child: TextFormField(
//         controller: controller,
//         cursorColor: Colors.black,
//         maxLines: 1,
//         decoration: InputDecoration(
//           hintText: hintText,
//           hintStyle: TextStyle(
//             fontSize: 20,
//             color: Colors.black,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.black,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login_ui/models/apikey.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  TextEditingController _customerId = TextEditingController();
  TextEditingController _meterNo = TextEditingController();
  TextEditingController _customerName = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _customerEmail = TextEditingController();
  TextEditingController _customerPhone = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  final String _baseUrl = baseUrl; // Replace with your API base URL

  @override
  void initState() {
    super.initState();
    // Fetch and set initial values from SharedPreferences
    fetchInitialValues();
  }

  Future<void> fetchInitialValues() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? customerId = prefs.getString('customerId');
    if (customerId != null) {
      // Set the customerId to the text field
      _customerId.text = customerId;

      try {
        final response = await http.get(
          Uri.parse('$_baseUrl/customerProfile/$customerId'), // Replace with your API endpoint for fetching customer data
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> data = jsonDecode(response.body);
          _meterNo.text = data['meterNo'] ?? "";
          _customerName.text = data['customerName'] ?? "";
          _address.text = data['address'] ?? "";
          _customerEmail.text = data['customerEmail'] ?? "";
          _customerPhone.text = data['customerPhone'] ?? "";
          _confirmPassword.text = data['confirmPassword'] ?? "";
        } else {
          // Handle error when fetching data from the server
        }
      } catch (e) {
        // Handle exceptions if any
      }
    }
  }

  Future<void> updateProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? customerId = prefs.getString('customerId');

    final response = await http.post(
      Uri.parse('$_baseUrl/updateCustomers/$customerId'), // Include customerId in the URL
      body: jsonEncode({
        'customerId': _customerId.text,
        'customerName': _customerName.text,
        'address': _address.text,
        'customerEmail': _customerEmail.text,
        'customerPhone': _customerPhone.text,
        'confirmPassword': _confirmPassword.text,
      }),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      // Handle successful profile update, e.g., show a success message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Profile updated successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // You can navigate to another screen after a successful update
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Handle profile update failure, e.g., show an error message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to update profile. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void showSnackbar(String message) async{
    await ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              alignment: Alignment.center,
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/images/myimage1.jpg",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10),
              child: Text(
                'User Id',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  showSnackbar("You can't edit this field");
                });
              },
              child: buildTextFormField(
                hintText: 'Customer Id',
                controller: _customerId,
                enabled: true
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'This Field isn\'t editable',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 15
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10),
              child: Text(
                'Meter NO',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            buildTextFormField(
                hintText: 'Meter No',
                controller: _meterNo,
                enabled: true
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'This Field isn\'t editable',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10),
              child: Text(
                'User Name',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            buildTextFormField(
                hintText: 'Customer Name',
                controller: _customerName,
                enabled: false
            ),
            SizedBox(height: 15,),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10),
              child: Text(
                'User Address',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            buildTextFormField(
                hintText: 'Customer Address',
                controller: _address,
              enabled: false
            ),
            SizedBox(height: 15,),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10),
              child: Text(
                'User Email',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            buildTextFormField(
                hintText: 'Customer Email',
                controller: _customerEmail,
              enabled: false
            ),
            SizedBox(height: 15,),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10),
              child: Text(
                'User Phone',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            buildTextFormField(
                hintText: 'Customer Phone',
                controller: _customerPhone,
              enabled: false
            ),

            SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                // Call the updateProfile method to update customer information
                updateProfile();
              },
              child: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 8,
                  bottom: 20,
                ),
                height: 50,
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
                    'Update',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextFormField({
    required String hintText,
    required TextEditingController controller,
    bool enabled = true,
  }) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.black,
        maxLines: 1,
        readOnly: enabled,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}


