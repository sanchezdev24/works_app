import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:works_app/core/di/injection_container.dart';
import 'package:works_app/core/theme/app_colors.dart';
import 'package:works_app/core/theme/app_spacing.dart';
import 'package:works_app/core/theme/app_text_styles.dart';
import 'package:works_app/design_system/atoms/app_loading.dart';
import 'package:works_app/design_system/atoms/app_text.dart';
import 'package:works_app/design_system/molecules/app_empty_state.dart';
import 'package:works_app/design_system/molecules/app_error_widget.dart';
import 'package:works_app/design_system/molecules/app_search_bar.dart';
import 'package:works_app/design_system/organisms/job_card.dart';
import 'package:works_app/design_system/templates/scaffold_template.dart';
import 'package:works_app/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:works_app/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:works_app/features/dashboard/presentation/bloc/dashboard_state.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DashboardBloc>()
        ..add(const DashboardLoadJobsEvent()),
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatefulWidget {
  const _DashboardView();

  @override
  State<_DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<_DashboardView> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  static const _categories = [
    'All',
    'Software Dev',
    'DevOps / Sysadmin',
    'Design',
    'Marketing',
    'Finance',
    'Product',
    'Data Science',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<DashboardBloc>().add(const DashboardLoadMoreJobsEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final current = _scrollController.offset;
    return current >= maxScroll * 0.9;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldTemplate(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          _buildSliverAppBar(context),
        ],
        body: BlocConsumer<DashboardBloc, DashboardState>(
          listener: (context, state) {
            if (state.isFailure && state.jobs.isNotEmpty) {
              // Show snackbar for load-more errors
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Error'),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.isLoading && state.jobs.isEmpty) {
              return _buildShimmerList();
            }

            if (state.isFailure && state.jobs.isEmpty) {
              return AppErrorWidget(
                message: state.errorMessage ?? 'No se pudieron cargar los trabajos.',
                onRetry: () => context
                    .read<DashboardBloc>()
                    .add(const DashboardRefreshJobsEvent()),
              );
            }

            if (state.isSuccess && state.jobs.isEmpty) {
              return AppEmptyState(
                icon: Icons.work_off_outlined,
                title: 'Sin resultados',
                subtitle: 'No encontramos trabajos con esos filtros.',
                actionLabel: 'Limpiar filtros',
                onAction: () {
                  _searchController.clear();
                  context.read<DashboardBloc>().add(
                        const DashboardFilterByCategoryEvent(category: null),
                      );
                },
              );
            }

            return RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () async {
                context
                    .read<DashboardBloc>()
                    .add(const DashboardRefreshJobsEvent());
              },
              child: ListView.separated(
                padding: AppSpacing.screenPadding.copyWith(
                  top: AppSpacing.md,
                  bottom: AppSpacing.xl,
                ),
                itemCount:
                    state.jobs.length + (state.isLoadingMore ? 1 : 0),
                separatorBuilder: (_, __) => AppSpacing.gapMD,
                itemBuilder: (context, index) {
                  if (index == state.jobs.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: AppLoadingIndicator(),
                      ),
                    );
                  }
                  final job = state.jobs[index];
                  return JobCard(job: job);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.background,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: _buildHeader(context),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(116),
        child: Container(
          color: AppColors.background,
          padding: AppSpacing.paddingHMD,
          child: Column(
            children: [
              AppSearchBar(
                controller: _searchController,
                onChanged: (query) {
                  context
                      .read<DashboardBloc>()
                      .add(DashboardSearchChangedEvent(query: query));
                },
              ),
              AppSpacing.gapSM,
              _buildCategoryChips(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 56, 16, 0),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Encuentra tu\n',
                  style: AppTextStyles.headlineMedium,
                ),
                TextSpan(
                  text: 'trabajo remoto ',
                  style: AppTextStyles.headlineMedium
                      .copyWith(color: AppColors.primary),
                ),
                TextSpan(
                  text: '🚀',
                  style: AppTextStyles.headlineMedium,
                ),
              ],
            ),
          ),
          AppSpacing.gapXS,
          BlocBuilder<DashboardBloc, DashboardState>(
            buildWhen: (prev, curr) => prev.jobs.length != curr.jobs.length,
            builder: (context, state) {
              if (state.jobs.isEmpty) return const SizedBox.shrink();
              return AppText(
                '${state.jobs.length} trabajos disponibles',
                variant: AppTextVariant.bodySmall,
                color: AppColors.textSecondary,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      buildWhen: (prev, curr) =>
          prev.selectedCategory != curr.selectedCategory,
      builder: (context, state) {
        return SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            separatorBuilder: (_, __) => AppSpacing.hGapXS,
            itemBuilder: (context, index) {
              final category = _categories[index];
              final isSelected = category == 'All'
                  ? state.selectedCategory == null
                  : state.selectedCategory == category;

              return FilterChip(
                label: Text(
                  category,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textSecondary,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
                ),
                selected: isSelected,
                onSelected: (_) {
                  context.read<DashboardBloc>().add(
                        DashboardFilterByCategoryEvent(
                          category: category == 'All' ? null : category,
                        ),
                      );
                },
                selectedColor: AppColors.surfaceVariant,
                checkmarkColor: AppColors.primary,
                backgroundColor: AppColors.surface,
                side: BorderSide(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.grey300,
                ),
                showCheckmark: false,
                padding: const EdgeInsets.symmetric(horizontal: 4),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildShimmerList() {
    return ListView.separated(
      padding: AppSpacing.screenPadding.copyWith(top: AppSpacing.md),
      itemCount: 6,
      separatorBuilder: (_, __) => AppSpacing.gapMD,
      itemBuilder: (_, __) => const JobCardShimmer(),
    );
  }
}
