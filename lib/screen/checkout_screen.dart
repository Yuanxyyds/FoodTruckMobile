import 'package:flutter/material.dart';
import 'package:food_truck_mobile/screen/restaurant_menu_screen.dart';
import 'package:food_truck_mobile/screen/shopping_cart_screen.dart';
import 'package:food_truck_mobile/widget/components/checkout_row.dart';
import 'package:food_truck_mobile/widget/components/food_button.dart';
import 'package:provider/provider.dart';

import '../helper/constants.dart';
import '../models/food_model.dart';
import '../models/order_item_model.dart';
import '../models/restaurant_model.dart';
import '../providers/firebase/food_manager.dart';
import '../providers/shopping_cart_provider.dart';
import '../widget/components/button.dart';
import '../widget/dividers/section_divider.dart';
import '../widget/dividers/section_header_tb.dart';
import '../widget/text.dart';

class CheckoutScreen extends StatelessWidget {
  final RestaurantModel restaurantModel;

  const CheckoutScreen({Key? key, required this.restaurantModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShoppingCartProvider shoppingCartProvider =
        context.watch<ShoppingCartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    RestaurantMenuScreen(
                  restaurantModel: restaurantModel,
                ),
                transitionDuration: Duration.zero,
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: FutureBuilder<List<Widget>>(
          future: _getContent(shoppingCartProvider),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView(
                children: [
                  Image.asset('images/CheckoutDecoration.jpg'),
                  const TextTitleLarge(
                    text: "Checkout",
                    isBold: true,
                  ),
                  TextTitleMedium(text: restaurantModel.name),
                  const SectionHeaderTB(text: "Delivery method and time"),
                  const CheckoutRow(
                      icon: Icons.delivery_dining,
                      primaryLine: "Delivery in 35 min to Home",
                      secondaryLine: "Your home address here"),
                  const SectionDivider(),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextTitleMedium(
                              text: "No contact delivery",
                              isBold: true,
                            ),
                            TextTitleMedium(
                                text: "Leave the order in front of my door")
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                  const SectionHeaderTB(text: "Selected Items"),
                  ...snapshot.data!,
                  const SectionDivider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  RestaurantMenuScreen(
                                      restaurantModel: restaurantModel),
                          transitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.add),
                        TextTitleMedium(text: "Add more items"),
                      ],
                    ),
                  ),
                  const SectionHeaderTB(text: "Payment Details"),
                  const CheckoutRow(
                    icon: Icons.wallet,
                    primaryLine: "Choose a payment method",
                    secondaryLine: "Credit card ending ****",
                  ),
                  const SectionDivider(),
                  const CheckoutRow(
                      icon: Icons.attach_money,
                      primaryLine: "Tip the courier",
                      secondaryLine: "Optional tip for the courier"),
                  const SectionDivider(),
                  const SizedBox(
                    height: 90.0,
                  )
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
                          ShoppingCart(
                        restaurantModel: restaurantModel,
                      ),
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
                height: 45.0,
                child: Button(
                  text: "Pay \$10.99",
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

  Future<List<Widget>> _getContent(
      ShoppingCartProvider shoppingCartProvider) async {
    List<Widget> content = [];
    FoodManager foodManager = FoodManager();

    List<OrderItemModel> cartItems = shoppingCartProvider.orderItems;
    List<FoodModel>? foods = await foodManager
        .getFoodByRestaurant(shoppingCartProvider.restaurantId);

    List<FoodModel> selectedFood = foods!
        .where((item) => cartItems.any((element) => element.foodId == item.id))
        .toList();

    for (var foodModel in selectedFood) {
      content.add(FoodButton(foodModel: foodModel));
    }
    return content;
  }
}
