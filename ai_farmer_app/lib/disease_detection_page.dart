import 'dart:convert';
import 'dart:io';
import 'package:ai_farmer_app/Constants/app_colors.dart';
import 'package:ai_farmer_app/utility/sizedbox_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class DiseaseDetection_Page extends StatefulWidget {
  const DiseaseDetection_Page({super.key});

  @override
  State<DiseaseDetection_Page> createState() => _DiseaseDetection_PageState();
}

class _DiseaseDetection_PageState extends State<DiseaseDetection_Page> {
  File? _selectedImage; // To hold the selected image
  var _predictedDisease; // To display the predicted disease result
  bool _isLoading = false; // To show loading indicator during API call

  // Function to pick an image from the device
  Future<void> _pickImage() async {
    print("entered image picker");
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery); // Use ImageSource.camera for camera

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _predictedDisease = null; // Reset prediction on new image selection
      });

      // Call the API after picking the image
      await _predictDisease();
    }
  }

  // Function to send image to API and get the predicted disease
  Future<void> _predictDisease() async {
    if (_selectedImage == null) return;

    setState(() {
      _isLoading = true; // Show loading indicator
    });

    try {
      // Prepare the image file for upload
      print("entered func");
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://nfc2-w3ri.onrender.com/api/disease'), // Replace with your API endpoint
      );

      request.files.add(
          await http.MultipartFile.fromPath('image', _selectedImage!.path));
      print(_selectedImage!.path);
      // Send the request to the server
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        var result = jsonDecode(responseData.body);
        print("////${result}");
        setState(() {
          _predictedDisease = result['result'] ?? 'No disease detected';
        });
      } else {
        setState(() {
          _predictedDisease = 'Failed to get prediction. Please try again.';
        });
      }
    } catch (e) {
      setState(() {
        _predictedDisease = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

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
          'Disease Prediction',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.greenn,
      ),
      body: Center(
        child: Container(
          height: h * 0.66,
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _selectedImage != null
                        ? SizedBox(
                            height: h * 0.2,
                            width: w * 0.5,
                            child: Image.file(
                              _selectedImage!,
                              width: w * 0.8,
                              height: h * 0.4,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Text('No Image Selected'),
                    vSize(20),
                    SizedBox(
                      height: h * 0.07,
                      width: w * 0.3,
                      child: ElevatedButton(
                        onPressed: () {
                          _pickImage();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: AppColors.green,
                          foregroundColor: AppColors.white,
                          shadowColor: Colors.grey.withOpacity(0.5),
                        ),
                        child: const Text('Pick Image'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _isLoading
                        ? const CircularProgressIndicator() // Show loading indicator
                        : Text(
                            _predictedDisease ??
                                'Disease Prediction Will Appear Here',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
