import 'package:ai_farmer_app/Constants/app_colors.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  final String title;
  final String image;
  final String data;
  final String description;

  InfoScreen({
    required this.title,
    required this.image,
    required this.data,
    required this.description,
  });

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
        title: Text(
          title,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                image,
                height: h * 0.2,
                width: w * 0.4,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.greenn,
              ),
            ),
            SizedBox(height: 10),
            // Text(
            //   "Data: $data",
            //   style: TextStyle(
            //     fontSize: 22,
            //     fontWeight: FontWeight.w600,
            //     color: Colors.black87,
            //   ),
            // ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
