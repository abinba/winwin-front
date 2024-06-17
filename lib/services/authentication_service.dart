import 'package:flutter/material.dart';
import 'package:winwin/providers/candidate_provider.dart';
import 'package:winwin/services/restclient.dart';
import 'package:winwin/data/model/candidate.dart';
import 'package:provider/provider.dart';

class AuthService {
  final RestClient _restClient;

  AuthService(this._restClient);

  Future<bool> login(
      BuildContext context, String email, String password) async {
    final response = await _restClient.post('/api/v1/login_method/login', {
      'email': email,
      'password': password,
      'role': 'candidate',
    });

    if (response.networkServiceResponse.success) {
      final data = response.mappedResult;
      if (data['message'] != 'success') {
        print(data['message']);
        return false;
      }
      final candidate = Candidate.fromJson(data['candidate']);
      final token = data['token'];
      Provider.of<CandidateProvider>(context, listen: false)
          .setCandidate(candidate, token);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> register(BuildContext context, String email, String password,
      String firstName, String lastName) async {
    final response = await _restClient.post('/api/v1/login_method/', {
      'email': email,
      'password': password,
      'role': 'candidate',
      'first_name': firstName,
      'last_name': lastName,
    });

    if (response.networkServiceResponse.success) {
      final data = response.mappedResult;
      if (!data.containsKey("candidate")) {
        return false;
      }
      return true;
    } else {
      return false;
    }
  }
}
