import 'package:flutter/material.dart';
import 'package:works_app/core/theme/app_text_styles.dart';

enum AppTextVariant {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
}

/// Atom: Base text widget for the design system
class AppText extends StatelessWidget {
  final String text;
  final AppTextVariant variant;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;

  const AppText(
    this.text, {
    super.key,
    this.variant = AppTextVariant.bodyMedium,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  });

  TextStyle get _style {
    switch (variant) {
      case AppTextVariant.displayLarge:
        return AppTextStyles.displayLarge;
      case AppTextVariant.displayMedium:
        return AppTextStyles.displayMedium;
      case AppTextVariant.displaySmall:
        return AppTextStyles.displaySmall;
      case AppTextVariant.headlineLarge:
        return AppTextStyles.headlineLarge;
      case AppTextVariant.headlineMedium:
        return AppTextStyles.headlineMedium;
      case AppTextVariant.headlineSmall:
        return AppTextStyles.headlineSmall;
      case AppTextVariant.titleLarge:
        return AppTextStyles.titleLarge;
      case AppTextVariant.titleMedium:
        return AppTextStyles.titleMedium;
      case AppTextVariant.titleSmall:
        return AppTextStyles.titleSmall;
      case AppTextVariant.bodyLarge:
        return AppTextStyles.bodyLarge;
      case AppTextVariant.bodyMedium:
        return AppTextStyles.bodyMedium;
      case AppTextVariant.bodySmall:
        return AppTextStyles.bodySmall;
      case AppTextVariant.labelLarge:
        return AppTextStyles.labelLarge;
      case AppTextVariant.labelMedium:
        return AppTextStyles.labelMedium;
      case AppTextVariant.labelSmall:
        return AppTextStyles.labelSmall;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _style.copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}
