import 'package:flutter/material.dart';

import '../helper/constants.dart';

/// This class contains a pretty version of [TextField]
class InputField extends StatelessWidget {

  InputField(
      {super.key,
      required this.labelText,
      required this.prefixIcon,
      this.controller,
      this.onChange,
      this.onTap,
      this.focusNode,
      this.obscureText = false,});

  final String labelText;
  final Widget prefixIcon;
  final TextEditingController? controller;
  final ValueSetter<String>? onChange;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Constants.whiteColor, // Shadow color
            spreadRadius: 2, // Spread radius
            blurRadius: 10, // Blur radius
            offset: Offset(0, 0), // Offset in x and y direction
          ),
        ],
      ),
      child: TextField(
        onTap: onTap,
        obscureText: obscureText,
        onChanged: onChange,
        focusNode: focusNode,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: prefixIcon,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
