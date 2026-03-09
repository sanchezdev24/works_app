import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:works_app/core/error/failures.dart';
import 'package:works_app/core/utils/typedefs.dart';
import 'package:works_app/features/dashboard/data/datasources/jobs_remote_datasource.dart';
import 'package:works_app/features/dashboard/domain/entities/job_entity.dart';
import 'package:works_app/features/dashboard/domain/repositories/jobs_repository.dart';
import 'package:works_app/features/dashboard/domain/usecases/get_jobs_usecase.dart';

class JobsRepositoryImpl implements JobsRepository {
  final JobsRemoteDataSource remoteDataSource;

  const JobsRepositoryImpl({required this.remoteDataSource});

  @override
  ResultFuture<List<JobEntity>> getJobs(GetJobsParams params) =>
      TaskEither.tryCatch(
        () async => remoteDataSource.getJobs(
          search: params.search,
          jobType: params.jobType,
          experienceLevel: params.experienceLevel,
          page: params.page,
          limit: params.limit,
        ),
        (error, _) {
          if (error is DioException) {
            return UnexpectedFailure('network_error', message: error.message);
          }
          return UnexpectedFailure('unexpected_error', message: error.toString());
        },
      );
}
