import 'package:flutter/material.dart';
import 'package:food_truck_mobile/widget/bottom_navigation.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Information'),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 3,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                'https://example.com/user-profile-picture.jpg', // Replace with the user's profile picture URL
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'John Doe', // Replace with the user's name
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'john.doe@example.com', // Replace with the user's email
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16.0),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('123-456-7890'), // Replace with the user's phone number
              onTap: () {
                // Handle phone number tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('New York, USA'), // Replace with the user's location
              onTap: () {
                // Handle location tap
              },
            ),
            // Add more user information as needed
          ],
        ),
      ),
    );
  }
}
