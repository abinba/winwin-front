import 'package:winwin/data/model/language.dart';

class JobPositionLanguage {
  JobPositionLanguage({
    required this.jobPositionId,
    required this.language,
  });

  String jobPositionId;
  Language? language;

  factory JobPositionLanguage.fromJson(Map<String, dynamic> json) {
    return JobPositionLanguage(
      jobPositionId: json['job_position_id'],
      language:
          json['language'] != null ? Language.fromJson(json['language']) : null,
    );
  }

  String? getLanguage() {
    return language?.name;
  }

  Map<String, dynamic> toJson() {
    return {
      'jobPositionId': jobPositionId,
      'language': language,
    };
  }

  @override
  String toString() {
    return 'Skill(id: $jobPositionId, name: $language)';
  }
}
