import 'package:flutter/material.dart';
import 'package:food_truck_mobile/screen/restaurant_menu_screen.dart';
import 'package:food_truck_mobile/widget/home_restaurant.dart';
import 'package:food_truck_mobile/widget/section_header_in_between.dart';
import '../widget/bottom_navigation.dart';
import '../widget/text.dart';

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
            const SectionHeaderInBetween(text: 'New on Food Truck'),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    HomeRestaurant(
                      restaurantName: 'Restaurant 1',
                      label: 'Chinese food',
                      deliveryPrice: -1,
                      priceCategory: 2,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    HomeRestaurant(
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
            const SectionHeaderInBetween(text: 'Popular Food Truck'),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    HomeRestaurant(
                      restaurantName: 'Restaurant 1',
                      label: 'Chinese food',
                      deliveryPrice: -1,
                      priceCategory: 2,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    HomeRestaurant(
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
            const SectionHeaderInBetween(text: 'Besides Food Truck'),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    HomeRestaurant(
                      restaurantName: 'Restaurant 1',
                      label: 'Chinese food',
                      deliveryPrice: 0,
                      priceCategory: 3,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    HomeRestaurant(
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
