import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../models/auth/auth_models.dart';
import 'auth_service.dart';
import 'firebase_auth_service.dart' show AppAuthException, firebaseAuthProvider;

/// Service for handling social authentication (Google, Apple) with Firebase.
class SocialAuthService {
  SocialAuthService(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  late final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  /// Sign in with Google using Firebase Auth.
  Future<AuthResponse> signInWithGoogle() async {
    try {
      debugPrint('🔐 Starting Google Sign-In...');

      // Trigger Google sign-in flow
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        debugPrint('🔐 Google Sign-In cancelled by user');
        throw const AuthException('Google sign-in was cancelled.');
      }

      debugPrint('🔐 Google user: ${googleUser.email}');

      // Get authentication details
      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;
      final accessToken = googleAuth.accessToken;

      debugPrint('🔐 Got Google tokens - idToken: ${idToken != null}, accessToken: ${accessToken != null}');

      if (idToken == null || accessToken == null) {
        throw const AuthException('Failed to get Google credentials.');
      }

      // Create Firebase credential from Google tokens
      final credential = GoogleAuthProvider.credential(
        idToken: idToken,
        accessToken: accessToken,
      );

      debugPrint('🔐 Signing in to Firebase with Google credential...');

      // Sign in to Firebase with Google credential
      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user;

      debugPrint('🔐 Firebase sign-in result - user: ${user?.uid}');

      if (user == null) {
        throw const AuthException('Google sign-in failed. Please try again.');
      }

      // Get Firebase ID token
      final token = await user.getIdToken();
      if (token == null) {
        throw const AuthException('Failed to get authentication token.');
      }

      debugPrint('🔐 Google Sign-In successful! User: ${user.email}');

      return AuthResponse(
        token: token,
        user: _mapFirebaseUser(user),
      );
    } on AppAuthException catch (e) {
      debugPrint('🔐 AppAuthException: ${e.message}');
      await _googleSignIn.signOut();
      rethrow;
    } on FirebaseException catch (e) {
      debugPrint('🔐 FirebaseException: ${e.code} - ${e.message}');
      await _googleSignIn.signOut();
      throw AppAuthException.fromFirebase(e);
    } catch (e, stackTrace) {
      debugPrint('🔐 Google Sign-In error: $e');
      debugPrint('🔐 Stack trace: $stackTrace');
      await _googleSignIn.signOut();
      if (e is AuthException) rethrow;
      throw AuthException('Google sign-in failed: $e');
    }
  }

  /// Sign in with Apple using Firebase Auth.
  Future<AuthResponse> signInWithApple() async {
    try {
      // Generate nonce for security
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      // Trigger Apple sign-in flow
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final identityToken = appleCredential.identityToken;
      if (identityToken == null) {
        throw const AuthException('Failed to get Apple credentials.');
      }

      // Create Firebase credential from Apple tokens
      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: identityToken,
        rawNonce: rawNonce,
      );

      // Sign in to Firebase with Apple credential
      final userCredential = await _firebaseAuth.signInWithCredential(oauthCredential);
      final user = userCredential.user;

      if (user == null) {
        throw const AuthException('Apple sign-in failed. Please try again.');
      }

      // Update display name if provided (only on first sign-in)
      if (appleCredential.givenName != null || appleCredential.familyName != null) {
        final fullName = [appleCredential.givenName, appleCredential.familyName]
            .where((s) => s != null && s.isNotEmpty)
            .join(' ');
        if (fullName.isNotEmpty) {
          await user.updateDisplayName(fullName);
        }
      }

      // Get Firebase ID token
      final token = await user.getIdToken();
      if (token == null) {
        throw const AuthException('Failed to get authentication token.');
      }

      return AuthResponse(
        token: token,
        user: _mapFirebaseUser(user),
      );
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        throw const AuthException('Apple sign-in was cancelled.');
      }
      throw AuthException('Apple sign-in failed: ${e.message}');
    } on AppAuthException {
      rethrow;
    } on FirebaseException catch (e) {
      throw AppAuthException.fromFirebase(e);
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

  /// Map Firebase User to UserDto.
  UserDto _mapFirebaseUser(User user) {
    return UserDto(
      id: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
      emailVerified: user.emailVerified,
      profileImage: user.photoURL,
      onboardingCompleted: false, // Will be managed by Firestore
      createdAt: user.metadata.creationTime?.toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
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
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return SocialAuthService(firebaseAuth);
});
