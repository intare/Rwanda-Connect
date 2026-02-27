import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../mappers/user_mapper.dart';
import '../models/auth/auth_models.dart';
import '../services/auth_service.dart';
import '../services/firebase_auth_service.dart';
import '../services/social_auth_service.dart';

/// Implementation of AuthRepository using Firebase Auth.
/// Uses Firebase for authentication and syncs profile data with backend.
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required FirebaseAuthService firebaseAuthService,
    required AuthService authService,
    required SocialAuthService socialAuthService,
  })  : _firebaseAuthService = firebaseAuthService,
        _authService = authService,
        _socialAuthService = socialAuthService;

  final FirebaseAuthService _firebaseAuthService;
  final AuthService _authService;
  final SocialAuthService _socialAuthService;

  @override
  Future<AuthResult<AuthSession>> login({
    required String email,
    required String password,
  }) async {
    try {
      // Authenticate with Firebase
      final response = await _firebaseAuthService.login(
        email: email,
        password: password,
      );

      // Save to local storage for session persistence
      await _authService.saveFirebaseUser(response.user, response.token);

      return AuthSuccess(
        AuthSession(
          user: response.user.toEntity(),
          token: response.token,
        ),
      );
    } on FirebaseAuthException catch (e) {
      return AuthFailure(e.message);
    } catch (e) {
      return AuthFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<AuthResult<AuthSession>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Register with Firebase
      final response = await _firebaseAuthService.register(
        name: name,
        email: email,
        password: password,
      );

      // Save to local storage for session persistence
      await _authService.saveFirebaseUser(response.user, response.token);

      return AuthSuccess(
        AuthSession(
          user: response.user.toEntity(),
          token: response.token,
        ),
      );
    } on FirebaseAuthException catch (e) {
      return AuthFailure(e.message);
    } catch (e) {
      return AuthFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<AuthResult<void>> logout() async {
    try {
      // Sign out from Firebase
      await _firebaseAuthService.logout();
      // Clear local storage
      await _authService.logout();
      // Sign out from social providers
      await _socialAuthService.signOutGoogle();
      return const AuthSuccess(null);
    } catch (e) {
      return AuthFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<AuthSession?> getStoredSession() async {
    try {
      // Check cached token and user data
      final cachedToken = await _authService.getToken();
      if (cachedToken != null) {
        final cachedUser = await _authService.getStoredUser();
        if (cachedUser != null) {
          return AuthSession(
            user: cachedUser.toEntity(),
            token: cachedToken,
          );
        }
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    return _authService.isAuthenticated();
  }

  @override
  Future<AuthResult<User>> updateProfile({
    String? name,
    String? location,
    List<String>? interests,
    bool? onboardingCompleted,
  }) async {
    try {
      // Update Firebase profile (name only)
      if (name != null) {
        await _firebaseAuthService.updateProfile(displayName: name);
      }

      // Get current user from Firebase
      final firebaseUser = _firebaseAuthService.getCurrentUserDto();
      if (firebaseUser == null) {
        return const AuthFailure('No user is currently signed in.');
      }

      // Create updated user with local preferences
      final updatedUser = UserDto(
        id: firebaseUser.id,
        email: firebaseUser.email,
        name: name ?? firebaseUser.name,
        emailVerified: firebaseUser.emailVerified,
        onboardingCompleted: onboardingCompleted ?? firebaseUser.onboardingCompleted,
        location: location,
        interests: interests,
        createdAt: firebaseUser.createdAt,
        updatedAt: DateTime.now().toIso8601String(),
      );

      // Save updated user to local storage
      await _authService.saveUser(updatedUser);

      return AuthSuccess(updatedUser.toEntity());
    } on FirebaseAuthException catch (e) {
      return AuthFailure(e.message);
    } catch (e) {
      return AuthFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<AuthResult<void>> forgotPassword(String email) async {
    try {
      // Send password reset email via Firebase
      await _firebaseAuthService.sendPasswordResetEmail(email);
      return const AuthSuccess(null);
    } on FirebaseAuthException catch (e) {
      return AuthFailure(e.message);
    } catch (e) {
      return AuthFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<AuthResult<void>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    // Firebase handles password reset via email link, not token-based
    // This method is kept for interface compatibility but not used with Firebase
    return const AuthFailure('Password reset is handled via email link.');
  }

  @override
  Future<AuthResult<void>> verifyEmail(String token) async {
    // Firebase handles email verification via email link
    // Reload user to check verification status
    try {
      await _firebaseAuthService.reloadUser();
      return const AuthSuccess(null);
    } on FirebaseAuthException catch (e) {
      return AuthFailure(e.message);
    } catch (e) {
      return AuthFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<AuthResult<void>> resendVerificationEmail(String email) async {
    try {
      // Send verification email via Firebase
      await _firebaseAuthService.sendEmailVerification();
      return const AuthSuccess(null);
    } on FirebaseAuthException catch (e) {
      return AuthFailure(e.message);
    } catch (e) {
      return AuthFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<AuthResult<AuthSession>> signInWithGoogle() async {
    try {
      final response = await _socialAuthService.signInWithGoogle();
      await _authService.saveFirebaseUser(response.user, response.token);
      return AuthSuccess(
        AuthSession(
          user: response.user.toEntity(),
          token: response.token,
        ),
      );
    } on AuthException catch (e) {
      return AuthFailure(e.message);
    } catch (e) {
      return AuthFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<AuthResult<AuthSession>> signInWithApple() async {
    try {
      final response = await _socialAuthService.signInWithApple();
      await _authService.saveFirebaseUser(response.user, response.token);
      return AuthSuccess(
        AuthSession(
          user: response.user.toEntity(),
          token: response.token,
        ),
      );
    } on AuthException catch (e) {
      return AuthFailure(e.message);
    } catch (e) {
      return AuthFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<bool> isAppleSignInAvailable() async {
    return _socialAuthService.isAppleSignInAvailable();
  }

  @override
  Future<void> signOutSocialProviders() async {
    await _socialAuthService.signOutGoogle();
  }
}

/// Provider for AuthRepository.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);
  final authService = ref.watch(authServiceProvider);
  final socialAuthService = ref.watch(socialAuthServiceProvider);
  return AuthRepositoryImpl(
    firebaseAuthService: firebaseAuthService,
    authService: authService,
    socialAuthService: socialAuthService,
  );
});
