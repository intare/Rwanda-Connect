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
      // Authenticate with Payload CMS backend
      final response = await _authService.login(
        LoginRequest(email: email, password: password),
      );

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
  Future<AuthResult<AuthSession>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Register with Payload CMS backend
      final response = await _authService.register(
        RegisterRequest(name: name, email: email, password: password),
      );

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
  Future<AuthResult<void>> logout() async {
    try {
      // Clear Payload CMS session and local storage
      await _authService.logout();
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
      // Update profile via Payload CMS
      final updatedUser = await _authService.updateProfile(
        name: name,
        location: location,
        interests: interests,
        onboardingCompleted: onboardingCompleted,
      );

      return AuthSuccess(updatedUser.toEntity());
    } on AuthException catch (e) {
      return AuthFailure(e.message);
    } catch (e) {
      return AuthFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<AuthResult<void>> forgotPassword(String email) async {
    try {
      await _authService.forgotPassword(email);
      return const AuthSuccess(null);
    } on AuthException catch (e) {
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
    try {
      await _authService.resetPassword(token: token, newPassword: newPassword);
      return const AuthSuccess(null);
    } on AuthException catch (e) {
      return AuthFailure(e.message);
    } catch (e) {
      return AuthFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<AuthResult<void>> verifyEmail(String token) async {
    try {
      await _authService.verifyEmail(token);
      return const AuthSuccess(null);
    } on AuthException catch (e) {
      return AuthFailure(e.message);
    } catch (e) {
      return AuthFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<AuthResult<void>> resendVerificationEmail(String email) async {
    try {
      await _authService.resendVerificationEmail(email);
      return const AuthSuccess(null);
    } on AuthException catch (e) {
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
