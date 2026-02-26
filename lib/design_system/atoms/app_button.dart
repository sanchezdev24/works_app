import 'package:flutter/material.dart';
import 'package:works_app/core/theme/app_colors.dart';
import 'package:works_app/core/theme/app_spacing.dart';
import 'package:works_app/core/theme/app_text_styles.dart';

enum AppButtonVariant { primary, secondary, outlined, text, danger }
enum AppButtonSize { sm, md, lg }

/// Atom: Reusable button with variants and sizes
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool isLoading;
  final bool isFullWidth;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.md,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
    this.isFullWidth = false,
  });

  EdgeInsets get _padding {
    switch (size) {
      case AppButtonSize.sm:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case AppButtonSize.md:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
      case AppButtonSize.lg:
        return const EdgeInsets.symmetric(horizontal: 28, vertical: 16);
    }
  }

  double get _fontSize {
    switch (size) {
      case AppButtonSize.sm:
        return 12;
      case AppButtonSize.md:
        return 14;
      case AppButtonSize.lg:
        return 16;
    }
  }

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: _foregroundColor,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leadingIcon != null) ...[
                leadingIcon!,
                AppSpacing.hGapXS,
              ],
              Text(
                label,
                style: AppTextStyles.labelLarge.copyWith(
                  fontSize: _fontSize,
                  color: _foregroundColor,
                ),
              ),
              if (trailingIcon != null) ...[
                AppSpacing.hGapXS,
                trailingIcon!,
              ],
            ],
          );

    Widget button;
    switch (variant) {
      case AppButtonVariant.primary:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            padding: _padding,
            elevation: 0,
          ),
          child: child,
        );
        break;
      case AppButtonVariant.secondary:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.surfaceVariant,
            foregroundColor: AppColors.primary,
            padding: _padding,
            elevation: 0,
          ),
          child: child,
        );
        break;
      case AppButtonVariant.outlined:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.primary),
            padding: _padding,
          ),
          child: child,
        );
        break;
      case AppButtonVariant.text:
        button = TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            padding: _padding,
          ),
          child: child,
        );
        break;
      case AppButtonVariant.danger:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.error,
            foregroundColor: AppColors.white,
            padding: _padding,
            elevation: 0,
          ),
          child: child,
        );
        break;
    }

    return isFullWidth
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }

  Color get _foregroundColor {
    switch (variant) {
      case AppButtonVariant.primary:
      case AppButtonVariant.danger:
        return AppColors.white;
      case AppButtonVariant.secondary:
        return AppColors.primary;
      case AppButtonVariant.outlined:
      case AppButtonVariant.text:
        return AppColors.primary;
    }
  }
}
