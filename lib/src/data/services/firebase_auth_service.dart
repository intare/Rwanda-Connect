import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/auth/auth_models.dart';

/// Exception thrown for Firebase authentication errors.
class FirebaseAuthException implements Exception {
  const FirebaseAuthException(this.message);
  final String message;

  @override
  String toString() => message;

  /// Create from FirebaseAuthException with user-friendly messages.
  factory FirebaseAuthException.fromFirebase(FirebaseException e) {
    final message = switch (e.code) {
      'user-not-found' => 'No account found with this email.',
      'wrong-password' => 'Invalid password. Please try again.',
      'invalid-credential' => 'Invalid email or password.',
      'email-already-in-use' => 'An account already exists with this email.',
      'weak-password' => 'Password is too weak. Please use a stronger password.',
      'invalid-email' => 'Please enter a valid email address.',
      'user-disabled' => 'This account has been disabled.',
      'too-many-requests' => 'Too many attempts. Please try again later.',
      'operation-not-allowed' => 'This sign-in method is not enabled.',
      'network-request-failed' => 'Network error. Please check your connection.',
      'expired-action-code' => 'This link has expired. Please request a new one.',
      'invalid-action-code' => 'This link is invalid. Please request a new one.',
      _ => e.message ?? 'An unexpected error occurred.',
    };
    return FirebaseAuthException(message);
  }
}

/// Service for Firebase Authentication.
class FirebaseAuthService {
  FirebaseAuthService(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  /// Get the current Firebase user.
  User? get currentUser => _firebaseAuth.currentUser;

  /// Stream of auth state changes.
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Check if user is authenticated.
  bool get isAuthenticated => currentUser != null;

  /// Login with email and password.
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        throw const FirebaseAuthException('Login failed. Please try again.');
      }

      final token = await user.getIdToken();
      if (token == null) {
        throw const FirebaseAuthException('Failed to get authentication token.');
      }

      return AuthResponse(
        token: token,
        user: _mapFirebaseUser(user),
      );
    } on FirebaseAuthException {
      rethrow;
    } on FirebaseException catch (e) {
      throw FirebaseAuthException.fromFirebase(e);
    } catch (e) {
      throw FirebaseAuthException('Login failed: $e');
    }
  }

  /// Register a new user with email and password.
  Future<AuthResponse> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        throw const FirebaseAuthException('Registration failed. Please try again.');
      }

      // Update display name
      await user.updateDisplayName(name);

      // Send email verification
      await user.sendEmailVerification();

      // Reload to get updated user info
      await user.reload();
      final updatedUser = _firebaseAuth.currentUser;

      final token = await updatedUser?.getIdToken();
      if (token == null) {
        throw const FirebaseAuthException('Failed to get authentication token.');
      }

      return AuthResponse(
        token: token,
        user: _mapFirebaseUser(updatedUser ?? user),
      );
    } on FirebaseAuthException {
      rethrow;
    } on FirebaseException catch (e) {
      throw FirebaseAuthException.fromFirebase(e);
    } catch (e) {
      throw FirebaseAuthException('Registration failed: $e');
    }
  }

  /// Logout the current user.
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  /// Get current user as UserDto.
  UserDto? getCurrentUserDto() {
    final user = currentUser;
    if (user == null) return null;
    return _mapFirebaseUser(user);
  }

  /// Get the current ID token.
  Future<String?> getIdToken({bool forceRefresh = false}) async {
    return currentUser?.getIdToken(forceRefresh);
  }

  /// Send password reset email.
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseException catch (e) {
      throw FirebaseAuthException.fromFirebase(e);
    }
  }

  /// Send email verification to current user.
  Future<void> sendEmailVerification() async {
    try {
      final user = currentUser;
      if (user == null) {
        throw const FirebaseAuthException('No user is currently signed in.');
      }
      await user.sendEmailVerification();
    } on FirebaseException catch (e) {
      throw FirebaseAuthException.fromFirebase(e);
    }
  }

  /// Reload current user to get latest data (e.g., after email verification).
  Future<UserDto?> reloadUser() async {
    try {
      final user = currentUser;
      if (user == null) return null;

      await user.reload();
      return _mapFirebaseUser(_firebaseAuth.currentUser ?? user);
    } catch (e) {
      return null;
    }
  }

  /// Update user profile.
  Future<UserDto> updateProfile({
    String? displayName,
    String? photoURL,
  }) async {
    try {
      final user = currentUser;
      if (user == null) {
        throw const FirebaseAuthException('No user is currently signed in.');
      }

      if (displayName != null) {
        await user.updateDisplayName(displayName);
      }
      if (photoURL != null) {
        await user.updatePhotoURL(photoURL);
      }

      await user.reload();
      return _mapFirebaseUser(_firebaseAuth.currentUser ?? user);
    } on FirebaseException catch (e) {
      throw FirebaseAuthException.fromFirebase(e);
    }
  }

  /// Map Firebase User to UserDto.
  UserDto _mapFirebaseUser(User user) {
    return UserDto(
      id: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
      emailVerified: user.emailVerified,
      onboardingCompleted: false, // Will be managed by backend/local storage
      createdAt: user.metadata.creationTime?.toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );
  }
}

/// Provider for FirebaseAuth instance.
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

/// Provider for FirebaseAuthService.
final firebaseAuthServiceProvider = Provider<FirebaseAuthService>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return FirebaseAuthService(firebaseAuth);
});
