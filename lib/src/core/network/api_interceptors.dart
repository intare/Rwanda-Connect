import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Key for storing the auth token in secure storage.
const String _tokenKey = 'auth_token';

/// Interceptor that adds JWT token to requests.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _secureStorage.read(key: _tokenKey);
    if (token != null) {
      options.headers['Authorization'] = 'JWT $token';
    }
    handler.next(options);
  }
}

/// Interceptor for logging requests and responses in debug mode.
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('┌── Request ──────────────────────────────────────');
      debugPrint('│ ${options.method} ${options.uri}');
      if (options.headers.isNotEmpty) {
        debugPrint('│ Headers: ${options.headers}');
      }
      if (options.data != null) {
        debugPrint('│ Body: ${options.data}');
      }
      debugPrint('└─────────────────────────────────────────────────');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('┌── Response ─────────────────────────────────────');
      debugPrint('│ ${response.statusCode} ${response.requestOptions.uri}');
      debugPrint('│ Data: ${response.data}');
      debugPrint('└─────────────────────────────────────────────────');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('┌── Error ────────────────────────────────────────');
      debugPrint('│ ${err.type} ${err.requestOptions.uri}');
      debugPrint('│ Message: ${err.message}');
      if (err.response?.data != null) {
        debugPrint('│ Response: ${err.response?.data}');
      }
      debugPrint('└─────────────────────────────────────────────────');
    }
    handler.next(err);
  }
}

/// Interceptor for handling common API errors.
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Transform API errors into more usable format
    final response = err.response;
    if (response != null) {
      final data = response.data;
      if (data is Map<String, dynamic> && data['error'] != null) {
        final error = data['error'];
        final code = error['code'] as String?;
        final message = error['message'] as String?;

        // Create a more descriptive error
        handler.next(
          DioException(
            requestOptions: err.requestOptions,
            response: err.response,
            type: err.type,
            error: ApiError(
              code: code ?? 'unknown',
              message: message ?? 'An error occurred',
            ),
          ),
        );
        return;
      }
    }
    handler.next(err);
  }
}

/// Represents an API error response.
class ApiError implements Exception {
  const ApiError({required this.code, required this.message});

  final String code;
  final String message;

  @override
  String toString() => 'ApiError($code): $message';

  /// Check if error is authentication related.
  bool get isAuthError =>
      code == 'auth_invalid_credentials' ||
      code == 'auth_unauthorized' ||
      code == 'auth_email_in_use';

  /// Check if error is validation related.
  bool get isValidationError => code == 'validation_error';

  /// Check if error is not found.
  bool get isNotFound => code == 'not_found';

  /// Check if error is rate limited.
  bool get isRateLimited => code == 'rate_limited';

  /// Check if error is server error.
  bool get isServerError => code == 'server_error';
}
