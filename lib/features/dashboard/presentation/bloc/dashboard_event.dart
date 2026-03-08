import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class DashboardLoadJobsEvent extends DashboardEvent {
  final String? category;
  final String? search;

  const DashboardLoadJobsEvent({this.category, this.search});

  @override
  List<Object?> get props => [category, search];
}

class DashboardRefreshJobsEvent extends DashboardEvent {
  const DashboardRefreshJobsEvent();
}

class DashboardLoadMoreJobsEvent extends DashboardEvent {
  const DashboardLoadMoreJobsEvent();
}

class DashboardSearchChangedEvent extends DashboardEvent {
  final String query;

  const DashboardSearchChangedEvent({required this.query});

  @override
  List<Object?> get props => [query];
}

class DashboardFilterByCategoryEvent extends DashboardEvent {
  final String? category;

  const DashboardFilterByCategoryEvent({this.category});

  @override
  List<Object?> get props => [category];
}
