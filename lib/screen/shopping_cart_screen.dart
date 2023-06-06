import 'package:flutter/material.dart';
import 'package:food_truck_mobile/widget/cart_item.dart';
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
                const Row(
                  children: [
                    Expanded(
                        child: TextTitleMedium(
                      text: "Subtotal",
                    )),
                    TextTitleMedium(
                      text: '\$ 7.50',
                      padding: EdgeInsets.zero,
                    )
                  ],
                ),
                const Row(
                  children: [
                    Expanded(
                        child: TextTitleMedium(
                      text: "Delivery costs",
                    )),
                    TextTitleMedium(
                      text: '\$ 3.26',
                      padding: EdgeInsets.zero,
                    )
                  ],
                ),
                const Row(
                  children: [
                    Expanded(
                        child: TextTitleMedium(
                      text: "Total",
                      isBold: true,
                    )),
                    TextTitleMedium(
                      text: '\$ 10.26',
                      padding: EdgeInsets.zero,
                      isBold: true,
                    )
                  ],
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
                  child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Constants.primaryColor),
                      child: const Center(
                        child: TextTitleMedium(
                          text: "Checkout",
                          color: Colors.white,
                        ),
                      )),
                )
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
