import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../models/auth/auth_models.dart';
import 'auth_service.dart';

/// Service for handling social authentication (Google, Apple).
class SocialAuthService {
  SocialAuthService(this._dio, this._secureStorage);

  final Dio _dio;
  final FlutterSecureStorage _secureStorage;

  static const _tokenKey = 'auth_token';
  static const _userIdKey = 'user_id';

  // Google Sign-In configuration
  // TODO: Replace with your actual Google OAuth client IDs
  static const _googleClientId = String.fromEnvironment(
    'GOOGLE_CLIENT_ID',
    defaultValue: '',
  );

  static const _googleServerClientId = String.fromEnvironment(
    'GOOGLE_SERVER_CLIENT_ID',
    defaultValue: '',
  );

  late final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: _googleClientId.isNotEmpty ? _googleClientId : null,
    serverClientId:
        _googleServerClientId.isNotEmpty ? _googleServerClientId : null,
    scopes: ['email', 'profile'],
  );

  /// Sign in with Google.
  Future<AuthResponse> signInWithGoogle() async {
    try {
      // Trigger Google sign-in flow
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw const AuthException('Google sign-in was cancelled.');
      }

      // Get authentication details
      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;
      final accessToken = googleAuth.accessToken;

      if (idToken == null) {
        throw const AuthException('Failed to get Google credentials.');
      }

      // Send to backend for verification and user creation/login
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.googleAuth,
        data: {
          'idToken': idToken,
          'accessToken': accessToken,
          'email': googleUser.email,
          'name': googleUser.displayName,
          'photoUrl': googleUser.photoUrl,
        },
      );

      return _handleAuthResponse(response.data);
    } on DioException catch (e) {
      await _googleSignIn.signOut();
      if (e.response?.statusCode == 401) {
        throw const AuthException('Google authentication failed.');
      }
      throw AuthException(
          e.message ?? 'Google sign-in failed. Please try again.');
    } catch (e) {
      await _googleSignIn.signOut();
      if (e is AuthException) rethrow;
      throw AuthException('Google sign-in failed: $e');
    }
  }

  /// Sign in with Apple.
  Future<AuthResponse> signInWithApple() async {
    try {
      // Generate nonce for security
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      // Trigger Apple sign-in flow
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final identityToken = credential.identityToken;
      if (identityToken == null) {
        throw const AuthException('Failed to get Apple credentials.');
      }

      // Build name from Apple credential (only provided on first sign-in)
      String? fullName;
      if (credential.givenName != null || credential.familyName != null) {
        fullName = [credential.givenName, credential.familyName]
            .where((s) => s != null && s.isNotEmpty)
            .join(' ');
      }

      // Send to backend for verification and user creation/login
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.appleAuth,
        data: {
          'identityToken': identityToken,
          'authorizationCode': credential.authorizationCode,
          'email': credential.email,
          'name': fullName,
          'userIdentifier': credential.userIdentifier,
          'nonce': rawNonce,
        },
      );

      return _handleAuthResponse(response.data);
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        throw const AuthException('Apple sign-in was cancelled.');
      }
      throw AuthException('Apple sign-in failed: ${e.message}');
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw const AuthException('Apple authentication failed.');
      }
      throw AuthException(
          e.message ?? 'Apple sign-in failed. Please try again.');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw AuthException('Apple sign-in failed: $e');
    }
  }

  /// Check if Apple Sign-In is available on this device.
  Future<bool> isAppleSignInAvailable() async {
    return await SignInWithApple.isAvailable();
  }

  /// Sign out from Google (call when logging out).
  Future<void> signOutGoogle() async {
    try {
      await _googleSignIn.signOut();
    } catch (_) {
      // Ignore errors during sign out
    }
  }

  /// Handle auth response from backend.
  AuthResponse _handleAuthResponse(Map<String, dynamic>? data) {
    if (data == null) {
      throw const AuthException('Authentication failed. Invalid response.');
    }

    final token = data['token'] as String?;
    final userData = data['user'] as Map<String, dynamic>?;

    if (token == null || userData == null) {
      throw const AuthException('Authentication failed. Invalid response.');
    }

    // Store token securely
    _secureStorage.write(key: _tokenKey, value: token);
    _secureStorage.write(key: _userIdKey, value: userData['id'].toString());

    return AuthResponse(
      token: token,
      user: UserDto.fromJson(userData),
    );
  }

  /// Generate a random nonce string.
  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// SHA256 hash of a string.
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}

/// Provider for SocialAuthService.
final socialAuthServiceProvider = Provider<SocialAuthService>((ref) {
  final dio = ref.watch(dioProvider);
  final secureStorage = ref.watch(secureStorageProvider);
  return SocialAuthService(dio, secureStorage);
});
