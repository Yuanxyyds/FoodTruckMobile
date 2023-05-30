import 'package:flutter/material.dart';
import 'package:food_truck_mobile/screen/restaurant_menu_screen.dart';

import '../widget/bottom_navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Online Ordering App'),
      ),
      bottomNavigationBar: const BottomNavigation(
        currentIndex: 0,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for restaurants...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://pbs.twimg.com/profile_images/1544722618275827713/9-aMN_Wb_400x400.jpg'),
            ),
            title: const Text('Restaurant 1'),
            subtitle: const Text('Cuisine Type'),
            trailing: const Icon(Icons.star),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
              const RestaurantMenuScreen(restaurantName: 'restaurantName',
                  restaurantIcon: 'https://pbs.twimg.com/profile_images/1544722618275827713/9-aMN_Wb_400x400.jpg',
                  restaurantDescription: 'restaurantDescription',
                  restaurantRating: 5.0,
                  foodItems: ['FoodA', 'FoodB', 'FoodC'])));
            },
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://pbs.twimg.com/profile_images/1544722618275827713/9-aMN_Wb_400x400.jpg'),
            ),
            title: const Text('Restaurant 2'),
            subtitle: const Text('Cuisine Type'),
            trailing: const Icon(Icons.star),
            onTap: () {
              // Handle restaurant selection
            },
          ),
          // Add more restaurant listings as needed
        ],
      ),
    );
  }
}
