import 'package:flutter/material.dart';

/// A template component for Text for this app
class _Text extends StatelessWidget {
  const _Text({
    super.key,
    required this.text,
    required this.style,
    required this.overflow,
    required this.padding,
  });

  final String text;
  final TextStyle style;
  final TextOverflow overflow;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        style: style,
        overflow: overflow,
      ),
    );
  }
}

/// TextDisplayLarge
class TextDisplayLarge extends StatelessWidget {
  const TextDisplayLarge({
    super.key,
    required this.text,
    this.color,
    this.isBold = false,
    this.overflow = TextOverflow.ellipsis,
    this.padding = const EdgeInsets.all(4.0),
  });

  final String text;
  final Color? color;
  final bool isBold;
  final TextOverflow overflow;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface)
        .displayLarge!;

    final TextStyle style =
        isBold ? baseStyle.copyWith(fontWeight: FontWeight.bold) : baseStyle;

    return _Text(
      text: text,
      style: style.copyWith(color: color),
      overflow: overflow,
      padding: padding,
    );
  }
}

/// TextDisplayLarge
class TextDisplayMedium extends StatelessWidget {
  const TextDisplayMedium({
    super.key,
    required this.text,
    this.color,
    this.isBold = false,
    this.overflow = TextOverflow.ellipsis,
    this.padding = const EdgeInsets.all(4.0),
  });

  final String text;
  final Color? color;
  final bool isBold;
  final TextOverflow overflow;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface)
        .displayMedium!;
    final TextStyle style =
        isBold ? baseStyle.copyWith(fontWeight: FontWeight.bold) : baseStyle;
    return _Text(
      text: text,
      style: style.copyWith(color: color),
      overflow: overflow,
      padding: padding,
    );
  }
}

/// TextDisplaySmall
class TextDisplaySmall extends StatelessWidget {
  const TextDisplaySmall({
    super.key,
    required this.text,
    this.color,
    this.isBold = false,
    this.overflow = TextOverflow.ellipsis,
    this.padding = const EdgeInsets.all(4.0),
  });

  final String text;
  final Color? color;
  final bool isBold;
  final TextOverflow overflow;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface)
        .displaySmall!;
    final TextStyle style =
        isBold ? baseStyle.copyWith(fontWeight: FontWeight.bold) : baseStyle;
    return _Text(
      text: text,
      style: style.copyWith(color: color),
      overflow: overflow,
      padding: padding,
    );
  }
}

/// TextHeadlineLarge
class TextHeadlineLarge extends StatelessWidget {
  const TextHeadlineLarge({
    super.key,
    required this.text,
    this.color,
    this.isBold = false,
    this.overflow = TextOverflow.ellipsis,
    this.padding = const EdgeInsets.all(4.0),
  });

  final String text;
  final Color? color;
  final bool isBold;
  final TextOverflow overflow;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface)
        .headlineLarge!;

    final TextStyle style =
        isBold ? baseStyle.copyWith(fontWeight: FontWeight.bold) : baseStyle;

    return _Text(
      text: text,
      style: style.copyWith(color: color),
      overflow: overflow,
      padding: padding,
    );
  }
}

/// TextHeadlineMedium
class TextHeadlineMedium extends StatelessWidget {
  const TextHeadlineMedium({
    super.key,
    required this.text,
    this.color,
    this.isBold = false,
    this.overflow = TextOverflow.ellipsis,
    this.padding = const EdgeInsets.all(4.0),
  });

  final String text;
  final Color? color;
  final bool isBold;
  final TextOverflow overflow;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface)
        .headlineMedium!;

    final TextStyle style =
        isBold ? baseStyle.copyWith(fontWeight: FontWeight.bold) : baseStyle;

    return _Text(
      text: text,
      style: style.copyWith(color: color),
      overflow: overflow,
      padding: padding,
    );
  }
}

/// TextHeadlineSmall
class TextHeadlineSmall extends StatelessWidget {
  const TextHeadlineSmall({
    super.key,
    required this.text,
    this.color,
    this.isBold = false,
    this.overflow = TextOverflow.ellipsis,
    this.padding = const EdgeInsets.all(4.0),
  });

  final String text;
  final Color? color;
  final bool isBold;
  final TextOverflow overflow;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface)
        .headlineSmall!;
    final TextStyle style =
        isBold ? baseStyle.copyWith(fontWeight: FontWeight.bold) : baseStyle;

    return _Text(
      text: text,
      style: style.copyWith(color: color),
      overflow: overflow,
      padding: padding,
    );
  }
}

/// TextTitleLarge
class TextTitleLarge extends StatelessWidget {
  const TextTitleLarge({
    super.key,
    required this.text,
    this.color,
    this.isBold = false,
    this.overflow = TextOverflow.ellipsis,
    this.padding = const EdgeInsets.all(4.0),
  });

  final String text;
  final Color? color;
  final bool isBold;
  final TextOverflow overflow;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface)
        .titleLarge!;
    final TextStyle style =
        isBold ? baseStyle.copyWith(fontWeight: FontWeight.bold) : baseStyle;
    return _Text(
      text: text,
      style: style.copyWith(color: color),
      overflow: overflow,
      padding: padding,
    );
  }
}

