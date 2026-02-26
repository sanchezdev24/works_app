import 'package:equatable/equatable.dart';

class JobEntity extends Equatable {
  final int id;
  final String url;
  final String title;
  final String company;
  final String companyLogo;
  final String category;
  final String jobType;
  final String publicationDate;
  final String candidateRequiredLocation;
  final String salary;
  final String description;
  final List<String> tags;

  const JobEntity({
    required this.id,
    required this.url,
    required this.title,
    required this.company,
    required this.companyLogo,
    required this.category,
    required this.jobType,
    required this.publicationDate,
    required this.candidateRequiredLocation,
    required this.salary,
    required this.description,
    required this.tags,
  });

  @override
  List<Object?> get props => [
        id,
        url,
        title,
        company,
        companyLogo,
        category,
        jobType,
        publicationDate,
        candidateRequiredLocation,
        salary,
        description,
        tags,
      ];
}
