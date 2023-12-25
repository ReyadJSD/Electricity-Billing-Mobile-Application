import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login_ui/screens/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key ? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState(){
    Timer(Duration(seconds: 3),() => Navigator.push(context, CupertinoPageRoute(builder: (_)=>LoginScreen())));
    // super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body:SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.black
                ),
                child: Image.asset("assets/images/electricity logo2.png"),
              ),
              Align(
                alignment: Alignment.center,
                child: Text('Electricity Billing System', style: TextStyle(
                  color: Colors.white,fontWeight: FontWeight.bold, fontSize: 30,
                ),),
              ),
              SizedBox(height: 20,),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
