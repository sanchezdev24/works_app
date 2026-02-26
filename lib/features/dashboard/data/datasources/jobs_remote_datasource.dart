import 'package:dio/dio.dart';
import 'package:works_app/core/error/exceptions.dart';
import 'package:works_app/core/network/api_client.dart';
import 'package:works_app/core/network/endpoints.dart';
import 'package:works_app/features/dashboard/data/models/job_model.dart';

abstract class JobsRemoteDataSource {
  Future<List<JobModel>> getJobs({
    String? category,
    String? search,
    int limit = 20,
    int offset = 0,
  });
}

class JobsRemoteDataSourceImpl implements JobsRemoteDataSource {
  final ApiClient apiClient;

  const JobsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<JobModel>> getJobs({
    String? category,
    String? search,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'limit': limit,
        'offset': offset,
        if (category != null && category.isNotEmpty) 'category': category,
        if (search != null && search.isNotEmpty) 'search': search,
      };

      final response = await apiClient.get(
        Endpoints.jobs,
        queryParameters: queryParams,
      );

      final data = response.data as Map<String, dynamic>;
      final jobs = data['jobs'] as List<dynamic>;

      return jobs
          .map((json) => JobModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final message = e.message ?? 'Error de red';

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw const NetworkException(
            message: 'No se pudo conectar al servidor. Verifica tu internet.');
      }

      throw ServerException(message: message, statusCode: statusCode);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
  
}

class MockJobsRemoteDataSourceImpl implements JobsRemoteDataSource {
  @override
  Future<List<JobModel>> getJobs({String? category, String? search, int limit = 20, int offset = 0}) async {
    Future.delayed(const Duration(seconds: 2));
    return [JobModel(id: 1, url: 'url', title: 'title', company: 'company', companyLogo: 'companyLogo', category: 'category', jobType: 'jobType', publicationDate: 'publicationDate', candidateRequiredLocation: 'candidateRequiredLocation', salary: 'salary', description: 'description', tags: [''])];
  }

}
