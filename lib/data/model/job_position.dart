import 'package:winwin/data/model/application.dart';
import 'package:winwin/data/model/company.dart';
import 'package:winwin/data/model/job_position_language.dart';
import 'package:winwin/data/model/job_position_skill.dart';
import 'package:winwin/data/model/language.dart';
import 'package:winwin/data/model/representative.dart';
import 'package:winwin/data/model/skill.dart';

class JobPositionListResponseModel {
  JobPositionListResponseModel({
    required this.jobPositions,
  });

  List<JobPosition> jobPositions;

  factory JobPositionListResponseModel.fromJson(List<dynamic> json) {
    List<JobPosition> jobPositions = [];
    for (var jobPosition in json) {
      jobPositions.add(JobPosition.fromJson(jobPosition));
    }
    return JobPositionListResponseModel(jobPositions: jobPositions);
  }

  Map<String, dynamic> toJson() {
    return {
      'job_positions': jobPositions.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() => 'JobPositionList(jobPositions: $jobPositions)';
}

class JobPosition {
  JobPosition({
    required this.id,
    required this.title,
    required this.location,
    required this.workTime,
    required this.contractType,
    required this.experience,
    required this.salaryStart,
    required this.salaryEnd,
    required this.salaryCurrency,
    required this.description,
    required this.verified,
    this.company,
    required this.skills,
    required this.languages,
    required this.representative,
    required this.applications,
  });

  String id;
  String title;
  String location;
  String workTime; // ENUM values like "full_time", "part_time", etc.
  String contractType; // ENUM values like "permanent", "contract", etc.
  int experience;
  int salaryStart;
  int salaryEnd;
  String salaryCurrency;
  String description;
  bool verified;
  Company? company;
  List<JobPositionSkill> skills;
  List<JobPositionLanguage> languages;
  Representative representative;
  List<Application> applications;

  factory JobPosition.fromJson(Map<String, dynamic> json) {
    return JobPosition(
      id: json['job_position_id'],
      title: json['job_title'],
      location: json['location'],
      workTime: json['work_time'],
      contractType: json['contract_type'],
      experience: json['experience'],
      salaryStart: json['salary_start'],
      salaryEnd: json['salary_end'],
      salaryCurrency: json['salary_currency'],
      description: json['description'],
      verified: json['verified'],
      company: json['company'] != null ? Company.fromJson(json['company']) : null,
      skills: (json['skills'] as List).map((i) => JobPositionSkill.fromJson(i)).toList(),
      languages: (json['languages'] as List).map((i) => JobPositionLanguage.fromJson(i)).toList(),
      representative: Representative.fromJson(json['representative']),
      applications: (json['applications'] as List).map((i) => Application.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'work_time': workTime,
      'contract_type': contractType,
      'experience': experience,
      'salary_start': salaryStart,
      'salary_end': salaryEnd,
      'salary_currency': salaryCurrency,
      'description': description,
      'verified': verified,
      'company': company?.toJson(),
      'skills': skills.map((e) => e.toJson()).toList(),
      'languages': languages.map((e) => e.toJson()).toList(),
      'representative': representative.toJson(),
      'applications': applications.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'JobPosition(id: $id, title: $title, location: $location, workTime: $workTime, contractType: $contractType, experience: $experience, salaryStart: $salaryStart, salaryEnd: $salaryEnd, salaryCurrency: $salaryCurrency, description: $description, verified: $verified, company: $company, skills: $skills, languages: $languages, representative: $representative, applications: $applications)';
  }
}