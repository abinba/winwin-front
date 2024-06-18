import 'package:flutter/material.dart';
import 'package:winwin/data/model/job_position.dart';
import 'package:winwin/data/repository/job_position_repository.dart';

class JobPositionViewModel extends ChangeNotifier {
  final JobPositionRepository jobPositionRepository;

  JobPositionViewModel({required this.jobPositionRepository});

  List<JobPosition> _jobPositions = [];
  List<JobPosition> get jobPositions => _jobPositions;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchRecommendedJobPositions(String? candidateId) async {
    if (_jobPositions.isEmpty) {
      _isLoading = true;
      notifyListeners();

      final result = await jobPositionRepository.getRecommendedJobPositions(
          candidateId: candidateId);
      result.fold(
        (failure) {
          _errorMessage = failure.toString();
        },
        (jobPositionListResponseModel) {
          _jobPositions = jobPositionListResponseModel.jobPositions;
        },
      );

      _isLoading = false;
      notifyListeners();
    }
  }
}

class SingleJobPositionViewModel extends ChangeNotifier {
  final JobPositionRepository jobPositionRepository;

  SingleJobPositionViewModel({required this.jobPositionRepository});

  JobPosition? _jobPosition;
  JobPosition? get jobPosition => _jobPosition;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchJobPosition(String jobPositionId) async {
    if (_jobPosition == null) {
      _isLoading = true;
      notifyListeners();

      final result = await jobPositionRepository.getJobPosition(jobPositionId);
      result.fold(
        (failure) {
          _errorMessage = failure.toString();
        },
        (jobPosition) {
          _jobPosition = jobPosition;
        },
      );

      _isLoading = false;
      notifyListeners();
    }
  }
}
