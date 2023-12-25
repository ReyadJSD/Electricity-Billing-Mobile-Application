import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_ui/models/customer.dart';
import 'package:login_ui/screens/dashbord.dart';
import 'package:login_ui/screens/login.dart';
import 'package:login_ui/screens/operations.dart';
import 'package:login_ui/screens/profilescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color(0xFF2661FA);
  int currentIndex = 1;
  List<IconData> navigationIcons = [
    Icons.pending_actions,
    FontAwesomeIcons.dashboard,
    FontAwesomeIcons.user
  ];
  List<Widget> pages = [
    Operations(),
    Dashboard(),
    ProfileScreen(), // Add the ProfileScreen as one of the pages
  ];

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  String? userName;

  void getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('name') ?? "";
    setState(() {});
  }

  int _selectedIndex = 1; // Initialize with the desired default index

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $userName'),
        backgroundColor: Color(0xFF2661FA),
        actions: [
          IconButton(
            onPressed: () async {
              final SharedPreferences prefs =
              await SharedPreferences.getInstance();
              await prefs.remove('meterNo');
              await prefs.remove('name');
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
            },
            icon: Icon(
              Icons.logout,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.black54!,
              hoverColor: Colors.black54!,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 30,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: primary,
              color: Colors.black54,
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
              tabs: [
                GButton(
                  icon: Icons.pending_actions,
                  text: 'Operations',
                ),
                GButton(
                  icon: Icons.dashboard,
                  text: 'Dashboard',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                  currentIndex = index; // Update the currentIndex for your IndexedStack.
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
