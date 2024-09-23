import 'package:ai_farmer_app/Constants/app_colors.dart';
import 'package:ai_farmer_app/login.dart';
import 'package:ai_farmer_app/signup.dart';
import 'package:ai_farmer_app/utility/sizedbox_util.dart';
import 'package:flutter/material.dart';

class Welcome_Screen extends StatefulWidget {
  const Welcome_Screen({super.key});

  @override
  State<Welcome_Screen> createState() => _Welcome_ScreenState();
}

class _Welcome_ScreenState extends State<Welcome_Screen> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Welcome to ",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: h * 0.06,
              width: w * 0.8,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login_Page()));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: AppColors.green,
                  foregroundColor: AppColors.white,
                  shadowColor: Colors.grey.withOpacity(0.5),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "popR",
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            vSize(10),
            SizedBox(
              height: h * 0.06,
              width: w * 0.8,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp_Page()));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Color.fromARGB(255, 136, 242, 186),
                  foregroundColor: AppColors.black,
                  shadowColor: Colors.grey.withOpacity(0.5),
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "popR",
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
