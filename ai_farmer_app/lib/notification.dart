import 'package:ai_farmer_app/Constants/app_colors.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.greenn,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: const Icon(Icons.notifications, color: AppColors.greenn),
            title: const Text(
              'New Crop Update',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Your crop yield prediction has been updated.',
            ),
            trailing: const Text(
              '2h ago',
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () {
              // Navigate to details or handle the tap
            },
          ),
          const Divider(thickness: 0.5, color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.warning, color: Colors.redAccent),
            title: const Text(
              'Weather Alert',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Heavy rainfall expected tomorrow. Take necessary precautions.',
            ),
            trailing: const Text(
              '5h ago',
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () {
              // Navigate to details or handle the tap
            },
          ),
          const Divider(thickness: 0.5, color: Colors.grey),
          // Add more ListTiles as needed
        ],
      ),
    );
  }
}
