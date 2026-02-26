import 'package:equatable/equatable.dart';
import 'package:works_app/features/dashboard/domain/entities/job_entity.dart';

enum DashboardStatus { initial, loading, success, failure, loadingMore }

class DashboardState extends Equatable {
  final DashboardStatus status;
  final List<JobEntity> jobs;
  final String? errorMessage;
  final String? selectedCategory;
  final String searchQuery;
  final bool hasReachedMax;
  final int currentOffset;

  const DashboardState({
    this.status = DashboardStatus.initial,
    this.jobs = const [],
    this.errorMessage,
    this.selectedCategory,
    this.searchQuery = '',
    this.hasReachedMax = false,
    this.currentOffset = 0,
  });

  bool get isInitial => status == DashboardStatus.initial;
  bool get isLoading => status == DashboardStatus.loading;
  bool get isSuccess => status == DashboardStatus.success;
  bool get isFailure => status == DashboardStatus.failure;
  bool get isLoadingMore => status == DashboardStatus.loadingMore;

  DashboardState copyWith({
    DashboardStatus? status,
    List<JobEntity>? jobs,
    String? errorMessage,
    String? selectedCategory,
    String? searchQuery,
    bool? hasReachedMax,
    int? currentOffset,
  }) {
    return DashboardState(
      status: status ?? this.status,
      jobs: jobs ?? this.jobs,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentOffset: currentOffset ?? this.currentOffset,
    );
  }

  DashboardState clearError() {
    return DashboardState(
      status: status,
      jobs: jobs,
      selectedCategory: selectedCategory,
      searchQuery: searchQuery,
      hasReachedMax: hasReachedMax,
      currentOffset: currentOffset,
    );
  }

  @override
  List<Object?> get props => [
        status,
        jobs,
        errorMessage,
        selectedCategory,
        searchQuery,
        hasReachedMax,
        currentOffset,
      ];
}
