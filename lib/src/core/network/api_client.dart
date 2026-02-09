import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'api_endpoints.dart';
import 'api_interceptors.dart';

/// Provider for FlutterSecureStorage.
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );
});

/// Provider for the configured Dio instance.
final dioProvider = Provider<Dio>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Add interceptors in order
  dio.interceptors.addAll([
    AuthInterceptor(secureStorage),
    ErrorInterceptor(),
    LoggingInterceptor(),
  ]);

  return dio;
});

/// API client wrapper for making HTTP requests.
/// Provides typed methods and standardized error handling.
class ApiClient {
  ApiClient(this._dio);

  final Dio _dio;

  /// Perform a GET request.
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    final response = await _dio.get<dynamic>(
      path,
      queryParameters: queryParameters,
    );
    return ApiResponse.fromResponse(response, fromJson);
  }

  /// Perform a POST request.
  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    final response = await _dio.post<dynamic>(
      path,
      data: data,
      queryParameters: queryParameters,
    );
    return ApiResponse.fromResponse(response, fromJson);
  }

  /// Perform a PATCH request.
  Future<ApiResponse<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    final response = await _dio.patch<dynamic>(
      path,
      data: data,
      queryParameters: queryParameters,
    );
    return ApiResponse.fromResponse(response, fromJson);
  }

  /// Perform a DELETE request.
  Future<ApiResponse<T>> delete<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    final response = await _dio.delete<dynamic>(
      path,
      queryParameters: queryParameters,
    );
    return ApiResponse.fromResponse(response, fromJson);
  }
}

/// Provider for the API client.
final apiClientProvider = Provider<ApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiClient(dio);
});

/// Standardized API response wrapper.
/// Handles both Payload CMS list responses and single document responses.
class ApiResponse<T> {
  const ApiResponse({
    required this.data,
    this.meta,
    this.error,
  });

  final T? data;
  final PaginationMeta? meta;
  final ApiError? error;

  bool get isSuccess => error == null && data != null;
  bool get isError => error != null;

  /// Parse a Payload CMS response.
  /// For list endpoints: { docs: [...], totalDocs, page, limit, ... }
  /// For single doc endpoints: { id, ...fields }
  factory ApiResponse.fromResponse(
    Response response,
    T Function(dynamic)? fromJson,
  ) {
    final body = response.data;
    if (body == null) {
      return const ApiResponse(data: null);
    }

    // Check if this is a Payload list response (has 'docs' key)
    if (body is Map<String, dynamic> && body.containsKey('docs')) {
      final docs = body['docs'];
      return ApiResponse(
        data: fromJson != null ? fromJson(docs) : docs as T?,
        meta: PaginationMeta.fromPayload(body),
      );
    }

    // Single document or other response
    return ApiResponse(
      data: fromJson != null ? fromJson(body) : body as T?,
      meta: null,
    );
  }

  /// Create a response for list data with pagination.
  factory ApiResponse.list({
    required T data,
    required PaginationMeta meta,
  }) {
    return ApiResponse(data: data, meta: meta);
  }
}

/// API Error details.
class ApiError {
  const ApiError({
    required this.message,
    this.code,
    this.errors,
  });

  final String message;
  final String? code;
  final List<Map<String, dynamic>>? errors;

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      message: json['message'] as String? ?? 'Unknown error',
      code: json['code'] as String?,
      errors: (json['errors'] as List<dynamic>?)
          ?.cast<Map<String, dynamic>>(),
    );
  }
}

/// Pagination metadata from Payload CMS responses.
class PaginationMeta {
  const PaginationMeta({
    required this.page,
    required this.limit,
    required this.totalDocs,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPrevPage,
    this.nextPage,
    this.prevPage,
  });

  final int page;
  final int limit;
  final int totalDocs;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPrevPage;
  final int? nextPage;
  final int? prevPage;

  // Convenience getters for compatibility
  int get total => totalDocs;
  bool get hasNext => hasNextPage;
  bool get hasPrev => hasPrevPage;

  /// Parse from Payload CMS list response.
  factory PaginationMeta.fromPayload(Map<String, dynamic> json) {
    return PaginationMeta(
      page: json['page'] as int? ?? 1,
      limit: json['limit'] as int? ?? 10,
      totalDocs: json['totalDocs'] as int? ?? 0,
      totalPages: json['totalPages'] as int? ?? 1,
      hasNextPage: json['hasNextPage'] as bool? ?? false,
      hasPrevPage: json['hasPrevPage'] as bool? ?? false,
      nextPage: json['nextPage'] as int?,
      prevPage: json['prevPage'] as int?,
    );
  }

  /// Legacy factory for backwards compatibility.
  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta.fromPayload(json);
  }
}
