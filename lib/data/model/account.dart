class Account {
  Account({
    required this.accountId,
    required this.email,
    required this.role,
  });

  String accountId;
  String email;
  String role;

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      accountId: json['account_id'],
      email: json['email'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_id': accountId,
      'email': email,
      'role': role,
    };
  }

  @override
  String toString() {
    return 'Account(accountId: $accountId, email: $email, role: $role)';
  }
}
