import 'package:flutter/material.dart';
import 'package:food_truck_mobile/widget/text.dart';

class CheckoutItem extends StatelessWidget {
  final String name;
  final double price;
  final bool isBold;

  const CheckoutItem(
      {Key? key, required this.name, required this.price, this.isBold = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextTitleMedium(
          text: name,
          isBold: isBold,
        )),
        TextTitleMedium(
          text: '\$ ${price.toStringAsFixed(2)}',
          padding: EdgeInsets.zero,
          isBold: isBold,
        )
      ],
    );
  }
}
