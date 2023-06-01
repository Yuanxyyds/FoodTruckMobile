import 'package:flutter/material.dart';

class RestaurantMenuScreen extends StatelessWidget {
  final String restaurantName;
  final String restaurantIcon;
  final String restaurantDescription;
  final double restaurantRating;
  final List<String> foodItems;

  const RestaurantMenuScreen({
    Key? key,
    required this.restaurantName,
    required this.restaurantIcon,
    required this.restaurantDescription,
    required this.restaurantRating,
    required this.foodItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Image.network(
                    restaurantIcon,
                    width: 48,
                    height: 48,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    restaurantName,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                restaurantDescription,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow),
                  const SizedBox(width: 8),
                  Text(
                    restaurantRating.toStringAsFixed(1),
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: foodItems.length,
              itemBuilder: (context, index) {
                final foodItem = foodItems[index];
                return ListTile(
                  title: Text(foodItem),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Add to cart functionality
                    },
                    child: const Text('Add to Cart'),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  // Complete order functionality
                },
                child: const Text('Complete Order'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
