import 'package:flutter/material.dart';

class ClickableLabel extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const ClickableLabel({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    TextStyle defaultTextStyle = TextStyle(
      decoration: TextDecoration.underline,
      color: Theme.of(context).primaryColor,
    );

    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .apply(displayColor: Theme.of(context).colorScheme.onSurface)
            .labelLarge!.merge(defaultTextStyle),
      ),
    );
  }
}
