import 'package:flutter/material.dart';
import 'package:food_truck_mobile/screen/shopping_cart_screen.dart';
import 'package:food_truck_mobile/widget/components/checkout_row.dart';
import 'package:food_truck_mobile/widget/components/food_button.dart';

import '../helper/constants.dart';
import '../models/food_model.dart';
import '../widget/components/button.dart';
import '../widget/dividers/section_divider.dart';
import '../widget/dividers/section_header_tb.dart';
import '../widget/text.dart';

class CheckoutScreen extends StatelessWidget {
  final String restaurantName;
  final FoodModel food = FoodModel(
    id: '1',
    name: 'Pizza',
    description: 'Delicious pizza with toppings',
    price: 10.99,
    foodUrl: 'images/DefaultRestaurantImage.jpeg',
    topping: {
      'Cheese': 1.0,
      'Pepperoni': 1.5,
      'Mushrooms': 0.5,
    },
    sectionId: 'main-dishes',
  );

  CheckoutScreen({Key? key, required this.restaurantName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: ListView(
          children: [
            Image.asset('images/CheckoutDecoration.jpg'),
            const TextTitleLarge(
              text: "Checkout",
              isBold: true,
            ),
            TextTitleMedium(text: restaurantName),
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
            FoodButton(foodModel: food),
            const SectionDivider(),
            const Row(
              children: [
                Icon(Icons.add),
                TextTitleMedium(text: "Add more items"),
              ],
            ),
            const SectionHeaderTB(text: "Payment Details"),
            const CheckoutRow(
                icon: Icons.wallet,
                primaryLine: "Choose a payment method",
                secondaryLine: "Credit card ending ****"),
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
}
