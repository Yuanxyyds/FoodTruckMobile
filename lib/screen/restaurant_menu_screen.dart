import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_truck_mobile/providers/firebase/food_manager.dart';
import 'package:food_truck_mobile/providers/firebase/section_manager.dart';
import 'package:food_truck_mobile/models/food_model.dart';
import 'package:food_truck_mobile/models/restaurant_model.dart';
import 'package:food_truck_mobile/models/section_model.dart';
import 'package:food_truck_mobile/providers/shoping_cart_provider.dart';
import 'package:food_truck_mobile/screen/shopping_cart_screen.dart';
import 'package:food_truck_mobile/widget/components/food_button.dart';
import 'package:food_truck_mobile/widget/dividers/section_header_tb.dart';
import 'package:food_truck_mobile/widget/text.dart';

import 'package:food_truck_mobile/helper/constants.dart';
import 'package:food_truck_mobile/widget/components/button.dart';
import 'package:provider/provider.dart';

/// The [RestaurantMenuScreen], the parameter should be future changes to a
/// Restaurant Model

class RestaurantMenuScreen extends StatelessWidget {
  final RestaurantModel restaurantModel;

  const RestaurantMenuScreen({
    super.key,
    required this.restaurantModel,
  });

  @override
  Widget build(BuildContext context) {
    ShoppingCartProvider shoppingCartProvider =
        context.read<ShoppingCartProvider>();
    if (shoppingCartProvider.restaurantId.isNotEmpty) {
      if (shoppingCartProvider.restaurantId != restaurantModel.id) {
        shoppingCartProvider.clearOrderItems();
        shoppingCartProvider.restaurantId = restaurantModel.id!;
      }
    } else {
      shoppingCartProvider.restaurantId = restaurantModel.id!;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: FutureBuilder<List<Widget>>(
          future: _getContent(restaurantModel.id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView(
                children: [
                  Container(
                    height: 185,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(
                          restaurantModel.restaurantUrl,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  TextTitleLarge(
                    text: restaurantModel.name,
                    isBold: true,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  TextTitleSmall(
                    text: restaurantModel.description!,
                    padding: EdgeInsets.zero,
                  ),
                  ...snapshot.data!,
                  const SizedBox(height: 90.0),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
        child: SizedBox(
          height: 60.0,
          child: Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const ShoppingCart(),
                      transitionDuration: Duration.zero,
                    ),
                  );
                },
                child: Container(
                    height: 45.0,
                    decoration: BoxDecoration(
                        border: Border.all(color: Constants.primaryColor),
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.transparent),
                    child: const Center(
                      child: TextTitleMedium(
                        text: "Shopping cart",
                        color: Constants.primaryColor,
                      ),
                    )),
              )),
              const SizedBox(
                width: 15.0,
              ),
              Expanded(
                  child: SizedBox(
                height: 45,
                child: Button(
                  text: "Checkout",
                  textColor: Colors.white,
                  backgroundColor: Constants.primaryColor,
                  takeLeastSpace: true,
                  onPressed: () {},
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  /// Get Section and Food Instances
  Future<List<Widget>> _getContent(String restaurantId) async {
    FoodManager foodManager = FoodManager();
    SectionManager sectionManager = SectionManager();
    List<Widget> content = [];
    List<SectionModel>? section =
        await sectionManager.getOwnedSection(restaurantId);
    List<FoodModel>? foods =
        await foodManager.getFoodByRestaurant(restaurantId);
    for (var sectionModel in section!) {
      content.add(SectionHeaderTB(
        text: sectionModel.name,
      ));
      for (var foodModel in foods!) {
        if (foodModel.sectionId == sectionModel.id) {
          content.add(FoodButton(
            foodModel: foodModel,
          ));
        }
      }
    }

    return content;
  }
}
