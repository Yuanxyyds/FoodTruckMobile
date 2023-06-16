import 'package:flutter/material.dart';
import 'package:food_truck_mobile/providers/firebase/restaurant_manager.dart';
import 'package:food_truck_mobile/models/restaurant_model.dart';
import 'package:food_truck_mobile/widget/components/home_restaurant_button.dart';
import 'package:food_truck_mobile/widget/dividers/section_header_tb.dart';
import 'package:food_truck_mobile/widget/components/bottom_navigation.dart';
import 'package:food_truck_mobile/widget/text.dart';

/// The [HomeScreen] of the app
/// TODO: Get Restaurant from FireStore

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RestaurantManager restaurantManager = RestaurantManager();
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
            const SectionHeaderTB(text: 'Currently Open Food Truck'),
            SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: FutureBuilder<List<RestaurantModel>?>(
                  future: restaurantManager.getOpenRestaurant(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data!.isEmpty) {
                        return const Center(child: TextHeadlineMedium(
                            text: 'No Item!'));
                      }
                      List<Widget> content = [];
                      for (var restaurantModel in snapshot.data!) {
                        content.add(HomeRestaurantButton(
                          restaurantModel: restaurantModel,));
                        content.add(const SizedBox(
                          width: 20,
                        ));
                      }
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        children: content,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  },
                ),
              ),
            ),
            // Section 2
            const SectionHeaderTB(text: 'All Food Truck'),
            SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: FutureBuilder<List<RestaurantModel>?>(
                  future: restaurantManager.getAllRestaurant(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data!.isEmpty) {
                        return const Center(child: TextHeadlineMedium(
                            text: 'No Item!'));
                      }
                      List<Widget> content = [];
                      for (var restaurantModel in snapshot.data!) {
                        content.add(HomeRestaurantButton(
                          restaurantModel: restaurantModel,));
                        content.add(const SizedBox(
                          width: 20,
                        ));
                      }
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        children: content,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  },
                ),
              ),
            ),
            // Section 3
            const SectionHeaderTB(text: 'Still All FoodTruck for now :)'),
            SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: FutureBuilder<List<RestaurantModel>?>(
                  future: restaurantManager.getAllRestaurant(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data!.isEmpty) {
                        return const Center(child: TextHeadlineMedium(
                            text: 'No Item!'));
                      }
                      List<Widget> content = [];
                      for (var restaurantModel in snapshot.data!) {
                        content.add(HomeRestaurantButton(
                          restaurantModel: restaurantModel,));
                        content.add(const SizedBox(
                          width: 20,
                        ));
                      }
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        children: content,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
