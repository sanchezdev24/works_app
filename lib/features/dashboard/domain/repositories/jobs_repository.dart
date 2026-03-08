import 'package:works_app/core/utils/typedefs.dart';
import 'package:works_app/features/dashboard/domain/entities/job_entity.dart';
import 'package:works_app/features/dashboard/domain/usecases/get_jobs_usecase.dart';

abstract class JobsRepository {
  ResultFuture<List<JobEntity>> getJobs(GetJobsParams params);
}
