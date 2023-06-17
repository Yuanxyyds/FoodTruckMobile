import 'package:flutter/material.dart';
import 'package:food_truck_mobile/models/order_item_model.dart';
import 'package:food_truck_mobile/providers/shoping_cart_provider.dart';
import 'package:food_truck_mobile/widget/components/button.dart';
import 'package:food_truck_mobile/widget/components/cart_item.dart';
import 'package:food_truck_mobile/widget/components/name_price_row.dart';
import 'package:food_truck_mobile/widget/dividers/section_divider.dart';
import 'package:food_truck_mobile/widget/text.dart';
import 'package:provider/provider.dart';

import '../helper/constants.dart';

/// TODO: Add OrderItem Model in the future
class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    ShoppingCartProvider shoppingCartProvider =
        context.watch<ShoppingCartProvider>();
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
                ..._getContent(shoppingCartProvider),
                NamePriceRow(
                    name: "Subtotal",
                    price: shoppingCartProvider.getTotalCost()),
                const NamePriceRow(name: "Delivery costs", price: 0.00),
                NamePriceRow(
                  name: "Total",
                  price: shoppingCartProvider.getTotalCost(),
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
                    child: SizedBox(
                  height: 45.0,
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
        ));
  }

  List<Widget> _getContent(ShoppingCartProvider shoppingCartProvider) {
    List<Widget> content = [];
    List<OrderItemModel> cartItems = shoppingCartProvider.orderItems;
    for (var orderItem in cartItems) {
      content.add(CartItem(
        shoppingCartProvider: shoppingCartProvider,
        orderItemModel: orderItem,
      ));
    }

    return content;
  }
}
