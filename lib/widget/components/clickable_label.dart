import 'package:flutter/material.dart';

/// This Class contains a Underlined Clickable Text Label
class ClickableLabel extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color? color;

  const ClickableLabel({
    super.key,
    required this.text,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = color ?? Theme.of(context).primaryColor;

    TextStyle defaultTextStyle = TextStyle(
      color: textColor,
    );

    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: textColor,
            ),
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .apply(displayColor: Theme.of(context).colorScheme.onSurface)
              .labelLarge!
              .merge(defaultTextStyle),
        ),
      ),
    );
  }
}