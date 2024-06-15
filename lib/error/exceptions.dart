abstract class FetchException implements Exception {
  const FetchException([this.message]);

  final String? message;

  @override
  String toString() {
    String result = 'FetchException';
    if (message is String) return '$result: $message';
    return result;
  }
}

class JobPositionFetchException extends FetchException {
  const JobPositionFetchException([String? message]) : super(message);
}

class RegisterException extends FetchException {
  const RegisterException([String? message]) : super(message);
}

class SettingsFetchException extends FetchException {
  const SettingsFetchException([String? message]) : super(message);
}
