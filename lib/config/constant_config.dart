class ConstantConfig {
  final String apiKey =
      '123';

  String getApiKey({
    String? environment,}) {
    switch (environment) {
      case 'testing':
        return 'test-api-key';
      case 'development':
        return apiKey;
      case 'production':
        return apiKey;
      default:
        return apiKey;
    }
  }
}