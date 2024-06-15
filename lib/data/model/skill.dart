class Skill {
  Skill({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['skill_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'Skill(id: $id, name: $name)';
  }
}