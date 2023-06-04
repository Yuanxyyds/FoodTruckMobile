import 'package:flutter/material.dart';
import 'package:food_truck_mobile/widget/text.dart';

/// This class contains Header Option, which text is in between of (top and
/// bottom) by two horizontal dividers.
class SectionHeaderTB extends StatelessWidget {
  const SectionHeaderTB({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          const Divider(),
          Align(
            alignment: Alignment.topLeft,
            child: TextTitleMedium(
              text: text,
              isBold: true,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
