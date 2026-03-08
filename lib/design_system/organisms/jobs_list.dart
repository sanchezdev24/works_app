import 'package:flutter/material.dart';
import 'package:works_app/core/theme/app_spacing.dart';
import 'package:works_app/design_system/atoms/app_loading.dart';
import 'package:works_app/design_system/organisms/job_card.dart';
import 'package:works_app/features/dashboard/domain/entities/job_entity.dart';

/// Organism: Scrollable list of job cards
class JobsList extends StatelessWidget {
  final List<JobEntity> jobs;
  final bool isLoadingMore;
  final ScrollController? scrollController;
  final ValueChanged<JobEntity>? onJobTap;

  const JobsList({
    super.key,
    required this.jobs,
    this.isLoadingMore = false,
    this.scrollController,
    this.onJobTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      padding: AppSpacing.screenPadding.copyWith(
        top: AppSpacing.md,
        bottom: AppSpacing.xl,
      ),
      itemCount: jobs.length + (isLoadingMore ? 1 : 0),
      separatorBuilder: (_, __) => AppSpacing.gapMD,
      itemBuilder: (context, index) {
        if (index == jobs.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: AppLoadingIndicator(),
            ),
          );
        }
        return JobCard(
          job: jobs[index],
          onTap: onJobTap != null ? () => onJobTap!(jobs[index]) : null,
        );
      },
    );
  }
}