/// TextTitleMedium
class TextTitleMedium extends StatelessWidget {
  const TextTitleMedium({
    super.key,
    required this.text,
    this.color,
    this.isBold = false,
    this.overflow = TextOverflow.ellipsis,
    this.padding = const EdgeInsets.all(4.0),
  });

  final String text;
  final Color? color;
  final bool isBold;
  final TextOverflow overflow;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface)
        .titleMedium!;
    final TextStyle style =
        isBold ? baseStyle.copyWith(fontWeight: FontWeight.bold) : baseStyle;
    return _Text(
      text: text,
      style: style.copyWith(color: color),
      overflow: overflow,
      padding: padding,
    );
  }
}

/// TextTitleSmall
class TextTitleSmall extends StatelessWidget {
  const TextTitleSmall({
    super.key,
    required this.text,
    this.color,
    this.isBold = false,
    this.overflow = TextOverflow.ellipsis,
    this.padding = const EdgeInsets.all(4.0),
  });

  final String text;
  final Color? color;
  final bool isBold;
  final TextOverflow overflow;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface)
        .titleSmall!;
    final TextStyle style =
        isBold ? baseStyle.copyWith(fontWeight: FontWeight.bold) : baseStyle;
    return _Text(
      text: text,
      style: style.copyWith(color: color),
      overflow: overflow,
      padding: padding,
    );
  }
}

/// TextLabelLarge
class TextLabelLarge extends StatelessWidget {
  const TextLabelLarge({
    super.key,
    required this.text,
    this.color,
    this.isBold = false,
    this.overflow = TextOverflow.ellipsis,
    this.padding = const EdgeInsets.all(4.0),
  });

  final String text;
  final Color? color;
  final bool isBold;
  final TextOverflow overflow;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface)
        .labelLarge!;
    final TextStyle style =
        isBold ? baseStyle.copyWith(fontWeight: FontWeight.bold) : baseStyle;
    return _Text(
      text: text,
      style: style.copyWith(color: color),
      overflow: overflow,
      padding: padding,
    );
  }
}

/// TextLabelMedium
class TextLabelMedium extends StatelessWidget {
  const TextLabelMedium({
    super.key,
    required this.text,
    this.color,
    this.isBold = false,
    this.overflow = TextOverflow.ellipsis,
    this.padding = const EdgeInsets.all(4.0),
  });

  final String text;
  final Color? color;
  final bool isBold;
  final TextOverflow overflow;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface)
        .labelMedium!;
    final TextStyle style =
        isBold ? baseStyle.copyWith(fontWeight: FontWeight.bold) : baseStyle;
    return _Text(
      text: text,
      style: style.copyWith(color: color),
      overflow: overflow,
      padding: padding,
    );
  }
}

/// TextLabelSmall
class TextLabelSmall extends StatelessWidget {
  const TextLabelSmall({
    super.key,
    required this.text,
    this.color,
    this.isBold = false,
    this.overflow = TextOverflow.ellipsis,
    this.padding = const EdgeInsets.all(4.0),
  });

  final String text;
  final Color? color;
  final bool isBold;
  final TextOverflow overflow;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface)
        .labelSmall!;
    final TextStyle style =
        isBold ? baseStyle.copyWith(fontWeight: FontWeight.bold) : baseStyle;
    return _Text(
      text: text,
      style: style.copyWith(color: color),
      overflow: overflow,
      padding: padding,
    );
  }
}

/// TextBodyLarge
class TextBodyLarge extends StatelessWidget {
  const TextBodyLarge({
    super.key,
    required this.text,
    this.color,
    this.isBold = false,
    this.overflow = TextOverflow.ellipsis,
    this.padding = const EdgeInsets.all(4.0),
  });

  final String text;
  final Color? color;
  final bool isBold;
  final TextOverflow overflow;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface)
        .bodyLarge!;
    final TextStyle style =
        isBold ? baseStyle.copyWith(fontWeight: FontWeight.bold) : baseStyle;
    return _Text(
      text: text,
      style: style.copyWith(color: color),
      overflow: overflow,
      padding: padding,
    );
  }
}

/// TextBodyMedium
class TextBodyMedium extends StatelessWidget {
  const TextBodyMedium({
    super.key,
    required this.text,
    this.color,
    this.isBold = false,
    this.overflow = TextOverflow.ellipsis,
    this.padding = const EdgeInsets.all(4.0),
  });

  final String text;
  final Color? color;
  final bool isBold;
  final TextOverflow overflow;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface)
        .bodyMedium!;
    final TextStyle style =
        isBold ? baseStyle.copyWith(fontWeight: FontWeight.bold) : baseStyle;
    return _Text(
      text: text,
      style: style.copyWith(color: color),
      overflow: overflow,
      padding: padding,
    );
  }
}

/// TextBodySmall
class TextBodySmall extends StatelessWidget {
  const TextBodySmall({
    super.key,
    required this.text,
    this.color,
    this.isBold = false,
    this.overflow = TextOverflow.ellipsis,
    this.padding = const EdgeInsets.all(4.0),
  });

  final String text;
  final Color? color;
  final bool isBold;
  final TextOverflow overflow;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface)
        .bodySmall!;
    final TextStyle style =
        isBold ? baseStyle.copyWith(fontWeight: FontWeight.bold) : baseStyle;
    return _Text(
      text: text,
      style: style.copyWith(color: color),
      overflow: overflow,
      padding: padding,
    );
  }
}
