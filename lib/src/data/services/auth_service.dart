import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../models/auth/auth_models.dart';

/// Exception thrown for authentication errors.
class AuthException implements Exception {
  const AuthException(this.message);
  final String message;

  @override
  String toString() => message;
}

/// Service for making auth-related API calls using Payload CMS.
class AuthService {
  AuthService(this._dio, this._secureStorage);

  final Dio _dio;
  final FlutterSecureStorage _secureStorage;

  static const _tokenKey = 'auth_token';
  static const _userIdKey = 'user_id';

  /// Login with email and password.
  Future<AuthResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.login,
        data: {
          'email': request.email,
          'password': request.password,
        },
      );

      final data = response.data;
      if (data == null) {
        throw const AuthException('Login failed. Please check your credentials.');
      }

      final token = data['token'] as String?;
      final userData = data['user'] as Map<String, dynamic>?;

      if (token == null || userData == null) {
        throw const AuthException('Login failed. Invalid response from server.');
      }

      // Store token securely
      await _secureStorage.write(key: _tokenKey, value: token);
      await _secureStorage.write(key: _userIdKey, value: userData['id'].toString());

      return AuthResponse(
        token: token,
        user: UserDto.fromJson(userData),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw const AuthException('Invalid email or password.');
      }
      throw AuthException(e.message ?? 'Login failed. Please try again.');
    }
  }

  /// Register a new user.
  Future<AuthResponse> register(RegisterRequest request) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.register,
        data: {
          'email': request.email,
          'password': request.password,
          'name': request.name,
        },
      );

      final data = response.data;
      if (data == null) {
        throw const AuthException('Registration failed. Please try again.');
      }

      // Payload returns the created user, now log them in
      return login(LoginRequest(
        email: request.email,
        password: request.password,
      ));
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        final errors = e.response?.data?['errors'] as List<dynamic>?;
        if (errors != null && errors.isNotEmpty) {
          final firstError = errors.first as Map<String, dynamic>;
          throw AuthException(firstError['message'] as String? ?? 'Registration failed.');
        }
      }
      throw AuthException(e.message ?? 'Registration failed. Please try again.');
    }
  }

  /// Logout the current user.
  Future<void> logout() async {
    try {
      final token = await _secureStorage.read(key: _tokenKey);
      if (token != null) {
        await _dio.post(
          ApiEndpoints.logout,
          options: Options(
            headers: {'Authorization': 'JWT $token'},
          ),
        );
      }
    } catch (_) {
      // Ignore logout errors
    } finally {
      await _secureStorage.delete(key: _tokenKey);
      await _secureStorage.delete(key: _userIdKey);
    }
  }

  /// Get current user profile.
  Future<UserDto> getCurrentUser() async {
    final token = await _secureStorage.read(key: _tokenKey);
    if (token == null) {
      throw const AuthException('Not authenticated.');
    }

    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.me,
        options: Options(
          headers: {'Authorization': 'JWT $token'},
        ),
      );

      final data = response.data;
      if (data == null) {
        throw const AuthException('Failed to fetch user profile.');
      }

      // Payload returns { user: {...} } for /users/me
      final userData = data['user'] as Map<String, dynamic>? ?? data;
      return UserDto.fromJson(userData);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await _secureStorage.delete(key: _tokenKey);
        await _secureStorage.delete(key: _userIdKey);
        throw const AuthException('Session expired. Please login again.');
      }
      throw AuthException(e.message ?? 'Failed to fetch user profile.');
    }
  }

  /// Update user profile.
  Future<UserDto> updateProfile({
    String? name,
    String? location,
    List<String>? interests,
    bool? onboardingCompleted,
  }) async {
    final token = await _secureStorage.read(key: _tokenKey);
    final userId = await _secureStorage.read(key: _userIdKey);

    if (token == null || userId == null) {
      throw const AuthException('Not authenticated.');
    }

    final updates = <String, dynamic>{};
    if (name != null) updates['name'] = name;
    if (location != null) updates['location'] = location;
    if (interests != null) updates['interests'] = interests;
    if (onboardingCompleted != null) {
      updates['onboardingCompleted'] = onboardingCompleted;
    }

    try {
      final response = await _dio.patch<Map<String, dynamic>>(
        '${ApiEndpoints.register}/$userId',
        data: updates,
        options: Options(
          headers: {'Authorization': 'JWT $token'},
        ),
      );

      final data = response.data;
      if (data == null) {
        throw const AuthException('Failed to update profile.');
      }

      return UserDto.fromJson(data);
    } on DioException catch (e) {
      throw AuthException(e.message ?? 'Failed to update profile.');
    }
  }

  /// Get stored auth token.
  Future<String?> getToken() async {
    return _secureStorage.read(key: _tokenKey);
  }

  /// Check if user is authenticated (has valid token).
  Future<bool> isAuthenticated() async {
    final token = await _secureStorage.read(key: _tokenKey);
    return token != null;
  }

  /// Refresh the auth token.
  Future<String?> refreshToken() async {
    final token = await _secureStorage.read(key: _tokenKey);
    if (token == null) return null;

    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.refreshToken,
        options: Options(
          headers: {'Authorization': 'JWT $token'},
        ),
      );

      final newToken = response.data?['refreshedToken'] as String?;
      if (newToken != null) {
        await _secureStorage.write(key: _tokenKey, value: newToken);
      }
      return newToken;
    } catch (_) {
      return null;
    }
  }
}

/// Provider for AuthService.
final authServiceProvider = Provider<AuthService>((ref) {
  final dio = ref.watch(dioProvider);
  final secureStorage = ref.watch(secureStorageProvider);
  return AuthService(dio, secureStorage);
});
