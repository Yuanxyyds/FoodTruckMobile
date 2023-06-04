import 'package:flutter/material.dart';

import '../helper/constants.dart';

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
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 4.0, top: 8.0, bottom: 8.0, right: 8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2.0),
            ),
            width: 24,
            height: 24,
            child: Theme(
              data: ThemeData(unselectedWidgetColor: Constants.backgroundColor),
              child: Checkbox(
                checkColor: Colors.black,
                activeColor: Colors.transparent,
                value: checked,
                tristate: false,
                onChanged: (bool? value) {
                  setState(() {
                    checked = value!;
                  });
                },
              ),
            ),
          ),
        ),
        Expanded(child: Text(widget.name)),
        Text('\$ ${widget.price.toStringAsFixed(2)}'),
      ],
    );
  }
}
