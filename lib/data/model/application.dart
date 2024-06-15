import 'package:winwin/data/model/candidate.dart';

class Application {
  Application({
    required this.applicationId,
    required this.candidateId,
    required this.jobPositionId,
    required this.status,
    this.candidate,
  });

  String applicationId;
  String candidateId;
  String jobPositionId;
  String status;
  Candidate? candidate;

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      applicationId: json['application_id'],
      candidateId: json['candidate_id'],
      jobPositionId: json['job_position_id'],
      status: json['status'],
      candidate: json['candidate'] != null ? Candidate.fromJson(json['candidate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'application_id': applicationId,
      'candidate_id': candidateId,
      'job_position_id': jobPositionId,
      'status': status,
      'candidate': candidate?.toJson(),
    };
  }

  @override
  String toString() {
    return 'Application(applicationId: $applicationId, candidateId: $candidateId, jobPositionId: $jobPositionId, status: $status, candidate: $candidate)';
  }
}