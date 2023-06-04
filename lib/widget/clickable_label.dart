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

    TextStyle defaultTextStyle = TextStyle(
      decoration: TextDecoration.underline,
      color: color ?? Theme.of(context).primaryColor,
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
