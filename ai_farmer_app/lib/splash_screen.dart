import 'dart:async';
import 'package:ai_farmer_app/Constants/app_colors.dart';
import 'package:ai_farmer_app/login.dart';
import 'package:ai_farmer_app/shared_preferences.dart';

import 'package:flutter/material.dart';

import 'package:ai_farmer_app/bottomnavbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        Duration(
            // seconds: 50
            milliseconds: 2500), () {
      if (SharedPreferencesHelper.getIsLoggedIn() == true) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BootomNavBar()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Login_Page()));
      }
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffFFFFFF),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/splash.png"),
            ],
          ),
        ));
  }
}
