import 'dart:convert';

import 'package:ai_farmer_app/Constants/app_colors.dart';
import 'package:ai_farmer_app/login.dart';
import 'package:ai_farmer_app/no_of_crops.dart';
import 'package:ai_farmer_app/notification.dart';
import 'package:ai_farmer_app/personal_land_insights.dart';
import 'package:ai_farmer_app/shared_preferences.dart';
import 'package:ai_farmer_app/utility/sizedbox_util.dart';
import 'package:ai_farmer_app/weather_forecast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  double temp = 0;
  int humidity = 0;
  double windspeed = 0;
  int pressure = 0;
  String weathercondition = '';
  String cityname = "mumbai";
  bool isLoading = false;
  double roundedTemp = 0;

  getWeather() async {
    try {
      print("into the func");
      setState(() {
        isLoading = true;
      });
      final apikey = '429fe6c2a4e8b682c98b1afc04bcf293';

      final response = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?q=mumbai&APPID=$apikey'),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          temp = (data['main']['temp'] - 273);
          humidity = (data['main']['humidity']);
          windspeed = (data['wind']['speed']);
          pressure = (data['main']['pressure']);
          weathercondition = (data['weather'][0]['description']);
          roundedTemp = double.parse(temp.toStringAsFixed(2));
          print(roundedTemp);
          print(humidity);
          print(windspeed);
          print(pressure);
        });
      } else {
        print("There's an error");
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  getpred() async {
    try {
      print("into the func");
      setState(() {
        isLoading = true;
      });
      Map<String, dynamic> bodydata = {};
      print(bodydata);
      final response = await http.post(
        Uri.parse('https://nfc-api-l2z3.onrender.com/crop_rec'),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(bodydata),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        responsepred = jsonDecode(response.body);
        debugPrint("success");
        print("###${responsepred["predictions"]}");
        croppred = responsepred["predictions"];
        croppredd = croppred[0];
        setState(() {});
      } else {
        print("There's an error");
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showlogoutdialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          content: Container(
            height: 185.0, // Set your desired height here
            width: 300.0, // Set your desired width here
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                ),
                Center(
                  child: Text(
                    'Are you sure you\n want to log out?',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: "popR",
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "popR",
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        SharedPreferencesHelper.setIsLoggedIn(status: false);
                        // SharedPreferencesHelper
                        //     .setToken(
                        //         apiKey:
                        //             "");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login_Page()));
                        // Navigator.of(context).pop();
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: AppColors.greenn,
                          fontSize: 20,
                          fontFamily: "popR",
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  var responsepred;
  var croppred;
  var croppredd;
  // getpred() async {
  //   print("into the crop func");

  //   Map<String, dynamic> bodydata = {};
  //   print(bodydata);
  //   try {
  //     var response = await http.post(
  //       Uri.parse("https://nfc-api-l2z3.onrender.com/crop_rec"),
  //       headers: {
  //         "Content-Type": "application/json",
  //       },
  //       body: jsonEncode(bodydata),
  //     );
  //     if (response.statusCode == 200) {
  //       responsepred = jsonDecode(response.body);
  //       debugPrint("success");
  //       print("###${responsepred["predictions"]}");
  //       croppred = responsepred["predictions"];
  //       setState(() {
  //         //   double predictedYield = responseData["Predicted Crop Yield"];
  //         //   res = predictedYield.toStringAsFixed(2);
  //         //   showlogoutdialog(context);
  //         //   print(res);
  //       });
  //     } else {
  //       debugPrint("Failed to get image. Status code: ${response.statusCode}");
  //       debugPrint("Response body: ${response.body}");
  //     }
  //   } catch (e) {
  //     debugPrint("Error making request: $e");
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // print("into the init state");
    getWeather();
    getpred();
  }

  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: ,
      // appBar: AppBar(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: AppColors.greenn,
            ))
          : SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: h * 0.3,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: AppColors.greenn,
                        ),
                        child: Column(
                          children: [
                            vSize(80),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // hSize(15),
                                  Row(
                                    children: [
                                      Container(
                                        height: h * 0.07,
                                        width: w * 0.16,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50)),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/person.jpg"),
                                                fit: BoxFit.fill)),
                                      ),
                                      hSize(10),
                                      GestureDetector(
                                        onTap: () {
                                          showlogoutdialog(context);
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Neel P",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.white,
                                              ),
                                            ),
                                            Text(
                                              "Mumbai, Maharashtra",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NotificationPage()));
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          height: h * 0.065,
                                          width: w * 0.13,
                                          decoration: const BoxDecoration(
                                              // boxShadow: ,
                                              color: AppColors.transparent,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: const Icon(
                                            Icons.notifications_active,
                                            color: AppColors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      vSize(160),
                      vSize(10),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                        child: Container(
                          height: h * 0.26,
                          width: w * 0.88,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 10.0, // soften the shadow
                                // spreadRadius: 1.0, //extend the shadow
                                offset: Offset(
                                  2.0, // Move to right 5  horizontally
                                  2.0, // Move to bottom 5 Vertically
                                ),
                              )
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Weather Forecast",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.black,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          // selection = !selection;
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      WeatherForecast_page(
                                                        temp: roundedTemp
                                                            .toString(),
                                                        humidity: humidity,
                                                        pressure: pressure,
                                                        wind: windspeed,
                                                      )));
                                        });
                                      },
                                      child: const Text(
                                        "See All",
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: AppColors.greenn,
                                          // fontFamily: "popR",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                vSize(10),
                                Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.location_on_outlined),
                                      hSize(10),
                                      Text(
                                        "Mumbai",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ]),
                                vSize(5),
                                Row(
                                  children: [
                                    hSize(5),
                                    Text(
                                      "${roundedTemp.toString()} ºC",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: AppColors.grey,
                                  thickness: 0.6,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // hSize(1),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Humidity",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.black,
                                          ),
                                        ),
                                        Text(
                                          "${humidity.toString()}%",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Pressure",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.black,
                                          ),
                                        ),
                                        Text(
                                          "${pressure.toString()} Atm",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Wind Speed",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.black,
                                          ),
                                        ),
                                        Text(
                                          "${windspeed.toString()} ",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      vSize(30),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                        child: Container(
                          height: h * 0.13,
                          width: w * 0.88,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 10.0, // soften the shadow
                                // spreadRadius: 1.0, //extend the shadow
                                offset: Offset(
                                  2.0, // Move to right 5  horizontally
                                  2.0, // Move to bottom 5 Vertically
                                ),
                              )
                            ],
                            color: Color.fromARGB(255, 185, 246, 213),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "The Best Crop to Harvest for the Upcoming Season is ${croppredd}.",
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black,
                                  ),
                                ),
                                // vSize(5),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [],
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      vSize(100),
                    ],
                  ),
                  Positioned(
                    top: 190,
                    left: w * 0.06,
                    child: Container(
                      height: h * 0.24,
                      width: w * 0.88,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 10.0, // soften the shadow
                            // spreadRadius: 1.0, //extend the shadow
                            offset: Offset(
                              2.0, // Move to right 5  horizontally
                              2.0, // Move to bottom 5 Vertically
                            ),
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            const Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Overview",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.grey700,
                                  ),
                                ),
                                // Icon(
                                //   Icons.arrow_forward_ios_rounded,
                                //   color: AppColors.grey700,
                                // )
                              ],
                            ),
                            vSize(15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: h * 0.14,
                                  width: w * 0.38,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 225, 224, 224),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    // image: DecorationImage(
                                    //     image: AssetImage("assets/images/pizza.png"),
                                    //     fit: BoxFit.fill)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        vSize(5),
                                        const Text(
                                          "No of Crops",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.grey700,
                                          ),
                                        ),
                                        const Text(
                                          "180",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.black,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: SizedBox(
                                            height: h * 0.04,
                                            child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  // selection = !selection;
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              NoofCrops_Page()));
                                                });
                                              },
                                              child: const Text(
                                                "View >",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: AppColors.greenn,
                                                  // fontFamily: "popR",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        vSize(5),
                                      ],
                                    ),
                                  ),
                                ),
                                // hSize(10),
                                Container(
                                  height: h * 0.14,
                                  width: w * 0.38,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 225, 224, 224),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    // image: DecorationImage(
                                    //     image: AssetImage("assets/images/pizza.png"),
                                    //     fit: BoxFit.fill)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        vSize(1),
                                        const Text(
                                          "Personal Land Insights",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.black,
                                          ),
                                        ),
                                        // const Text(
                                        //   "100",
                                        //   style: TextStyle(
                                        //     fontSize: 19,
                                        //     fontWeight: FontWeight.w500,
                                        //     color: AppColors.green,
                                        //   ),
                                        // ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: SizedBox(
                                            height: h * 0.04,
                                            child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  // selection = !selection;
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Personal_LandInsights_Page()));
                                                });
                                              },
                                              child: const Text(
                                                "View >",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: AppColors.greenn,
                                                  // fontFamily: "popR",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        vSize(5),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

// Padding(
//   padding: const EdgeInsets.only(left: 25.0, right: 25.0),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Text(
//         "Weather Forecast",
//         style: TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.w500,
//           color: AppColors.black,
//         ),
//       ),
//       Text(
//         "See All",
//         style: TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.w500,
//           color: AppColors.greenn,
//         ),
//       ),
//     ],
//   ),
// ),

// Container(
//   width: w * 0.845,
//   height: h * 0.115,
//   margin: const EdgeInsets.only(
//       // bottom: 0,
//       left: 12,
//       right: 8),
//   // padding: const EdgeInsets.all(8),
//   decoration: const BoxDecoration(
//     color: Colors.white,
//     borderRadius: BorderRadius.only(
//       bottomLeft: Radius.circular(15),
//       bottomRight: Radius.circular(15),
//     ),
//   ),
//   child: Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               // widget.response.name,
//               "Mid Kitchen",
//               style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: "popR"),
//             ),
//             Container(
//               height: 18,
//               width: w * 0.12,
//               decoration: BoxDecoration(
//                 borderRadius:
//                     const BorderRadius.all(Radius.circular(5)),
//                 color: Colors.green[800],
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "4.3",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(width: 3),
//                   Icon(Icons.star, size: 13, color: Colors.white),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               // widget.response.location,
//               "1512 Sherman Ave, Evanston",
//               style: TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w400,
//                 fontFamily: "popR",
//               ),
//             ),
//             Text(
//               // widget.response.discount.toString(),
//               "8.1 miles",
//               style: TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//                 fontFamily: "popR",
//               ),
//             ),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               // widget.response.cuisines.toString(),
//               "Mediterranean • Salads",
//               style: TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w400,
//                 fontFamily: "popR",
//               ),
//             ),
//             Text(
//               "data",
//               // "\$${widget.response.priceForTwo} for two",
//               style: TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//                 fontFamily: "popR",
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   ),
// ),
