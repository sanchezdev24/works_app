import 'package:flutter/material.dart';
import 'package:works_app/core/theme/app_colors.dart';
import 'package:works_app/core/theme/app_spacing.dart';
import 'package:works_app/core/theme/app_text_styles.dart';

enum AppBadgeVariant { success, warning, error, info, neutral, primary }

/// Atom: Badge/chip for status labels and tags
class AppBadge extends StatelessWidget {
  final String label;
  final AppBadgeVariant variant;
  final Widget? icon;

  const AppBadge({
    super.key,
    required this.label,
    this.variant = AppBadgeVariant.neutral,
    this.icon,
  });

  Color get _backgroundColor {
    switch (variant) {
      case AppBadgeVariant.success:
        return AppColors.tagFullTime;
      case AppBadgeVariant.warning:
        return AppColors.tagPartTime;
      case AppBadgeVariant.error:
        return const Color(0xFFFFEBEE);
      case AppBadgeVariant.info:
        return AppColors.tagContract;
      case AppBadgeVariant.neutral:
        return AppColors.grey100;
      case AppBadgeVariant.primary:
        return AppColors.surfaceVariant;
    }
  }

  Color get _textColor {
    switch (variant) {
      case AppBadgeVariant.success:
        return AppColors.tagFullTimeText;
      case AppBadgeVariant.warning:
        return AppColors.tagPartTimeText;
      case AppBadgeVariant.error:
        return AppColors.error;
      case AppBadgeVariant.info:
        return AppColors.tagContractText;
      case AppBadgeVariant.neutral:
        return AppColors.textSecondary;
      case AppBadgeVariant.primary:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: AppRadius.radiusFull,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            icon!,
            AppSpacing.hGapXS,
          ],
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(color: _textColor),
          ),
        ],
      ),
    );
  }
}
