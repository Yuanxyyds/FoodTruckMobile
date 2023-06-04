import 'package:flutter/material.dart';
import 'package:food_truck_mobile/widget/home_restaurant_button.dart';
import 'package:food_truck_mobile/widget/section_header_tb.dart';
import '../widget/bottom_navigation.dart';
import '../widget/text.dart';

/// The [HomeScreen] of the app

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextHeadlineSmall(
          text: 'Home',
        ),
      ),
      bottomNavigationBar: const BottomNavigation(
        currentIndex: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 15,
        ),
        child: ListView(
          children: [
            Image.asset('images/HomeDecoration.png'),
            const SizedBox(
              height: 16,
            ),
            // Section 1
            const SectionHeaderTB(text: 'New on Food Truck'),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    HomeRestaurantButton(
                      restaurantName: 'Restaurant 1',
                      label: 'Chinese food',
                      deliveryPrice: -1,
                      priceCategory: 2,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    HomeRestaurantButton(
                      restaurantName: 'Restaurant 2',
                      label: 'Korean food, Sandwich',
                      deliveryPrice: 1.99,
                      priceCategory: 2,
                    )
                  ],
                ),
              ),
            ),
            // Section 2
            const SectionHeaderTB(text: 'Popular Food Truck'),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    HomeRestaurantButton(
                      restaurantName: 'Restaurant 1',
                      label: 'Chinese food',
                      deliveryPrice: -1,
                      priceCategory: 2,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    HomeRestaurantButton(
                      restaurantName: 'Restaurant 2',
                      label: 'Korean food, Sandwich',
                      deliveryPrice: 1.99,
                      priceCategory: 2,
                    )
                  ],
                ),
              ),
            ),
            // Section 3
            const SectionHeaderTB(text: 'Besides Food Truck'),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    HomeRestaurantButton(
                      restaurantName: 'Restaurant 1',
                      label: 'Chinese food',
                      deliveryPrice: 0,
                      priceCategory: 3,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    HomeRestaurantButton(
                      restaurantName: 'Restaurant 2',
                      label: 'Korean food, Sandwich',
                      deliveryPrice: 0.99,
                      priceCategory: 2,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
