import 'package:flutter/material.dart';
import 'package:food_truck_mobile/widget/button.dart';
import 'package:food_truck_mobile/widget/cart_item.dart';
import 'package:food_truck_mobile/widget/checkout_item.dart';
import 'package:food_truck_mobile/widget/section_divider.dart';
import 'package:food_truck_mobile/widget/text.dart';

import '../helper/constants.dart';

class ShoppingCart extends StatelessWidget {
  final List<List> cartItems;

  // cartItems should be passed in, this is only for UI purposes
  const ShoppingCart(
      {Key? key,
      this.cartItems = const [
        ["Artichoke Sandwich", 7.50, 2],
        ["Egg Sandwich", 5.70, 1]
      ]})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Shopping cart"),
        ),
        body: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
            child: ListView(
              children: [
                const TextTitleLarge(
                  text: "Shopping cart",
                  isBold: true,
                ),
                const SectionDivider(),
                ..._getContent(),
                const CheckoutItem(name: "Subtotal", price: 7.50),
                const CheckoutItem(name: "Delivery costs", price: 3.26),
                const CheckoutItem(
                  name: "Total",
                  price: 10.26,
                  isBold: true,
                ),
                const SizedBox(
                  height: 90.0,
                )
              ],
            )),
        bottomSheet: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
          child: SizedBox(
            height: 60.0,
            child: Row(
              children: [
                Expanded(
                    child: Button(
                  text: "Checkout",
                  textColor: Colors.white,
                  backgroundColor: Constants.primaryColor,
                  takeLeastSpace: true,
                  onPressed: () {},
                ))
              ],
            ),
          ),
        ));
  }

  List<Widget> _getContent() {
    List<Widget> content = [];
    for (var element in cartItems) {
      content.add(CartItem(
        itemName: element[0],
        itemPrice: element[1],
        count: element[2],
      ));
    }

    return content;
  }
}
