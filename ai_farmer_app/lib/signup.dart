import 'dart:convert';
import 'package:ai_farmer_app/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:ai_farmer_app/Constants/app_colors.dart';
import 'package:ai_farmer_app/bottomnavbar.dart';
import 'package:ai_farmer_app/home.dart';
import 'package:ai_farmer_app/login.dart';
import 'package:ai_farmer_app/utility/customtextformfield.dart';
import 'package:ai_farmer_app/utility/sizedbox_util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp_Page extends StatefulWidget {
  const SignUp_Page({super.key});

  @override
  State<SignUp_Page> createState() => _SignUp_PageState();
}

class _SignUp_PageState extends State<SignUp_Page> {
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final confirmpassword = TextEditingController();
  bool visiblePass = true;
  bool visibleConfPass = true;
  String? confirmPasswordError;
  final globalKey = GlobalKey<FormState>();
  String lastName = "";
  String firstName = "";
  // void mergestring() {
  //   String name = "${widget.firstname} ${widget.lastname}";
  //   SharedPreferencesHelper.setcustomername(name: name);
  // }

  signup() async {
    print("Into the signup function");

    String names = name.text.trim();

    // Split the name by space
    List<String> parts = names.split(' ');

    // Initialize firstName and lastName
    String firstName = '';
    String lastName = '';

    // Make sure the name has at least two parts
    if (parts.length >= 2) {
      firstName = parts[0];
      lastName =
          parts.sublist(1).join(' '); // Join remaining parts for lastName
      print('First Name: $firstName');
      print('Last Name: $lastName');
    } else {
      print('Invalid name format');
      return; // Exit early if the name is invalid
    }

    Map<String, dynamic> bodydata = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email.text.trim(),
      "password": password.text,
    };

    print(bodydata);

