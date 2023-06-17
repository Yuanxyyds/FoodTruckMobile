import 'package:flutter/material.dart';

import '../text.dart';

class CheckoutRow extends StatelessWidget {
  final IconData icon;
  final String primaryLine;
  final String secondaryLine;

  const CheckoutRow(
      {Key? key,
      required this.icon,
      required this.primaryLine,
      required this.secondaryLine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
            child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: TextTitleMedium(
                text: primaryLine,
                isBold: true,
                padding: EdgeInsets.zero,
              ),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: TextTitleMedium(
                    text: secondaryLine, padding: EdgeInsets.zero)),
          ],
        )),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(
              height: 50.0,
              child: Icon(Icons.arrow_forward_ios),
            )
          ],
        )
      ],
    );
  }
}
