import 'package:get_it/get_it.dart';
import 'package:works_app/core/network/api_client.dart';
import 'package:works_app/features/dashboard/data/datasources/jobs_remote_datasource.dart';
import 'package:works_app/features/dashboard/data/repositories/jobs_repository_impl.dart';
import 'package:works_app/features/dashboard/domain/repositories/jobs_repository.dart';
import 'package:works_app/features/dashboard/domain/usecases/get_jobs_usecase.dart';
import 'package:works_app/features/dashboard/presentation/bloc/dashboard_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  _registerCore();
  _registerDashboardFeature();
}

void _registerCore() {
  // Network
  sl.registerLazySingleton<ApiClient>(() => ApiClient());
}

void _registerDashboardFeature() {
  // BLoC (factory = new instance per BlocProvider)
  sl.registerFactory<DashboardBloc>(
    () => DashboardBloc(getJobsUseCase: sl()),
  );

  // Use Cases
  sl.registerLazySingleton<GetJobsUseCase>(
    () => GetJobsUseCase(repository: sl()),
  );

  // Repository
  sl.registerLazySingleton<JobsRepository>(
    () => JobsRepositoryImpl(remoteDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<JobsRemoteDataSource>(
    () => MockJobsRemoteDataSourceImpl(),
  );
}
