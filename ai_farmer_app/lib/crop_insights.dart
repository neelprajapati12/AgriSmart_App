import 'package:ai_farmer_app/Constants/app_colors.dart';
import 'package:ai_farmer_app/crop_yield_prediction.dart';
import 'package:ai_farmer_app/disease_detection_page.dart';
import 'package:ai_farmer_app/personal_land_insights.dart';
import 'package:ai_farmer_app/utility/card.dart';
import 'package:ai_farmer_app/utility/disease_card.dart';
import 'package:ai_farmer_app/utility/sizedbox_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CropInsights_Page extends StatefulWidget {
  const CropInsights_Page({super.key});

  @override
  State<CropInsights_Page> createState() => _CropInsights_PageState();
}

class _CropInsights_PageState extends State<CropInsights_Page> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crop Insights',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.greenn,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CropYieldPredictionPage()));
                },
                child: HomePageCard()),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DiseaseDetection_Page()));
                },
                child: DiseaseCard()),
          ],
        ),
      ),
    );
  }

  void fetchPrediction() {
    // Function to call API for crop yield prediction
    // Update the predictedYield value based on API response
  }

  void uploadImage() {
    // Function to handle image upload for crop disease detection
  }
}
//         child: Text(
//           "Hi",
//           // 'आपका स्वागत है', // Example Hindi text
//           style: TextStyle(fontSize: 18, color: Colors.black),
//         ),
//       ),