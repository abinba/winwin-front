import 'package:winwin/data/model/skill.dart';

class JobPositionSkill {
  JobPositionSkill({
    required this.jobPositionId,
    required this.skill,
  });

  String jobPositionId;
  Skill? skill;

  factory JobPositionSkill.fromJson(Map<String, dynamic> json) {
    return JobPositionSkill(
      jobPositionId: json['job_position_id'],
      skill: json['skill'] != null ? Skill.fromJson(json['skill']) : null,
    );
  }

  String? getSkill() {
    return skill?.name;
  }

  Map<String, dynamic> toJson() {
    return {
      'jobPositionId': jobPositionId,
      'skill': skill,
    };
  }

  @override
  String toString() {
    return 'Skill(id: $jobPositionId, name: $skill)';
  }
}
