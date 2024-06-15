import 'package:winwin/data/model/account.dart';
import 'package:winwin/data/model/company.dart';

class Representative {
  Representative({
    required this.representativeId,
    required this.accountId,
    required this.companyId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.company,
    this.account,
  });

  String representativeId;
  String accountId;
  String companyId;
  String firstName;
  String lastName;
  String phoneNumber;
  Company? company;
  Account? account;

  factory Representative.fromJson(Map<String, dynamic> json) {
    return Representative(
      representativeId: json['representative_id'],
      accountId: json['account_id'],
      companyId: json['company_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      company: json['company'] != null ? Company.fromJson(json['company']) : null,
      account: json['account'] != null ? Account.fromJson(json['account']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'representative_id': representativeId,
      'account_id': accountId,
      'company_id': companyId,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'company': company?.toJson(),
      'account': account?.toJson(),
    };
  }

  @override
  String toString() {
    return 'Representative(representativeId: $representativeId, accountId: $accountId, companyId: $companyId, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, company: $company, account: $account)';
  }
}