import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_truck_mobile/widget/food_button.dart';
import 'package:food_truck_mobile/widget/section_divider.dart';
import 'package:food_truck_mobile/widget/section_header_tb.dart';
import 'package:food_truck_mobile/widget/text.dart';

/// The [RestaurantMenuScreen], the parameter should be future changes to a
/// Restaurant Model

class RestaurantMenuScreen extends StatelessWidget {
  final String restaurantName;
  final String? restaurantIconUrl;
  final String restaurantDescription;
  final double restaurantRating;
  final List<String>? foodItems;
  final List<String>? sections;

  const RestaurantMenuScreen({
    super.key,
    required this.restaurantName,
    required this.restaurantDescription,
    required this.restaurantRating,
    this.restaurantIconUrl,
    this.foodItems,
    this.sections = const ['Uncategorized'],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: ListView(
          children: [
            Container(
              height: 185,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: AssetImage(
                    'images/DefaultRestaurantImage.jpeg',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            TextTitleLarge(
              text: restaurantName,
              isBold: true,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),

            TextTitleSmall(
              text: restaurantDescription,
              padding: EdgeInsets.zero,
            ),

            const SectionHeaderTB(text: 'Uncategorized'),
            ..._getContent(),
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

  /// TODO: This should be future rebuild based on Section + items
  List<Widget> _getContent() {
    List<Widget> content = [];
    foodItems?.forEach((element) {
      content.add(FoodButton(
          foodName: element,
          description:
              'This is my food, it contains this, that and those and this is a very long string hihihihihihihi',
          price: 0.99));
      content.add(const SectionDivider());
    });

    return content;
  }
}
