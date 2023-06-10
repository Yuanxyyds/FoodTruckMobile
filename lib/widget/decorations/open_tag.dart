import 'package:flutter/material.dart';
import 'package:food_truck_mobile/helper/constants.dart';
import 'package:food_truck_mobile/widget/text.dart';
import 'package:food_truck_mobile/helper/constants.dart';

/// A tag of Open
class OpenTag extends StatelessWidget {
  const OpenTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: const Center(
          child: TextLabelSmall(
            text: 'Open',
            color: Constants.whiteColor,
          ),
        ));
  }
}
