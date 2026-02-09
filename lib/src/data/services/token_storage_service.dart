import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/network/api_client.dart';
import '../models/auth/user_dto.dart';

/// Keys for secure storage.
abstract final class StorageKeys {
  static const String authToken = 'auth_token';
  static const String userData = 'user_data';
}

/// Service for securely storing and retrieving auth tokens and user data.
class TokenStorageService {
  TokenStorageService(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  /// Store the auth token.
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: StorageKeys.authToken, value: token);
  }

  /// Get the stored auth token.
  Future<String?> getToken() async {
    return _secureStorage.read(key: StorageKeys.authToken);
  }

  /// Delete the stored auth token.
  Future<void> deleteToken() async {
    await _secureStorage.delete(key: StorageKeys.authToken);
  }

  /// Store user data.
  Future<void> saveUser(UserDto user) async {
    final jsonString = jsonEncode(user.toJson());
    await _secureStorage.write(key: StorageKeys.userData, value: jsonString);
  }

  /// Get stored user data.
  Future<UserDto?> getUser() async {
    final jsonString = await _secureStorage.read(key: StorageKeys.userData);
    if (jsonString == null) return null;

    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return UserDto.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  /// Delete stored user data.
  Future<void> deleteUser() async {
    await _secureStorage.delete(key: StorageKeys.userData);
  }

  /// Clear all auth-related storage.
  Future<void> clearAll() async {
    await Future.wait([
      deleteToken(),
      deleteUser(),
    ]);
  }

  /// Check if user has stored credentials.
  Future<bool> hasStoredCredentials() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}

/// Provider for TokenStorageService.
final tokenStorageServiceProvider = Provider<TokenStorageService>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return TokenStorageService(secureStorage);
});
