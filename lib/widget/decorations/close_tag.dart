import 'package:flutter/material.dart';
import 'package:food_truck_mobile/widget/text.dart';
import 'package:food_truck_mobile/helper/constants.dart';

/// A tag of Close
class CloseTag extends StatelessWidget {
  const CloseTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: const Center(child: TextLabelSmall(text: 'Close', color: Constants.whiteColor,)));
  }
}
