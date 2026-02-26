import 'package:flutter/material.dart';
import 'package:works_app/core/theme/app_colors.dart';
import 'package:works_app/core/theme/app_spacing.dart';
import 'package:works_app/design_system/atoms/app_avatar.dart';
import 'package:works_app/design_system/atoms/app_badge.dart';
import 'package:works_app/design_system/atoms/app_text.dart';
import 'package:works_app/features/dashboard/domain/entities/job_entity.dart';

/// Organism: Job card combining multiple molecules and atoms
class JobCard extends StatelessWidget {
  final JobEntity job;
  final VoidCallback? onTap;

  const JobCard({
    super.key,
    required this.job,
    this.onTap,
  });

  AppBadgeVariant _jobTypeVariant(String jobType) {
    switch (jobType.toLowerCase()) {
      case 'full time':
      case 'full-time':
        return AppBadgeVariant.success;
      case 'part time':
      case 'part-time':
        return AppBadgeVariant.warning;
      case 'contract':
        return AppBadgeVariant.info;
      default:
        return AppBadgeVariant.neutral;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: AppSpacing.paddingMD,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.radiusLG,
          border: Border.all(color: AppColors.grey200),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: company logo + name + date
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppAvatar(
                  imageUrl: job.companyLogo,
                  name: job.company,
                  size: AppAvatarSize.md,
                  backgroundColor: AppColors.grey100,
                ),
                AppSpacing.hGapMD,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        job.title,
                        variant: AppTextVariant.titleSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      AppSpacing.gapXS,
                      AppText(
                        job.company,
                        variant: AppTextVariant.bodySmall,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),
                AppSpacing.hGapSM,
                Icon(
                  Icons.bookmark_border_rounded,
                  color: AppColors.grey400,
                  size: 20,
                ),
              ],
            ),

            AppSpacing.gapMD,

            // Location + Remote
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
                AppSpacing.hGapXS,
                Expanded(
                  child: AppText(
                    job.candidateRequiredLocation.isEmpty
                        ? 'Worldwide'
                        : job.candidateRequiredLocation,
                    variant: AppTextVariant.bodySmall,
                    color: AppColors.textSecondary,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (job.salary.isNotEmpty) ...[
                  AppSpacing.hGapSM,
                  const Icon(
                    Icons.attach_money_rounded,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  AppText(
                    job.salary,
                    variant: AppTextVariant.bodySmall,
                    color: AppColors.textSecondary,
                  ),
                ],
              ],
            ),

            AppSpacing.gapMD,

            // Tags row
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                AppBadge(
                  label: job.jobType,
                  variant: _jobTypeVariant(job.jobType),
                ),
                if (job.tags.isNotEmpty)
                  ...job.tags
                      .take(2)
                      .map((tag) => AppBadge(
                            label: tag,
                            variant: AppBadgeVariant.neutral,
                          ))
                      .toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
