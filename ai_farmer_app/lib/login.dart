import 'dart:convert';
import 'package:ai_farmer_app/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ai_farmer_app/Constants/app_colors.dart';
import 'package:ai_farmer_app/bottomnavbar.dart';
import 'package:ai_farmer_app/home.dart';
import 'package:ai_farmer_app/signup.dart';
import 'package:ai_farmer_app/utility/customtextformfield.dart';
import 'package:ai_farmer_app/utility/sizedbox_util.dart';
import 'package:flutter/material.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  final username = TextEditingController();
  final password = TextEditingController();
  bool visible = true;
  final globalKey = GlobalKey<FormState>();

  login() async {
    print("into the login func");

    // Trim any whitespace from email and password fields
    String emailInput = username.text.trim();
    String passwordInput = password.text.trim();

    if (emailInput.isEmpty || passwordInput.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Email and Password are required',
        backgroundColor: Color(0xffFFDFDF),
        textColor: AppColors.greenn,
      );
      return;
    }

    Map<String, dynamic> bodydata = {
      "email": emailInput,
      "password": passwordInput,
    };
    print(bodydata);

    var response = await http.post(
      Uri.parse("https://ecommerce-backend-deploying.vercel.app/api/signin"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(bodydata),
    );

    if (response.statusCode == 200 && !response.body.contains("error")) {
      setState(() {
        debugPrint("success");
        var responseData = jsonDecode(response.body);
        print(responseData);
        var token = responseData['token'];
        print("token: $token");
        SharedPreferencesHelper.setIsLoggedIn(status: true);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BootomNavBar()),
        );
        Fluttertoast.showToast(
          msg: 'Successfully Logged In',
          backgroundColor: Color(0xffFFDFDF),
          textColor: AppColors.greenn,
        );
      });
    } else {
      Fluttertoast.showToast(
        msg: 'Sorry! Something went wrong',
        backgroundColor: Color(0xffFFDFDF),
        textColor: AppColors.greenn,
      );
      print("${username.text}-${password.text}-");
      debugPrint("Failed to create booking. Status code: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: globalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    child: const Column(
                      children: [
                        Text(
                          "Login here",
                          style: TextStyle(
                            fontFamily: "popR",
                            color: AppColors.green,
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Welcome back !\n",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                              ),
                              // TextSpan(
                              //   text: "been missed!",
                              //   style: TextStyle(
                              //     fontSize: 20,
                              //     fontWeight: FontWeight.w500,
                              //     color: AppColors.black,
                              //   ),
                              // ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                vSize(20),
                SizedBox(
                    height: h * 0.2,
                    child: Image.asset("assets/images/login.jpg")),
                SizedBox(
                  width: 0.9 * w,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextFormField(
                        controller: username,
                        hintText: "Email",
                        // labelText: "Email",
                        errortext: "Pls enter your registegreen email-id"),
                  ),
                ),
                // vSize(10),
                SizedBox(
                  width: 0.9 * w,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: password,
                      obscureText: visible,
                      decoration: InputDecoration(
                        hintText: "Password",
                        filled: true,
                        fillColor: Color.fromARGB(255, 185, 246, 213),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                width: 2, color: AppColors.green)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                width: 2, color: Colors.transparent)),
                        // labelText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              visible = !visible;
                            });
                          },
                          child: visible
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter valid password";
                        }
                      },
                    ),
                  ),
                ),
                vSize(20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 0.87 * w,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        // if (globalKey.currentState!.validate()) {
                        //   // login();
                        // }
                        login();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.white,
                          fontFamily: "popR",
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      // selection = !selection;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp_Page()));
                    });
                  },
                  child: const Text(
                    "Create new Account",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: "popR",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


//login function here
  // login() async {
  //   print("into the login func");

  //   Map<String, dynamic> bodydata = {
  //     "username": username.text.trim(),
  //     "password": password.text.trim(),
  //   };
  //   print(bodydata);

  //   var response = await http.post(
  //     Uri.parse("https://api.thinklocal.ai/login"),
  //     headers: {
  //       "Content-Type": "application/json",
  //     },
  //     body: jsonEncode(bodydata),
  //   );

  //   if (response.statusCode == 200 && !response.body.contains("error")) {
  //     setState(() {
  //       debugPrint("success");
  //       var responseData = jsonDecode(response.body);
  //       print(responseData);
  //       var token = responseData['token'];
  //       print("token: $token");

  //       ShagreenPreferencesHelper.setToken(apiKey: token);
  //       ShagreenPreferencesHelper.setIsLoggedIn(status: true);

  //       Navigator.pushReplacement(context,
  //           MaterialPageRoute(builder: (context) => const BottomNavBar()));
  //       Fluttertoast.showToast(
  //         msg: 'Successfully Logged In',
  //         backgroundColor: Color(0xffFFDFDF),
  //         textColor: AppColors.green,
  //       );
  //     });
  //   } else {
  //     Fluttertoast.showToast(
  //       msg: 'Sorry! Something went wrong',
  //       backgroundColor: Color(0xffFFDFDF),
  //       textColor: AppColors.green,
  //     );
  //     print("${username.text}-${password.text}-");
  //     debugPrint("Failed to create booking. Status code: ${response.body}");
  //   }
  // }
