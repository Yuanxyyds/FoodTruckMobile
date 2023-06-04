import 'package:flutter/material.dart';
import 'package:food_truck_mobile/widget/text.dart';

/// A tag of Popular
class PopularTag extends StatelessWidget {
  const PopularTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.yellow,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: const TextLabelSmall(text: 'popular'));
  }
}
