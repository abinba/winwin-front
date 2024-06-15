import 'package:winwin/data/model/job_position.dart';

class ApplicationListResponseModel {
  ApplicationListResponseModel({
    required this.applications,
  });

  List<Application> applications;

  factory ApplicationListResponseModel.fromJson(List<dynamic> json) {
    List<Application> applications = [];
    for (var application in json) {
      applications.add(Application.fromJson(application));
    }
    return ApplicationListResponseModel(applications: applications);
  }

  Map<String, dynamic> toJson() {
    return {
      'applications': applications.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() => 'ApplicationList(applications: $applications)';
}

class Application {
  Application({
    required this.applicationId,
    required this.candidateId,
    required this.jobPositionId,
    required this.status,
    this.jobPosition,
  });

  String applicationId;
  String candidateId;
  String jobPositionId;
  String status;
  JobPosition? jobPosition;

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      applicationId: json['application_id'],
      candidateId: json['candidate_id'],
      jobPositionId: json['job_position_id'],
      status: json['status'],
      jobPosition: json['job_position'] != null ? JobPosition.fromJson(json['job_position']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'application_id': applicationId,
      'candidate_id': candidateId,
      'job_position_id': jobPositionId,
      'status': status,
      'job_position': jobPosition?.toJson(),
    };
  }

  @override
  String toString() {
    return 'Application(applicationId: $applicationId, candidateId: $candidateId, jobPositionId: $jobPositionId, status: $status, jobPosition: $jobPosition)';
  }
}
