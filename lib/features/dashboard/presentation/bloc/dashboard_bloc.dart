import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:works_app/features/dashboard/domain/usecases/get_jobs_usecase.dart';
import 'package:works_app/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:works_app/features/dashboard/presentation/bloc/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetJobsUseCase getJobsUseCase;

  static const int _pageLimit = 20;

  DashboardBloc({required this.getJobsUseCase})
      : super(const DashboardState()) {
    on<DashboardLoadJobsEvent>(_onLoadJobs);
    on<DashboardRefreshJobsEvent>(_onRefreshJobs);
    on<DashboardLoadMoreJobsEvent>(_onLoadMoreJobs);
    on<DashboardSearchChangedEvent>(_onSearchChanged);
    on<DashboardFilterByCategoryEvent>(_onFilterByCategory);
  }

  Future<void> _onLoadJobs(
    DashboardLoadJobsEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(status: DashboardStatus.loading));

    final result = await getJobsUseCase.call(
      GetJobsParams(
        category: event.category ?? state.selectedCategory,
        search: event.search ?? state.searchQuery,
        limit: _pageLimit,
        offset: 0,
      ),
    ).run();

    result.match(
      (failure) => emit(state.copyWith(
        status: DashboardStatus.failure,
        errorMessage: failure.toString(),
      )),
      (jobs) => emit(state.copyWith(
        status: DashboardStatus.success,
        jobs: jobs,
        currentOffset: jobs.length,
        hasReachedMax: jobs.length < _pageLimit,
      )),
    );
  }

  Future<void> _onRefreshJobs(
    DashboardRefreshJobsEvent event,
    Emitter<DashboardState> emit,
  ) async {
    add(DashboardLoadJobsEvent(
      category: state.selectedCategory,
      search: state.searchQuery,
    ));
  }

  Future<void> _onLoadMoreJobs(
    DashboardLoadMoreJobsEvent event,
    Emitter<DashboardState> emit,
  ) async {
    if (state.hasReachedMax || state.isLoadingMore) return;

    emit(state.copyWith(status: DashboardStatus.loadingMore));

    final result = await getJobsUseCase.call(
      GetJobsParams(
        category: state.selectedCategory,
        search: state.searchQuery,
        limit: _pageLimit,
        offset: state.currentOffset,
      ),
    ).run();

    result.match(
      (failure) => emit(state.copyWith(
        status: DashboardStatus.success, // revert to success, show snackbar
        errorMessage: failure.toString(),
      )),
      (newJobs) {
        final allJobs = [...state.jobs, ...newJobs];
        emit(state.copyWith(
          status: DashboardStatus.success,
          jobs: allJobs,
          currentOffset: allJobs.length,
          hasReachedMax: newJobs.length < _pageLimit,
        ));
      },
    );
  }

  Future<void> _onSearchChanged(
    DashboardSearchChangedEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(searchQuery: event.query));
    add(DashboardLoadJobsEvent(search: event.query));
  }

  Future<void> _onFilterByCategory(
    DashboardFilterByCategoryEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(selectedCategory: event.category));
    add(DashboardLoadJobsEvent(category: event.category));
  }
}
