import 'package:flutter/foundation.dart';

/// Environment configuration for the app.
abstract final class EnvConfig {
  /// API base URL. Override via --dart-define=RWANDA_CONNECT_API_BASE_URL=...
  static const String _apiBaseUrl = String.fromEnvironment(
    'RWANDA_CONNECT_API_BASE_URL',
    defaultValue: 'https://rwandaconnect.cloud/api',
  );

  /// Current API base URL.
  static String get apiBaseUrl {
    final uri = Uri.parse(_apiBaseUrl);
    if (kReleaseMode && uri.scheme != 'https') {
      throw StateError('Release builds must use HTTPS API URL.');
    }
    return _apiBaseUrl;
  }
}
