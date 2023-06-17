import 'package:flutter/material.dart';
import 'package:food_truck_mobile/models/food_model.dart';
import 'package:food_truck_mobile/models/order_item_model.dart';
import 'package:food_truck_mobile/screen/food_detail_screen.dart';
import 'package:food_truck_mobile/widget/decorations/popular_tag.dart';
import 'package:food_truck_mobile/widget/text.dart';

/// This class contains a [CheckoutFoodItem] that can be pressed to view the food's
/// details
class CheckoutFoodItem extends StatelessWidget {
  const CheckoutFoodItem({super.key, required this.orderItemModel});

  final OrderItemModel orderItemModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        TextTitleSmall(
                          text: orderItemModel.foodName,
                          isBold: true,
                        ),
                        TextLabelSmall(
                          text: 'x${orderItemModel.quantity}',
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                          ),
                          maxLine: 3,
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: ListView(children: _getToppingRows(),)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextTitleSmall(
                          text:
                              '\$ ${orderItemModel.quantity * orderItemModel.singleItemPrice}',
                          isBold: true,
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 125,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(
                      orderItemModel.foodUrl,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  List<Widget> _getToppingRows() {
    List<Widget> toppingRows = <Widget>[];
    for (var topping in orderItemModel.toppings) {
      toppingRows.add(Align(
          alignment: Alignment.centerLeft,
          child: TextBodySmall(
            text: '\u2022 $topping',
            padding: const EdgeInsets.only(left: 12),
          )));
    }
    return toppingRows;
  }
}
