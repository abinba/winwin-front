class Candidate {
  Candidate({
    required this.candidateId,
    required this.accountId,
    required this.firstName,
    required this.lastName,
    this.title,
    this.availability,
    this.salaryStart,
    this.salaryEnd,
    this.salaryCurrency,
    this.location,
    this.phoneNumber,
    this.birthDate,
    this.profilePicture,
    this.linkedinLink,
    this.githubLink,
    this.website,
    this.aboutMe,
  });

  String candidateId;
  String accountId;
  String firstName;
  String lastName;
  String? title;
  String? availability;
  int? salaryStart;
  int? salaryEnd;
  String? salaryCurrency;
  String? location;
  String? phoneNumber;
  DateTime? birthDate;
  String? profilePicture;
  String? linkedinLink;
  String? githubLink;
  String? website;
  String? aboutMe;

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      candidateId: json['candidate_id'],
      accountId: json['account_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      title: json['title'],
      availability: json['availability'],
      salaryStart: json['salary_start'],
      salaryEnd: json['salary_end'],
      salaryCurrency: json['salary_currency'],
      location: json['location'],
      phoneNumber: json['phone_number'],
      birthDate: json['birth_date'] != null ? DateTime.parse(json['birth_date']) : null,
      profilePicture: json['profile_picture'],
      linkedinLink: json['linkedin_link'],
      githubLink: json['github_link'],
      website: json['website'],
      aboutMe: json['about_me'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'candidate_id': candidateId,
      'account_id': accountId,
      'first_name': firstName,
      'last_name': lastName,
      'title': title,
      'availability': availability,
      'salary_start': salaryStart,
      'salary_end': salaryEnd,
      'salary_currency': salaryCurrency,
      'location': location,
      'phone_number': phoneNumber,
      'birth_date': birthDate?.toIso8601String(),
      'profile_picture': profilePicture,
      'linkedin_link': linkedinLink,
      'github_link': githubLink,
      'website': website,
      'about_me': aboutMe,
    };
  }

  @override
  String toString() {
    return 'Candidate(candidateId: $candidateId, accountId: $accountId, firstName: $firstName, lastName: $lastName, title: $title, availability: $availability, salaryStart: $salaryStart, salaryEnd: $salaryEnd, salaryCurrency: $salaryCurrency, location: $location, phoneNumber: $phoneNumber, birthDate: $birthDate, profilePicture: $profilePicture, linkedinLink: $linkedinLink, githubLink: $githubLink, website: $website, aboutMe: $aboutMe)';
  }
}
