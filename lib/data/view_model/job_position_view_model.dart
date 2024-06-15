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
