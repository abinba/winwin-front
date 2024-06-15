class Candidate {
  Candidate({
    required this.candidateId,
    required this.firstName,
    required this.lastName,
  });

  String candidateId;
  String firstName;
  String lastName;

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      candidateId: json['candidate_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'candidate_id': candidateId,
      'first_name': firstName,
      'last_name': lastName,
    };
  }

  @override
  String toString() {
    return 'Candidate(candidateId: $candidateId, firstName: $firstName, lastName: $lastName)';
  }
}