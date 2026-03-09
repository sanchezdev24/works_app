import 'package:equatable/equatable.dart';
import 'package:works_app/core/usecase/usecase.dart';
import 'package:works_app/core/utils/typedefs.dart';
import 'package:works_app/features/dashboard/domain/entities/job_entity.dart';
import 'package:works_app/features/dashboard/domain/repositories/jobs_repository.dart';

class GetJobsUseCase
    implements UseCaseWithParams<List<JobEntity>, GetJobsParams> {
  final JobsRepository repository;

  const GetJobsUseCase({required this.repository});

  @override
  ResultFuture<List<JobEntity>> call(GetJobsParams params) =>
      repository.getJobs(params);
}

class GetJobsParams extends Equatable {
  final String? search;
  final String? jobType;
  final String? experienceLevel;
  final int limit;
  final int page;

  const GetJobsParams({
    this.search,
    this.jobType,
    this.experienceLevel,
    this.limit = 20,
    this.page = 1,
  });

  @override
  List<Object?> get props => [search, jobType, experienceLevel, limit, page];
}
