import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:works_app/core/theme/app_colors.dart';
import 'package:works_app/core/theme/app_spacing.dart';

/// Atom: Shimmer loading placeholder
class AppShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const AppShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey200,
      highlightColor: AppColors.grey100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

/// Atom: Circular progress indicator with brand color
class AppLoadingIndicator extends StatelessWidget {
  final double size;
  final Color? color;

  const AppLoadingIndicator({
    super.key,
    this.size = 24,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        color: color ?? AppColors.primary,
      ),
    );
  }
}

/// Atom: Job card shimmer loader
class JobCardShimmer extends StatelessWidget {
  const JobCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey200,
      highlightColor: AppColors.grey100,
      child: Container(
        padding: AppSpacing.paddingMD,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: AppRadius.radiusLG,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: AppRadius.radiusMD,
                  ),
                ),
                AppSpacing.hGapMD,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: double.infinity,
                          height: 16,
                          color: AppColors.white),
                      AppSpacing.gapXS,
                      Container(
                          width: 120, height: 12, color: AppColors.white),
                    ],
                  ),
                ),
              ],
            ),
            AppSpacing.gapMD,
            Container(
                width: double.infinity, height: 12, color: AppColors.white),
            AppSpacing.gapXS,
            Container(width: 200, height: 12, color: AppColors.white),
            AppSpacing.gapMD,
            Row(
              children: [
                Container(width: 60, height: 24, color: AppColors.white),
                AppSpacing.hGapSM,
                Container(width: 80, height: 24, color: AppColors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
