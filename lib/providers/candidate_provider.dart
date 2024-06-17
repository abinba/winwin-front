import 'package:flutter/material.dart';
import 'package:winwin/data/model/candidate.dart';

class CandidateProvider extends ChangeNotifier {
  Candidate? _candidate;
  String? _token;

  Candidate? get candidate => _candidate;
  String? get token => _token;

  void setCandidate(Candidate candidate, String token) {
    _candidate = candidate;
    _token = token;
    notifyListeners();
  }

  void clearCandidate() {
    _candidate = null;
    _token = null;
    notifyListeners();
  }
}
