import 'package:flutter/material.dart';
import 'package:food_truck_mobile/models/order_item_model.dart';
import 'package:food_truck_mobile/providers/shoping_cart_provider.dart';
import 'package:food_truck_mobile/widget/dividers/section_divider.dart';
import 'package:food_truck_mobile/widget/text.dart';

class CartItem extends StatelessWidget {
  final OrderItemModel orderItemModel;
  final ShoppingCartProvider shoppingCartProvider;

  const CartItem({
    Key? key,
    required this.orderItemModel,
    required this.shoppingCartProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color removeColor =
        orderItemModel.quantity == 1 ? Colors.grey : Colors.black;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: TextTitleMedium(
              text: orderItemModel.foodName,
              isBold: true,
            )),
            TextTitleMedium(
              text:
                  '\$ ${(orderItemModel.singleItemPrice * orderItemModel.quantity).toStringAsFixed(2)}',
              padding: EdgeInsets.zero,
            ),
          ],
        ),
        const SizedBox(
          height: 20.0,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Expanded(child: TextTitleMedium(text: "Quantity")),
            Container(
              height: 50.0,
              width: 120.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      shoppingCartProvider.removeOrderItem(orderItemModel);
                      orderItemModel.quantity = orderItemModel.quantity > 1
                          ? orderItemModel.quantity - 1
                          : 1;
                      shoppingCartProvider.addOrderItem(orderItemModel);
                    },
                    icon: Icon(
                      Icons.remove,
                      color: removeColor,
                    ),
                  ),
                  Text(
                    orderItemModel.quantity.toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () {
                      shoppingCartProvider.removeOrderItem(orderItemModel);
                      orderItemModel.quantity = orderItemModel.quantity + 1;
                      shoppingCartProvider.addOrderItem(orderItemModel);
                    },
                    icon: const Icon(
                      Icons.add,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const SectionDivider()
      ],
    );
  }
}
