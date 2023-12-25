import 'package:flutter/material.dart';
import 'package:login_ui/models/apikey.dart';
import 'package:login_ui/models/connection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ConnectionsScreen extends StatefulWidget {
  const ConnectionsScreen({Key? key}) : super(key: key);

  @override
  State<ConnectionsScreen> createState() => _ConnectionsScreenState();
}

class _ConnectionsScreenState extends State<ConnectionsScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color(0xFF2661FA);
  late Future<Connection> futureAlbum;
  final String _baseUrl = baseUrl;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum('$_baseUrl/customer');
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Connection Details'),
      ),
      body: SingleChildScrollView(
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
          child: FutureBuilder<Connection>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return Center(child: Text('No data available'));
              } else {
                final connection = snapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTextField('Name', connection.name),
                    buildTextField('Gender', connection.gender),
                    buildTextField('Meter No', connection.meterNo),
                    buildTextField('Meter Type', connection.meterType),
                    buildTextField('Issue Date', connection.issueDate),
                    buildTextField('District', connection.district),
                    buildTextField('Address', connection.address),
                    buildTextField('Email', connection.email),
                    buildTextField('Phone', connection.phone),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, String? value) {
    // String formattedValue = '';
    //
    // if (label == 'Issue Date' && value != null) {
    //   // Parse the DateTime from the string
    //   final issueDate = DateTime.tryParse(value);
    //   if (issueDate != null) {
    //     // Format the DateTime as "yyyy-MM-dd"
    //     formattedValue =
    //     "${issueDate.year}-${issueDate.month.toString().padLeft(2, '0')}-${issueDate.day.toString().padLeft(2, '0')}";
    //   }
    // } else {
    //   formattedValue = value != null ? value.toString() : '';
    // }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          initialValue: value,
          readOnly: true,
          style: TextStyle(
              color: Colors.black,
            fontSize: 20
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.blue[100],
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

Future<Connection> fetchAlbum(String url) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String meterNo = prefs.getString('meterNo') ?? "";
  final response = await http.get(Uri.parse(url + '/' + meterNo));

  if (response.statusCode == 200) {
    return Connection.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}