    var response = await http.post(
      Uri.parse("https://ecommerce-backend-deploying.vercel.app/api/signup"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(bodydata),
    );

    if (response.statusCode == 200 && !response.body.contains("error")) {
      setState(() {
        debugPrint("Success");
        var responseData = jsonDecode(response.body);
        print(responseData);
        var token = responseData['token'];
        print("Token: $token");
        SharedPreferencesHelper.setIsLoggedIn(status: true);
        SharedPreferencesHelper.setfirstname(firstname: firstName);
        SharedPreferencesHelper.setlastname(lastname: lastName);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home_Page()),
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
      debugPrint("Failed to create booking. Status code: ${response.body}");
    }
  }

  void validatePassword() {
    setState(() {
      if (password.text != confirmpassword.text) {
        confirmPasswordError = "Passwords do not match";
      } else {
        confirmPasswordError = null;
      }
    });
  }

  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: globalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Namaskar!",
                  style: const TextStyle(
                    fontFamily: "popR",
                    color: AppColors.green,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                // const Text.rich(
                //   TextSpan(
                //     children: [
                //       TextSpan(
                //         text: "Crea\n",
                //         style: TextStyle(
                //           fontSize: 20,
                //           fontWeight: FontWeight.w500,
                //           color: AppColors.black,
                //         ),
                //       ),
                //     ],
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                vSize(20),
                SizedBox(
                    height: h * 0.2,
                    child: Image.asset("assets/images/login.jpg")),
                SizedBox(
                  width: 0.9 * w,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextFormField(
                      controller: name,
                      hintText: "Full Name",
                      errortext: "Pls enter valid Name",
                    ),
                  ),
                ),

                SizedBox(
                  width: 0.9 * w,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextFormField(
                      controller: email,
                      hintText: "Email",
                      errortext: "Pls enter valid email address",
                    ),
                  ),
                ),
                SizedBox(
                  width: 0.9 * w,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: password,
                      obscureText: visiblePass,
                      decoration: InputDecoration(
                        hintText: "Password",
                        filled: true,
                        fillColor: Color.fromARGB(255, 185, 246, 213),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              width: 2, color: AppColors.green),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              width: 2, color: Colors.transparent),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              visiblePass = !visiblePass;
                            });
                          },
                          child: visiblePass
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter valid password";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                vSize(20),
                SizedBox(
                  width: 0.9 * w,
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        signup();
                        // void splitName() {
                        //   String names = name.text;

                        //   // Split the name by the space
                        //   List<String> parts = names.split(' ');

                        //   // Make sure the name has at least two parts
                        //   if (parts.length >= 2) {
                        //     firstName = parts[0]; // "John"
                        //     lastName = parts[1]; // "Paul"

                        //     print('First Name: $firstName');
                        //     print('Last Name: $lastName');
                        //   } else {
                        //     print('Invalid name format');
                        //   }
                        // }

                        // if (password.text == confirmpassword.text &&
                        //     globalKey.currentState!.validate()) {
                        //   signup();
                        //   SharedPreferencesHelper.setfirstname(
                        //       firstname: widget.firstname);
                        //   SharedPreferencesHelper.setlastname(
                        //       lastname: widget.lastname);
                        //   SharedPreferencesHelper.setcustomername(
                        //       name: widget.username);
                        //   SharedPreferencesHelper.setPhoneNumber(
                        //       phoneNumber: widget.phonenumber);
                        // } else {
                        //   setState(() {
                        //     confirmPasswordError = "Passwords do not match";
                        //   });
                        // }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Sign In",
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
                              builder: (context) => const Login_Page()));
                    });
                  },
                  child: const Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: "popR",
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

 // SizedBox(
                //   width: 0.9 * w,
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: TextFormField(
                //       controller: confirmpassword,
                //       obscureText: visibleConfPass,
                //       onChanged: (value) {
                //         validatePassword();
                //       },
                //       decoration: InputDecoration(
                //         hintText: "Confirm Password",
                //         filled: true,
                //         fillColor: Color.fromARGB(255, 185, 246, 213),
                //         focusedBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(30),
                //           borderSide: const BorderSide(
                //               width: 2, color: AppColors.green),
                //         ),
                //         enabledBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(30),
                //           borderSide: const BorderSide(
                //               width: 2, color: Colors.transparent),
                //         ),
                //         errorText: confirmPasswordError,
                //         suffixIcon: GestureDetector(
                //           onTap: () {
                //             setState(() {
                //               visibleConfPass = !visibleConfPass;
                //             });
                //           },
                //           child: visibleConfPass
                //               ? const Icon(Icons.visibility)
                //               : const Icon(Icons.visibility_off),
                //         ),
                //       ),
                //       validator: (value) {
                //         if (value == null || value.isEmpty) {
                //           return "Enter valid password";
                //         }
                //         return null;
                //       },
                //     ),
                //   ),
                // ),


                // void signup() async {
  //   debugPrint("into the signup func");

  //   Map<String, dynamic> bodydata = {
  //     "email": email.text.trim(),
  //     "username": widget.username.trim(),
  //     "password": confirmpassword.text.trim(),
  //     "first_name": widget.firstname.trim(),
  //     "last_name": widget.lastname.trim(),
  //     "user_type": "customer",
  //   };

  //   var response = await http.post(
  //     Uri.parse("https://api.thinklocal.ai/signup"),
  //     headers: {
  //       "Content-Type": "application/json",
  //     },
  //     body: jsonEncode(bodydata),
  //   );

  //   print(response.body);

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       debugPrint("success signup");
  //     });
  //     Map<String, dynamic> loginData = {
  //       "username": widget.username.trim(),
  //       "password": password.text.trim(),
  //     };
  //     var resLogin = await http.post(
  //       Uri.parse("https://api.thinklocal.ai/login"),
  //       headers: {
  //         "Content-Type": "application/json",
  //       },
  //       body: jsonEncode(loginData),
  //     );
  //     if (response.statusCode == 200 && !response.body.contains("error")) {
  //       setState(() {
  //         debugPrint("success login");
  //         var responseData = jsonDecode(response.body);
  //         print(responseData);
  //         var token = responseData['token'];
  //         print("token: $token");

  //         SharedPreferencesHelper.setToken(apiKey: token);
  //         SharedPreferencesHelper.setIsLoggedIn(status: true);

  //         Navigator.push(context,
  //             MaterialPageRoute(builder: (context) => const BottomNavBar()));
  //         Fluttertoast.showToast(
  //           msg: 'Successfully Signed Up',
  //           backgroundColor: Color(0xffFFDFDF),
  //           textColor: AppColors.green,
  //         );
  //       });
  //     } else {
  //       Fluttertoast.showToast(
  //         msg: 'Sorry! Something went wrong',
  //         backgroundColor: Color(0xffFFDFDF),
  //         textColor: AppColors.green,
  //       );
  //       debugPrint("Failed to login. Status code: ${response.body}");
  //     }
  //   } else {
  //     Fluttertoast.showToast(
  //       msg: 'Sorry! Something went wrong',
  //       backgroundColor: Color(0xffFFDFDF),
  //       textColor: AppColors.green,
  //     );
  //     debugPrint("Failed to signup. Status code: ${response.statusCode}");
  //   }
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   print(widget.phonenumber);
  // }