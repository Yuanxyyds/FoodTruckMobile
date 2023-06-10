import 'package:flutter/material.dart';
import 'package:food_truck_mobile/widget/text.dart';

/// This class contains single horizontal divider with default horizontal
/// padding = 8
class SectionDivider extends StatelessWidget {
  const SectionDivider({
    super.key,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
  });

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: const Divider(thickness: 2,),
    );
  }
}
