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
  ResultFuture<List<JobEntity>> getJobs(GetJobsParams params) => TaskEither.tryCatch(() async {
    return remoteDataSource.getJobs(category: params.category, search: params.search, limit: params.limit, offset: params.offset);
  }, 
  (error, StackTrace) {
    if (error is DioException) {
    return UnexpectedFailure('UnexpectedFailure error: $error');
    } else {
      return UnexpectedFailure('UnexpectedFailure error: $error');
    }
  });

  
}
