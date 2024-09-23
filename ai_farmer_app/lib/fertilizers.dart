import 'dart:convert';

import 'package:ai_farmer_app/Constants/app_colors.dart';
import 'package:ai_farmer_app/infoscreen.dart';
import 'package:ai_farmer_app/utility/sizedbox_util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Fertilizers_Page extends StatefulWidget {
  const Fertilizers_Page({super.key});

  @override
  State<Fertilizers_Page> createState() => _Fertilizers_PageState();
}

class _Fertilizers_PageState extends State<Fertilizers_Page> {
  var responseData;
  var responseimage;

  Future<void> getfert() async {
    print("into the crop func");

    Map<String, dynamic> bodydata = {};
    print(bodydata);
    try {
      var response = await http.post(
        Uri.parse("https://nfc-api-l2z3.onrender.com/fert_predict"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(bodydata),
      );
      if (response.statusCode == 200) {
        responseData = jsonDecode(response.body);
        debugPrint("success");
        print(responseData);
        setState(() {
          getimage(responseData["Fertilizer Name"]);
          //   double predictedYield = responseData["Predicted Crop Yield"];
          //   res = predictedYield.toStringAsFixed(2);
          //   showlogoutdialog(context);
          //   print(res);
        });
      } else {
        debugPrint(
            "Failed to get crop prediction. Status code: ${response.statusCode}");
        debugPrint("Response body: ${response.body}");
      }
    } catch (e) {
      debugPrint("Error making request: $e");
    }
  }

  Future<void> getimage(String name) async {
    print("into the crop func");

    Map<String, dynamic> bodydata = {"name": name};
    print(bodydata);
    try {
      var response = await http.post(
        Uri.parse(
            "https://ecommerce-backend-deploying.vercel.app/api/getFertilizer"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(bodydata),
      );
      if (response.statusCode == 200) {
        responseimage = jsonDecode(response.body);
        debugPrint("success");
        print(responseData);
        setState(() {
          //   double predictedYield = responseData["Predicted Crop Yield"];
          //   res = predictedYield.toStringAsFixed(2);
          //   showlogoutdialog(context);
          //   print(res);
        });
      } else {
        debugPrint("Failed to get image. Status code: ${response.statusCode}");
        debugPrint("Response body: ${response.body}");
      }
    } catch (e) {
      debugPrint("Error making request: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("into the ");
    getfert();
  }

  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fertilizers',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.greenn,
      ),
      body: responseimage == null
          ? Center(
              child: CircularProgressIndicator(
              color: AppColors.greenn,
            ))
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    weatherCard(),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        tabWidget(
                            context,
                            "Soil Moisture",
                            true,
                            "assets/icons/soils.png",
                            "${responseData["Soil Moisture"].toString()} %",
                            "Soil moisture refers to the amount of water contained in the soil. It is a crucial factor in agriculture, plant growth, and environmental management. Here are some key details about soil moisture.Soil moisture affects the availability of water to plants. Adequate moisture ensures proper plant hydration and nutrient uptake."),
                        tabWidget(
                            context,
                            "Nitrogen",
                            false,
                            "assets/icons/nitrogen.png",
                            "${responseData["Nitrogen"].toString()} %",
                            "Nitrogen is a critical nutrient for soil health and plant growth. It is essential for various physiological and biochemical processes in plants. Here are some key details about nitrogen in soil.Nitrogen is a key component of amino acids, the building blocks of proteins. Proteins are essential for plant growth and development."),
                      ],
                    ),
                    vSize(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        tabWidget(
                            context,
                            "Potassium",
                            false,
                            "assets/icons/potassium.png",
                            "${responseData["Potassium"].toString()} %",
                            "Potassium is a vital nutrient for soil health and plant growth. It plays a key role in various physiological and biochemical processes in plants. Here are some key details about potassium in soil.Potassium acts as a cofactor for numerous enzymes involved in photosynthesis, protein synthesis, and starch formation."),
                        tabWidget(
                            context,
                            "Phosphorous",
                            true,
                            "assets/icons/phosphorus.png",
                            "${responseData["Phosphorous"].toString()} %",
                            "Phosphorus is a vital nutrient for soil health and plant growth. It plays a key role in several essential plant processes. Here are some key details about phosphorus in soil.Phosphorus is a crucial component of ATP (adenosine triphosphate), which provides energy for various plant processes, including photosynthesis and nutrient transport."),
                      ],
                    ),
                    vSize(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        tabWidget(
                            context,
                            "Temperature",
                            true,
                            "assets/icons/thermometer.png",
                            "${responseData["Temparature"].toString()} ºC",
                            "Temperature significantly impacts soil fertility by influencing microbial activity, nutrient availability, soil structure, and root growth. Optimal temperatures promote microbial processes, enhance nutrient cycling, and improve root function, leading to better nutrient uptake by plants. However, extreme temperatures can slow microbial activity, alter soil moisture, affect soil pH, and reduce nutrient solubility, all of which can negatively impact soil fertility."),
                        tabWidget(
                            context,
                            "Humidity",
                            false,
                            "assets/icons/humidity.png",
                            "${responseData["Humidity"].toString()} g.m-3",
                            "Humidity affects soil fertility by influencing soil moisture levels, nutrient availability, and microbial activity. High humidity can enhance nutrient solubility and microbial processes but may also lead to waterlogging and nutrient leaching. Conversely, low humidity can reduce soil moisture, impair nutrient uptake, and hinder microbial activity, potentially leading to drought stress and poor plant growth. "),
                      ],
                    ),
                    vSize(100),
                  ],
                ),
              ),
            ),
    );
  }

  Widget tabWidget(BuildContext context, String title, bool isSelected,
      String image, String data, String desc) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InfoScreen(
              title: title,
              image: image,
              data: data,
              description: desc,
              // 'This is detailed information about $title. Potassium is essential for plant growth and is involved in many physiological processes within the plant. It helps in the regulation of water, enzyme activation, and photosynthesis.',
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Container(
          height: h * 0.09,
          width: w * 0.44,
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? Color.fromARGB(255, 185, 246, 213)
                : Color.fromARGB(255, 208, 207, 207),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: h * 0.04,
                      width: w * 0.1,
                      child: Image.asset(image)),
                  SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 17,
                      color: isSelected ? AppColors.greenn : Colors.black,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
              Text(
                data,
                style: TextStyle(
                  fontSize: 18,
                  color: isSelected ? AppColors.greenn : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget weatherCard() {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
              height: h * 0.3,
              width: w * 0.7,
              child: Image.network("${responseimage["fertilizerImage"]}")),
          vSize(10),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Fertilizer Name :",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              hSize(10),
              Text(
                responseData["Fertilizer Name"],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              hSize(10),
              // SizedBox(
              //     height: h * 0.04,
              //     width: w * 0.1,
              //     child: Image.asset("assets/icons/fertilizer.png")),
            ],
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Description -",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            responseData["Description"],
            style: TextStyle(fontSize: 20),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     weatherDetailWidget(Icons.thermostat, "+22°C", "Soil temp"),
          //     weatherDetailWidget(Icons.water_drop, "59%", "Humidity"),
          //     weatherDetailWidget(Icons.air, "6 m/s", "Wind"),
          //     weatherDetailWidget(Icons.opacity, "0 mm", "Precipitation"),
          //   ],
          // ),
          vSize(10),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Soil Type :",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              hSize(10),
              Text(
                responseData["Soil Type"],
                style: TextStyle(fontSize: 20),
              ),
              // SizedBox(
              //     height: h * 0.04,
              //     width: w * 0.1,
              //     child: Image.asset("assets/icons/fertilizer.png")),
            ],
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Crop Type:",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              hSize(10),
              Text(
                responseData["Crop Type"],
                style: TextStyle(fontSize: 20),
              ),
              // SizedBox(
              //     height: h * 0.04,
              //     width: w * 0.1,
              //     child: Image.asset("assets/icons/fertilizer.png")),
            ],
          ),
        ],
      ),
    );
  }

  Widget weatherDetailWidget(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, size: 28),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget soilMoistureCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Soil Moisture",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text("Today", style: TextStyle(color: Colors.grey)),
                  SizedBox(width: 8),
                  Icon(Icons.calendar_today, size: 20, color: Colors.grey),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              moistureLevelWidget("Low", "12 Fields", Colors.red),
              moistureLevelWidget("Optimal", "18 Fields", Colors.green),
              moistureLevelWidget("High", "42 Fields", Colors.blue),
            ],
          ),
        ],
      ),
    );
  }

  Widget moistureLevelWidget(String label, String count, Color color) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 100,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              count,
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(color: color, fontSize: 16),
        ),
      ],
    );
  }
}
