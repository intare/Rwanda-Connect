import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../mappers/user_mapper.dart';
import '../models/auth/auth_models.dart';
import '../services/auth_service.dart';
import '../services/firebase_auth_service.dart';
import '../services/firestore_profile_service.dart';
import '../services/social_auth_service.dart';

/// Implementation of AuthRepository using Firebase Auth.
/// Uses Firebase for authentication and Firestore for profile data.
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required FirebaseAuthService firebaseAuthService,
    required AuthService authService,
    required SocialAuthService socialAuthService,
    required FirestoreProfileService firestoreProfileService,
  })  : _firebaseAuthService = firebaseAuthService,
        _authService = authService,
        _socialAuthService = socialAuthService,
        _firestoreProfileService = firestoreProfileService;

  final FirebaseAuthService _firebaseAuthService;
  final AuthService _authService;
  final SocialAuthService _socialAuthService;
  final FirestoreProfileService _firestoreProfileService;

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

      // Fetch profile from Firestore (or create if doesn't exist)
      var profile = await _firestoreProfileService.getProfile(response.user.idString);
      if (profile == null) {
        // First login - create profile in Firestore
        profile = await _firestoreProfileService.createInitialProfile(
          userId: response.user.idString,
          email: response.user.email,
          name: response.user.name,
        );
      }

      // Merge Firebase user data with Firestore profile
      final mergedUser = _mergeUserData(response.user, profile);

      // Save to local storage for offline access
      await _authService.saveFirebaseUser(mergedUser, response.token);

      return AuthSuccess(
        AuthSession(
          user: mergedUser.toEntity(),
          token: response.token,
        ),
      );
    } on AppAuthException catch (e) {
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

      // Create profile in Firestore
      final profile = await _firestoreProfileService.createInitialProfile(
        userId: response.user.idString,
        email: email,
        name: name,
      );

      // Merge data
      final mergedUser = _mergeUserData(response.user, profile);

      // Save to local storage for offline access
      await _authService.saveFirebaseUser(mergedUser, response.token);

      return AuthSuccess(
        AuthSession(
          user: mergedUser.toEntity(),
          token: response.token,
        ),
      );
    } on AppAuthException catch (e) {
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
          // Try to fetch latest profile from Firestore
          try {
            final firestoreProfile = await _firestoreProfileService.getProfile(cachedUser.idString);
            if (firestoreProfile != null) {
              final mergedUser = _mergeUserData(cachedUser, firestoreProfile);
              await _authService.saveUser(mergedUser);
              return AuthSession(
                user: mergedUser.toEntity(),
                token: cachedToken,
              );
            }
          } catch (_) {
            // Firestore unavailable, use cached data
          }

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
      // Get current user from Firebase
      final firebaseUser = _firebaseAuthService.getCurrentUserDto();
      if (firebaseUser == null) {
        return const AuthFailure('No user is currently signed in.');
      }

      // Update Firebase profile (name only)
      if (name != null) {
        await _firebaseAuthService.updateProfile(displayName: name);
      }

      // Update profile in Firestore
      final updatedProfile = await _firestoreProfileService.updateProfile(
        userId: firebaseUser.idString,
        name: name,
        location: location,
        interests: interests,
        onboardingCompleted: onboardingCompleted,
      );

      if (updatedProfile == null) {
        return const AuthFailure('Failed to update profile.');
      }

      // Merge with Firebase data
      final mergedUser = _mergeUserData(firebaseUser, updatedProfile);

      // Save updated user to local storage
      await _authService.saveUser(mergedUser);

      return AuthSuccess(mergedUser.toEntity());
    } on AppAuthException catch (e) {
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
    } on AppAuthException catch (e) {
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
    } on AppAuthException catch (e) {
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
    } on AppAuthException catch (e) {
      return AuthFailure(e.message);
    } catch (e) {
      return AuthFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<AuthResult<AuthSession>> signInWithGoogle() async {
    try {
      debugPrint('📱 Repository: Starting Google Sign-In...');
      final response = await _socialAuthService.signInWithGoogle();
      debugPrint('📱 Repository: Got response from social auth service');

      // Fetch or create profile in Firestore
      debugPrint('📱 Repository: Fetching Firestore profile...');
      var profile = await _firestoreProfileService.getProfile(response.user.idString);
      if (profile == null) {
        debugPrint('📱 Repository: Creating new Firestore profile...');
        profile = await _firestoreProfileService.createInitialProfile(
          userId: response.user.idString,
          email: response.user.email,
          name: response.user.name,
        );
      }

      debugPrint('📱 Repository: Merging user data...');
      final mergedUser = _mergeUserData(response.user, profile);
      await _authService.saveFirebaseUser(mergedUser, response.token);

      debugPrint('📱 Repository: Google Sign-In successful!');
      return AuthSuccess(
        AuthSession(
          user: mergedUser.toEntity(),
          token: response.token,
        ),
      );
    } on AuthException catch (e) {
      debugPrint('📱 Repository: AuthException: ${e.message}');
      return AuthFailure(e.message);
    } catch (e) {
      debugPrint('📱 Repository: Unexpected error: $e');
      return AuthFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<AuthResult<AuthSession>> signInWithApple() async {
    try {
      final response = await _socialAuthService.signInWithApple();

      // Fetch or create profile in Firestore
      var profile = await _firestoreProfileService.getProfile(response.user.idString);
      if (profile == null) {
        profile = await _firestoreProfileService.createInitialProfile(
          userId: response.user.idString,
          email: response.user.email,
          name: response.user.name,
        );
      }

      final mergedUser = _mergeUserData(response.user, profile);
      await _authService.saveFirebaseUser(mergedUser, response.token);

      return AuthSuccess(
        AuthSession(
          user: mergedUser.toEntity(),
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

  /// Merge Firebase user data with Firestore profile data.
  /// Firebase provides: id, email, name, emailVerified
  /// Firestore provides: location, interests, onboardingCompleted, etc.
  UserDto _mergeUserData(UserDto firebaseUser, UserDto firestoreProfile) {
    return UserDto(
      id: firebaseUser.id,
      email: firebaseUser.email,
      name: firestoreProfile.name ?? firebaseUser.name,
      emailVerified: firebaseUser.emailVerified,
      location: firestoreProfile.location,
      interests: firestoreProfile.interests,
      onboardingCompleted: firestoreProfile.onboardingCompleted,
      profileImage: firestoreProfile.profileImage,
      createdAt: firestoreProfile.createdAt ?? firebaseUser.createdAt,
      updatedAt: firestoreProfile.updatedAt ?? firebaseUser.updatedAt,
    );
  }
}

/// Provider for AuthRepository.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);
  final authService = ref.watch(authServiceProvider);
  final socialAuthService = ref.watch(socialAuthServiceProvider);
  final firestoreProfileService = ref.watch(firestoreProfileServiceProvider);
  return AuthRepositoryImpl(
    firebaseAuthService: firebaseAuthService,
    authService: authService,
    socialAuthService: socialAuthService,
    firestoreProfileService: firestoreProfileService,
  );
});
