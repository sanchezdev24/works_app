import 'package:flutter/material.dart';
import 'package:works_app/core/theme/app_colors.dart';
import 'package:works_app/core/theme/app_spacing.dart';
import 'package:works_app/design_system/atoms/app_button.dart';
import 'package:works_app/design_system/atoms/app_text.dart';

/// Molecule: Error state with retry action
class AppErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const AppErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.paddingXL,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: Color(0xFFFFEBEE),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: 36,
                color: AppColors.error,
              ),
            ),
            AppSpacing.gapLG,
            const AppText(
              'Algo salió mal',
              variant: AppTextVariant.titleMedium,
              textAlign: TextAlign.center,
            ),
            AppSpacing.gapSM,
            AppText(
              message,
              variant: AppTextVariant.bodyMedium,
              color: AppColors.textSecondary,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              AppSpacing.gapLG,
              AppButton(
                label: 'Reintentar',
                onPressed: onRetry,
                leadingIcon: const Icon(Icons.refresh_rounded,
                    size: 18, color: Colors.white),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
