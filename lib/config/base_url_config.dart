class BaseUrlConfig {
  final String baseHostTesting = 'localhost:8000';
  final String baseHostDevelopment =
      'localhost:8000';
  final String baseHostProduction = 'hearplayaudio.pl';

  String getHost({environment = 'development'}) {
    switch (environment) {
      case 'testing':
        return baseHostTesting;
      case 'development':
        return baseHostDevelopment;
      case 'production':
        return baseHostProduction;
      default:
        return baseHostDevelopment;
    }
  }
}