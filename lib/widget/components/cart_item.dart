import 'package:flutter/material.dart';
import 'package:food_truck_mobile/widget/dividers/section_divider.dart';
import 'package:food_truck_mobile/widget/text.dart';

class CartItem extends StatefulWidget {
  final String itemName;
  final double itemPrice;
  final int count;

  const CartItem(
      {Key? key,
      required this.itemName,
      required this.itemPrice,
      required this.count})
      : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int count = 1;

  @override
  void initState() {
    super.initState();
    count = widget.count;
  }

  @override
  Widget build(BuildContext context) {
    Color removeColor = count == 1 ? Colors.grey : Colors.black;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: TextTitleMedium(
              text: widget.itemName,
              isBold: true,
            )),
            TextTitleMedium(
              text: '\$ ${widget.itemPrice.toStringAsFixed(2)}',
              padding: EdgeInsets.zero,
            ),
          ],
        ),
        const SizedBox(
          height: 20.0,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Expanded(child: TextTitleMedium(text: "Quantity")),
            Container(
              height: 50.0,
              width: 120.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        count = count > 1 ? count - 1 : 1;
                      });
                    },
                    icon: Icon(
                      Icons.remove,
                      color: removeColor,
                    ),
                  ),
                  Text(
                    count.toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        count += 1;
                      });
                    },
                    icon: const Icon(
                      Icons.add,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const SectionDivider()
      ],
    );
  }
}
