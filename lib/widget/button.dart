import 'package:flutter/material.dart';

import 'text.dart';

/// This class contains the [TextButton] for the entire app
class Button extends StatelessWidget {
  const Button({
    super.key,
    this.text,
    this.textColor,
    this.backgroundColor,
    this.icon,
    this.isEnabled = true,
    this.onPressed,
    this.padding,
    this.takeLeastSpace = false,
  });

  final String? text;
  final Color? textColor;
  final Color? backgroundColor;
  final IconData? icon;
  final bool isEnabled;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final bool takeLeastSpace;

  @override
  Widget build(BuildContext context) {
    final Color defaultTextColor =
        textColor ?? Theme.of(context).textTheme.labelLarge!.color!;
    final Color defaultBackgroundColor = backgroundColor ??
        Theme.of(context).buttonTheme.colorScheme!.primary;

    return TextButton(
      onPressed: isEnabled ? onPressed : null,
      style: TextButton.styleFrom(
        foregroundColor: defaultTextColor,
        backgroundColor: defaultBackgroundColor,
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Row(
          mainAxisSize: takeLeastSpace ? MainAxisSize.min : MainAxisSize.max,
          children: [
            if (icon != null) Icon(icon),
            if (icon != null && text != null) const SizedBox(width: 8),
            if (text != null)
            Flexible(
                child: TextBodyMedium(
              text: text!,
              isBold: true,
              color: defaultTextColor,
            )),
          ],
        ),
      ),
    );
  }
}
