import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:login_ui/models/MonthCharts.dart';
import 'package:login_ui/models/apikey.dart';
import 'package:login_ui/models/charts.dart';
import 'package:login_ui/models/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Dashboards> fetchAlbum(String url) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String meterNo = prefs.getString('meterNo') ?? "";
  final response = await http.get(Uri.parse(url + '/' + meterNo));

  if (response.statusCode == 200) {
    return Dashboards.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

Future<MonthCharts?> getMonthUnit(String url) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String meterNo = prefs.getString('meterNO') ?? "";
  final response = await http.get(Uri.parse(url + '/' + meterNo));
  if (response.statusCode == 200) {
    return MonthCharts.fromJson(jsonDecode(response.body));
  } else {
    print('Error1: Error while fetching data.');
    return null;
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color(0xFF2661FA);
  Color cl1 = const Color(0xFF95F1F0);
  Color cl2 = const Color(0xFFF4AAAA);
  Color cl3 = const Color(0xFFF9A46C);
  Color cl4 = const Color(0xFF65A9BB);
  Color cl5 = const Color(0xFF915354);
  Color cl6 = const Color(0xFFB4B6FF);
  final String _baseUrl = baseUrl;
  late Future<Dashboards> futureAlbum;
  late Future<Dashboards> futureAlbum1;
  late Future<Dashboards> futureAlbum2;
  late Future<Dashboards> futureAlbum3;

  //For Unit Chatr
  late Future<MonthCharts?> getMonthUnitJan;
  late Future<MonthCharts?> getMonthUnitFeb;
  late Future<MonthCharts?> getMonthUnitMar;
  late Future<MonthCharts?> getMonthUnitApr;
  late Future<MonthCharts?> getMonthUnitMay;
  late Future<MonthCharts?> getMonthUnitJune;
  late Future<MonthCharts?> getMonthUnitJul;
  late Future<MonthCharts?> getMonthUnitAug;
  late Future<MonthCharts?> getMonthUnitSep;
  late Future<MonthCharts?> getMonthUnitOct;
  late Future<MonthCharts?> getMonthUnitNov;
  late Future<MonthCharts?> getMonthUnitDec;
  String? januaryValue;
  String? februaryValue;
  String? marchValue;
  String? aprilValue;
  String? mayValue;
  String? juneValue;
  String? julyValue;
  String? augustValue;
  String? septemberValue;
  String? octoberValue;
  String? novemberValue;
  String? decemberValue;
  PageController _pageController = PageController(initialPage: 0);

  //Bar charts
  List<Charts> _list = List<Charts>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum('$_baseUrl/totalPaidAmt/{fineTotal}');
    futureAlbum1 = fetchAlbum('$_baseUrl/pendingBillsRow/{pendingBills}');
    futureAlbum2 = fetchAlbum('$_baseUrl/totalPendingAmt/{totalBill}');
    futureAlbum3 = fetchAlbum('$_baseUrl/getPendingBillMonth');
    // Monthly Unit Chart
    getMonthUnitJan = getMonthUnit('$_baseUrl/januaryUnits');
    getMonthUnitFeb = getMonthUnit('$_baseUrl/februaryUnits');
    getMonthUnitMar = getMonthUnit('$_baseUrl/marchUnits');
    getMonthUnitApr = getMonthUnit('$_baseUrl/aprilUnits');
    getMonthUnitMay = getMonthUnit('$_baseUrl/mayUnits');
    getMonthUnitJune = getMonthUnit('$_baseUrl/juneUnits');
    getMonthUnitJul = getMonthUnit('$_baseUrl/julyUnits');
    getMonthUnitAug = getMonthUnit('$_baseUrl/augustUnits');
    getMonthUnitSep = getMonthUnit('$_baseUrl/septemberUnits');
    getMonthUnitOct = getMonthUnit('$_baseUrl/octoberUnits');
    getMonthUnitNov = getMonthUnit('$_baseUrl/novemberUnits');
    getMonthUnitDec = getMonthUnit('$_baseUrl/decemberUnits');
    fetchMonthlyUnitFields();
    fetchMonthlyUnitFields1();
    fetchMonthlyUnitFields2();
    fetchMonthlyUnitFields3();
    fetchMonthlyUnitFields4();
    fetchMonthlyUnitFields5();
    fetchMonthlyUnitFields6();
    fetchMonthlyUnitFields7();
    fetchMonthlyUnitFields8();
    fetchMonthlyUnitFields9();
    fetchMonthlyUnitFields10();
    fetchMonthlyUnitFields11();
  }

  Future<void> fetchMonthlyUnitFields() async {
    final monthcharts = await getMonthUnitJan;
    if (monthcharts != null) {
      setState(() {
        januaryValue = monthcharts.january;
      });
    } else {
      setState(() {
        januaryValue = '0.0';
      });
    }
  }

  Future<void> fetchMonthlyUnitFields1() async {
    final monthcharts = await getMonthUnitFeb;
    if (monthcharts != null) {
      setState(() {
        februaryValue = monthcharts.february;
      });
    } else {
      setState(() {
        februaryValue = 'No data found';
      });
    }
  }

  Future<void> fetchMonthlyUnitFields2() async {
    final monthcharts = await getMonthUnitMar;
    if (monthcharts != null) {
      setState(() {
        marchValue = monthcharts.march;
      });
    } else {
      setState(() {
        marchValue = 'No data found';
      });
    }
  }

  Future<void> fetchMonthlyUnitFields3() async {
    final monthcharts = await getMonthUnitApr;
    if (monthcharts != null) {
      setState(() {
        aprilValue = monthcharts.april;
      });
    } else {
      setState(() {
        aprilValue = 'No data found';
      });
    }
  }

  Future<void> fetchMonthlyUnitFields4() async {
    final monthcharts = await getMonthUnitMay;
    if (monthcharts != null) {
      setState(() {
        mayValue = monthcharts.may;
      });
    } else {
      setState(() {
        mayValue = 'No data found';
      });
    }
  }

  Future<void> fetchMonthlyUnitFields5() async {
    final monthcharts = await getMonthUnitJune;
    if (monthcharts != null) {
      setState(() {
        juneValue = monthcharts.june;
      });
    } else {
      setState(() {
        juneValue = 'No data found';
      });
    }
  }

  Future<void> fetchMonthlyUnitFields6() async {
    final monthcharts = await getMonthUnitJul;
    if (monthcharts != null) {
      setState(() {
        julyValue = monthcharts.july;
      });
    } else {
      setState(() {
        julyValue = 'No data found';
      });
    }
  }

  Future<void> fetchMonthlyUnitFields7() async {
    final monthcharts = await getMonthUnitAug;
    if (monthcharts != null) {
      setState(() {
        augustValue = monthcharts.august;
      });
    } else {
      setState(() {
        augustValue = 'No data found';
      });
    }
  }

  Future<void> fetchMonthlyUnitFields8() async {
    final monthcharts = await getMonthUnitSep;
    if (monthcharts != null) {
      setState(() {
        septemberValue = monthcharts.september;
      });
    } else {
      setState(() {
        septemberValue = 'No data found';
      });
    }
  }

  Future<void> fetchMonthlyUnitFields9() async {
    final monthcharts = await getMonthUnitOct;
    if (monthcharts != null) {
      setState(() {
        octoberValue = monthcharts.october;
      });
    } else {
      setState(() {
        octoberValue = 'No data found';
      });
    }
  }

  Future<void> fetchMonthlyUnitFields10() async {
    final monthcharts = await getMonthUnitNov;
    if (monthcharts != null) {
      setState(() {
        novemberValue = monthcharts.november;
      });
    } else {
      setState(() {
        novemberValue = 'No data found';
      });
    }
  }

  Future<void> fetchMonthlyUnitFields11() async {
    final monthcharts = await getMonthUnitDec;
    if (monthcharts != null) {
      setState(() {
        decemberValue = monthcharts.december;
      });
    } else {
      setState(() {
        decemberValue = 'No data found';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // backgroundColor: cl6,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [cl1, cl2], // Main container gradient
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
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
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Welcome to Dashboard',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 27,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [cl1, cl2], // Main container gradient
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    width: 340,
                    height: screenHeight / 5,
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total Paid Amount',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        FutureBuilder<Dashboards>(
                          future: futureAlbum,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else {
                              final fineTotal = snapshot.hasData &&
                                      snapshot.data!.fineTotal != null
                                  ? snapshot.data!.fineTotal.toString()
                                  : "0.0";
                              final formatter = NumberFormat("#,##0.00",
                                  "en_US"); // Use en_US locale for formatting
                              final formattedFineTotal =
                                  formatter.format(double.parse(fineTotal));
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          cl3,
                                          cl4
                                        ], // Child container gradient
                                      ),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    alignment: Alignment.center,
                                    width: 500,
                                    height: 60,
                                    child: Text(
                                      '৳ $formattedFineTotal',
                                      // Display formatted fineTotal with Bangladeshi Taka sign
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: cl5,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [cl1, cl2], // Main container gradient
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    width: 340,
                    height: screenHeight / 5,
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total Pending Bills',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        FutureBuilder<Dashboards>(
                          future: futureAlbum1,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else {
                              final pendingBills = snapshot.hasData
                                  ? snapshot.data!.pendingBills.toString()
                                  : "0.0";
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          cl3,
                                          cl4
                                        ], // Child container gradient
                                      ),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    alignment: Alignment.center,
                                    width: 500,
                                    height: 60,
                                    child: Text(
                                      pendingBills,
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: cl5,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [cl1, cl2], // Main container gradient
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    width: 340,
                    height: screenHeight / 5,
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pending Bill Amount',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FutureBuilder<Dashboards>(
                          future: futureAlbum2,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else {
                              final totalBill = snapshot.hasData &&
                                      snapshot.data!.totalBill != null
                                  ? snapshot.data!.totalBill.toString()
                                  : "0.0";
                              final formatter = NumberFormat("#,##0.00",
                                  "en_US"); // Use en_US locale for formatting
                              final formattedTotalBill =
                                  formatter.format(double.parse(totalBill));
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          cl3,
                                          cl4
                                        ], // Child container gradient
                                      ),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    alignment: Alignment.center,
                                    width: 500,
                                    height: 60,
                                    child: Text(
                                      '৳ $formattedTotalBill',
                                      // Display formatted fineTotal with Bangladeshi Taka sign
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: cl5,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [cl1, cl2], // Main container gradient
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    width: 340,
                    height: screenHeight / 5,
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pending Bill Month',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FutureBuilder<Dashboards>(
                          future: futureAlbum3,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else {
                              final month = snapshot.hasData
                                  ? snapshot.data!.month
                                  : "No Pending Month";
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          cl3,
                                          cl4
                                        ], // Child container gradient
                                      ),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    alignment: Alignment.center,
                                    width: 500,
                                    height: 60,
                                    child: Text(
                                      month,
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: cl5,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
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
            SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [cl1, cl2], // Main container gradient
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Align(
                        alignment:Alignment.center,
                        child: Text(
                          'Monthly Unit Charts',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8,),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [cl1, cl2], // Main container gradient
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(
                          left: 15, right: 10, top: 15, bottom: 10),
                      margin: EdgeInsets.only(left: 10, right: 10),
                      height: 250,
                      width: 200,
                      child: FutureBuilder(
                          future: Future.wait([
                            getMonthUnitJan,
                            getMonthUnitFeb,
                            getMonthUnitMar,
                            getMonthUnitApr,
                            getMonthUnitMay,
                            getMonthUnitJune,
                            getMonthUnitJul,
                            getMonthUnitAug,
                            getMonthUnitSep,
                            getMonthUnitOct,
                            getMonthUnitNov,
                            getMonthUnitDec,
                          ]),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else {
                              final values = [
                                double.parse(januaryValue ?? '0.0'),
                                double.parse(februaryValue ?? '0.0'),
                                double.parse(marchValue ?? '0.0'),
                                double.parse(aprilValue ?? '0.0'),
                                double.parse(mayValue ?? '0.0'),
                                double.parse(juneValue ?? '0.0'),
                                double.parse(julyValue ?? '0.0'),
                                double.parse(augustValue ?? '0.0'),
                                double.parse(septemberValue ?? '0.0'),
                                double.parse(octoberValue ?? '0.0'),
                                double.parse(novemberValue ?? '0.0'),
                                double.parse(decemberValue ?? '0.0'),
                              ];
                              return BarChart(
                                BarChartData(
                                  backgroundColor: Colors.white,
                                  barGroups: _chartGroups(values),
                                  borderData: FlBorderData(
                                      border: const Border(
                                          bottom: BorderSide(),
                                          left: BorderSide())),
                                  gridData: FlGridData(show: false),
                                  titlesData: FlTitlesData(
                                    bottomTitles:
                                        AxisTitles(sideTitles: _bottomTitles),
                                    leftTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                      showTitles: true,
                                      interval: 20,
                                      getTitlesWidget: (value, meta) {
                                        return Text(
                                          value.toInt().toString(),
                                          style: const TextStyle(fontSize: 10),
                                        );
                                      },
                                    )),
                                    topTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false)),
                                    rightTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false)),
                                  ),
                                  groupsSpace: 1,

                                ),
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> _chartGroups(List<double> values) {
    List<BarChartGroupData> list = List<BarChartGroupData>.empty(growable: true);
    List<Color> barColors = [
      Colors.blue, Colors.red, Colors.green, Colors.orange, Colors.blue, Colors.red, Colors.green,
      Colors.orange, Colors.blue, Colors.red, Colors.green, Colors.orange,
    ];

    for (int i = 0; i < values.length; i++) {
      // Use different colors for each bar
      list.add(
        BarChartGroupData(
          x: i,
          barRods: [BarChartRodData(toY: values[i], color: barColors[i])],
        ),
      );
    }
    return list;
  }
  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 0:
              text = 'Jan';
              break;
            case 1:
              text = 'Feb';
              break;
            case 2:
              text = 'Mar';
              break;
            case 3:
              text = 'Apr';
              break;
            case 4:
              text = 'May';
              break;
            case 5:
              text = 'Jun';
              break;
            case 6:
              text = 'Jul';
              break;
            case 7:
              text = 'Aug';
              break;
            case 8:
              text = 'Sep';
              break;
            case 9:
              text = 'Oct';
              break;
            case 10:
              text = 'Nov';
              break;
            case 11:
              text = 'Dec';
              break;
          }
          return Text(
            text,
            style: TextStyle(fontSize: 10),
          );
        },
      );
}
