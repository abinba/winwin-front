class Language {
  Language({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      id: json['language_id'],
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
    return 'Language(id: $id, name: $name)';
  }
}