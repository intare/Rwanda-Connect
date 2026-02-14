/// Environment configuration for the app.
/// Change these values based on your deployment environment.
abstract final class EnvConfig {
  /// Production API base URL
  static const String productionApiUrl = 'http://72.62.90.190:8080/api';

  /// Development API base URL (for local development)
  /// - Android emulator: http://10.0.2.2:3000/api
  /// - iOS simulator/web: http://localhost:3000/api
  static const String developmentApiUrl = 'http://10.0.2.2:3000/api';

  /// Set to true for production, false for local development
  static const bool isProduction = true;

  /// Get the current API base URL based on environment
  static String get apiBaseUrl => isProduction ? productionApiUrl : developmentApiUrl;
}
