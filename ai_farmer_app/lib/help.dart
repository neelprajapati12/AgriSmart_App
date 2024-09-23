import 'package:ai_farmer_app/Constants/app_colors.dart';
import 'package:ai_farmer_app/utility/sizedbox_util.dart';
import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help & Support',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.greenn,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Introduction and Overview
              Text(
                'Introduction & Overview',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(height: 10),
              Text(
                'This app helps you with crop yield prediction, crop disease detection, crop prediction',
              ),
              Divider(
                color: AppColors.grey,
                thickness: 0.6,
              ),
              vSize(20),
              Text(
                'Feature Descriptions',
                style: Theme.of(context).textTheme.headline6,
              ),
              ExpansionTile(
                title: Text('Crop Yield Prediction'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Enter details like area size, district, crop type, and season to predict the crop yield.',
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text('Crop Disease Detection'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Upload an image of your crop to detect potential diseases.',
                    ),
                  ),
                ],
              ),
              Divider(
                color: AppColors.grey,
                thickness: 0.6,
              ),
              // Add more features similarly...
              vSize(20),
              // FAQs
              Text(
                'Frequently Asked Questions',
                style: Theme.of(context).textTheme.headline6,
              ),
              ExpansionTile(
                title: Text('How do I upload an image?'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Go to the Crop Disease Detection section and click on the upload button to select an image.',
                    ),
                  ),
                ],
              ),
              // Add more FAQs similarly...
              Divider(
                color: AppColors.grey,
                thickness: 0.6,
              ),
              vSize(20),
              // Troubleshooting Guide
              Text(
                'Troubleshooting Guide',
                style: Theme.of(context).textTheme.headline6,
              ),
              ListTile(
                title: Text('500 Internal Server Error'),
                subtitle: Text(
                    'Try restarting the app or checking your internet connection.'),
                onTap: () {
                  // Navigate to detailed troubleshooting page
                },
              ),
              // Add more troubleshooting items...
              Divider(
                color: AppColors.grey,
                thickness: 0.6,
              ),
              vSize(20),
              // Contact Support
              Text(
                'Contact Support',
                style: Theme.of(context).textTheme.headline6,
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.email),
                  title: Text('Email Support'),
                  subtitle: Text('support@agrismart.com'),
                ),
              ),
              // Add more contact options...
              Divider(
                color: AppColors.grey,
                thickness: 0.6,
              ),
              SizedBox(height: 20),

              // Tutorial Videos
              Text(
                'Tutorial Videos',
                style: Theme.of(context).textTheme.headline6,
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.play_circle_fill),
                  title: Text('Watch the video tutorial'),
                  onTap: () {
                    // Open the video player
                  },
                ),
              ),
              Divider(
                color: AppColors.grey,
                thickness: 0.6,
              ),
              SizedBox(height: 20),

              // Permissions and Data Privacy
              Text(
                'App Permissions & Data Privacy',
                style: Theme.of(context).textTheme.headline6,
              ),
              ListTile(
                // selectedColor: Colors.amber,
                title: Text('Camera Access'),
                subtitle: Text('Needed for uploading crop images.'),
              ),
              // Add more permissions...
              Divider(
                color: AppColors.grey,
                thickness: 0.6,
              ),
              // SizedBox(height: 20),

              // // Glossary
              // Text(
              //   'Glossary of Terms',
              //   style: Theme.of(context).textTheme.headline6,
              // ),
              // ListTile(
              //   title: Text('Kharif'),
              //   subtitle: Text('A type of crop grown in the rainy season.'),
              // ),
              // Add more terms...
              // Divider(
              //   color: AppColors.grey,
              //   thickness: 0.6,
              // ),
              SizedBox(height: 20),

              // Update Information
              Text(
                'Latest Updates',
                style: Theme.of(context).textTheme.headline6,
              ),
              Card(
                child: ListTile(
                  title: Text('Version 1.2.0'),
                  subtitle: Text('New features added: Disease Detection'),
                ),
              ),
              // Divider(
              //   color: AppColors.grey,
              //   thickness: 0.6,
              // ),
              // SizedBox(height: 20),

              // Feedback and Suggestions
              // Text(
              //   'Feedback & Suggestions',
              //   style: Theme.of(context).textTheme.headline6,
              // ),
              // Card(
              //   child: ListTile(
              //     leading: Icon(Icons.feedback),
              //     title: Text('Submit your feedback'),
              //     onTap: () {
              //       // Open feedback form
              //     },
              //   ),
              // ),
              vSize(100),
            ],
          ),
        ),
      ),
    );
  }
}
