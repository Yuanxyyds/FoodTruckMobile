import 'package:flutter/material.dart';
import 'package:food_truck_mobile/widget/text.dart';

/// This class contains Header Option, which text is in between of (left and
/// right) two horizontal dividers.
class SectionHeaderLR extends StatelessWidget {
  const SectionHeaderLR({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children:  [
          const Expanded(
            child: Divider(), // Left horizontal line
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextTitleMedium(text: text),
          ),
          const Expanded(
            child: Divider(), // Right horizontal line
          ),
        ],
      ),
    );
  }
}
