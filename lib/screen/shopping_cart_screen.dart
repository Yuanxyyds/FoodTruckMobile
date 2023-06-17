import 'package:flutter/material.dart';
import 'package:food_truck_mobile/models/order_item_model.dart';
import 'package:food_truck_mobile/models/restaurant_model.dart';
import 'package:food_truck_mobile/providers/shopping_cart_provider.dart';
import 'package:food_truck_mobile/screen/restaurant_menu_screen.dart';
import 'package:food_truck_mobile/widget/components/button.dart';
import 'package:food_truck_mobile/widget/components/cart_item.dart';
import 'package:food_truck_mobile/widget/components/name_price_row.dart';
import 'package:food_truck_mobile/widget/dividers/section_divider.dart';
import 'package:food_truck_mobile/widget/text.dart';
import 'package:provider/provider.dart';

import '../helper/constants.dart';
import 'checkout_screen.dart';

/// TODO: Add OrderItem Model in the future
class ShoppingCart extends StatelessWidget {
  final RestaurantModel restaurantModel;

  const ShoppingCart({super.key, required this.restaurantModel});

  @override
  Widget build(BuildContext context) {
    ShoppingCartProvider shoppingCartProvider =
        context.watch<ShoppingCartProvider>();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Shopping cart"),
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
                    onPressed: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  CheckoutScreen(
                            restaurantModel: restaurantModel,
                          ),
                          transitionDuration: Duration.zero,
                        ),
                      );
                    },
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
