import 'package:flutter/material.dart';

class AdditionFood extends StatefulWidget {
  final String name;
  final double price;

  const AdditionFood({
    Key? key,
    required this.name,
    required this.price,
  }) : super(key: key);

  @override
  State<AdditionFood> createState() => _AdditionFoodState();
}

class _AdditionFoodState extends State<AdditionFood> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
