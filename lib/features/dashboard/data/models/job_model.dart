

import 'package:works_app/features/dashboard/domain/entities/job_entity.dart';

class JobModel extends JobEntity {
  const JobModel({
    required super.id,
    required super.url,
    required super.title,
    required super.company,
    required super.companyLogo,
    required super.category,
    required super.jobType,
    required super.publicationDate,
    required super.candidateRequiredLocation,
    required super.salary,
    required super.description,
    required super.tags,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'] as int? ?? 0,
      url: json['url'] as String? ?? '',
      title: json['title'] as String? ?? '',
      company: json['company_name'] as String? ?? '',
      companyLogo: json['company_logo'] as String? ?? '',
      category: json['category'] as String? ?? '',
      jobType: json['job_type'] as String? ?? '',
      publicationDate: json['publication_date'] as String? ?? '',
      candidateRequiredLocation:
          json['candidate_required_location'] as String? ?? '',
      salary: json['salary'] as String? ?? '',
      description: json['description'] as String? ?? '',
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'title': title,
      'company_name': company,
      'company_logo': companyLogo,
      'category': category,
      'job_type': jobType,
      'publication_date': publicationDate,
      'candidate_required_location': candidateRequiredLocation,
      'salary': salary,
      'description': description,
      'tags': tags,
    };
  }

  JobEntity toEntity() => JobEntity(
        id: id,
        url: url,
        title: title,
        company: company,
        companyLogo: companyLogo,
        category: category,
        jobType: jobType,
        publicationDate: publicationDate,
        candidateRequiredLocation: candidateRequiredLocation,
        salary: salary,
        description: description,
        tags: tags,
      );
}
