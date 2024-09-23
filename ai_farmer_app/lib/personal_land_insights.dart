import 'package:ai_farmer_app/Constants/app_colors.dart';
import 'package:ai_farmer_app/utility/sizedbox_util.dart';
import 'package:flutter/material.dart';

class Personal_LandInsights_Page extends StatefulWidget {
  const Personal_LandInsights_Page({super.key});

  @override
  State<Personal_LandInsights_Page> createState() =>
      _Personal_LandInsights_PageState();
}

class _Personal_LandInsights_PageState
    extends State<Personal_LandInsights_Page> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.greenn,
        title: Text(
          "Personal Land",
          style: TextStyle(
            // fontSize: 16,
            color: AppColors.white,
            fontWeight: FontWeight.w600,
            // fontFamily: "popR",
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            vSize(10),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                'assets/images/landimage.jpg',
                height: h * 0.3,
                width: w * 0.87,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                detailWidget(Icons.landscape, '20.5 ac', 'Area'),
                detailWidget(Icons.grass, '97/100', 'Soil Score'),
                detailWidget(Icons.security, 'Ok', 'Security'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget detailWidget(IconData icon, String value, String label) {
  return Column(
    children: [
      Icon(icon, size: 28),
      SizedBox(height: 8),
      Text(
        value,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      SizedBox(height: 4),
      Text(
        label,
        style: TextStyle(
          color: AppColors.grey700,
        ),
      ),
    ],
  );
}
