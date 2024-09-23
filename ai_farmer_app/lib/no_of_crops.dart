import 'package:ai_farmer_app/Constants/app_colors.dart';
import 'package:ai_farmer_app/utility/sizedbox_util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NoofCrops_Page extends StatefulWidget {
  const NoofCrops_Page({super.key});

  @override
  State<NoofCrops_Page> createState() => _NoofCrops_PageState();
}

class _NoofCrops_PageState extends State<NoofCrops_Page> {
  final List<Map<String, dynamic>> crops = [
    {
      "name": "Wheat",
      "image": "assets/images/wheat.jpg",
      "id": 1,
      "quantity": "70"
    },
    {
      "name": "Rice",
      "image": "assets/images/rice.jpg",
      "id": 2,
      "quantity": "50"
    },
    {
      "name": "Corn",
      "image": "assets/images/corn.jpg",
      "id": 3,
      "quantity": "30"
    },
    {
      "name": "Banana",
      "image": "assets/images/banana.jpeg",
      "id": 3,
      "quantity": "30"
    },
    {
      "name": "Sugarcane",
      "image": "assets/images/sugarcane.jpg",
      "id": 3,
      "quantity": "0"
    },
    // Add more crops as needed
  ];

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

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
          'No of Crops',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.greenn,
      ),
      body: crops.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: crops.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return CropCard(
                          cropName: crops[index]['name'],
                          imagePath: crops[index]['image'],
                          quantity: crops[index]['quantity'],
                          onTap: () {
                            // Implement navigation or action for each crop
                          },
                        );
                      },
                    ),
                  ),
                  // const SizedBox(height: 20),/
                  // ElevatedButton(
                  //   onPressed: () {
                  //     // Action for adding new crops or any other functionality
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.greenAccent,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(30),
                  //     ),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //         vertical: 15.0, horizontal: 30.0),
                  //     child: Text(
                  //       "Add New Crop",
                  //       style: TextStyle(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.white),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
    );
  }
}

class CropCard extends StatelessWidget {
  final String cropName;
  final String imagePath;
  final VoidCallback onTap;
  final String? quantity;

  const CropCard({
    required this.cropName,
    required this.imagePath,
    required this.onTap,
    this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Color.fromARGB(255, 231, 231, 231),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: h * 0.13,
              width: w * 0.38,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(
                    image: AssetImage(imagePath), fit: BoxFit.fill),
              ),
              // child: Image.asset(
              //   imagePath,
              //   fit: BoxFit.fill,
              // ),
            ),
            vSize(10),
            Text(
              "$cropName - $quantity",
              style: TextStyle(
                fontFamily: "popR",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
