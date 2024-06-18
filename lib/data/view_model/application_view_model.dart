import 'package:flutter/material.dart';
import 'package:winwin/data/model/application.dart';
import 'package:winwin/data/repository/application_repository.dart';

class ApplicationViewModel extends ChangeNotifier {
  final ApplicationRepository applicationRepository;

  ApplicationViewModel({required this.applicationRepository});

  List<Application> _applications = [];
  List<Application> get applications => _applications;

  List<Application> _selectedApplications = [];
  List<Application> get selectedApplications => _selectedApplications;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<Application?> apply(String candidateId, String jobPositionId) async {
    _isLoading = true;
    notifyListeners();

    final result =
        await applicationRepository.apply(candidateId, jobPositionId);
    Application? application;
    result.fold(
      (failure) {
        _errorMessage = failure.toString();
      },
      (fetchedApplication) {
        application = fetchedApplication;
      },
    );

    _isLoading = false;
    notifyListeners();
    return application;
  }

  Future<void> filterApplications(String candidateId, String? statusId) async {
    _isLoading = true;
    notifyListeners();

    _applications = [];
    for (var application in selectedApplications) {
      if (application.candidateId == candidateId &&
          application.status == statusId || statusId == null) {
        _applications.add(application);
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchCandidateApplications(
      String candidateId, String? statusId) async {
    _isLoading = true;
    notifyListeners();

    final result = await applicationRepository.getCandidateApplications(
        candidateId, statusId);
    result.fold(
      (failure) {
        _errorMessage = failure.toString();
      },
      (applicationListResponseModel) {
        _selectedApplications = applicationListResponseModel.applications;
        _applications = applicationListResponseModel.applications;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchJobPositionApplications(String jobPositionId) async {
    _isLoading = true;
    notifyListeners();

    final result =
        await applicationRepository.getJobPositionApplications(jobPositionId);
    result.fold(
      (failure) {
        _errorMessage = failure.toString();
      },
      (applicationListResponseModel) {
        _applications = applicationListResponseModel.applications;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<Application?> fetchApplication(int applicationId) async {
    _isLoading = true;
    notifyListeners();

    final result = await applicationRepository.getApplication(applicationId);
    Application? application;
    result.fold(
      (failure) {
        _errorMessage = failure.toString();
      },
      (fetchedApplication) {
        application = fetchedApplication;
      },
    );

    _isLoading = false;
    notifyListeners();
    return application;
  }
}
