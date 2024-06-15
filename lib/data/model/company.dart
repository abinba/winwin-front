class Company {
  Company({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['company_id'],
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
    return 'Company(id: $id, name: $name)';
  }
}