import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/repositories/auth_repository_impl.dart';
import '../../../../domain/entities/auth_state.dart';
import '../../../../domain/repositories/auth_repository.dart';

/// Notifier for managing authentication state.
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._repository) : super(const AuthState.initial()) {
    _checkAuthStatus();
  }

  final AuthRepository _repository;

  /// Check if user is already authenticated on app start.
  Future<void> _checkAuthStatus() async {
    final session = await _repository.getStoredSession();
    if (session != null) {
      state = AuthState.authenticated(
        user: session.user,
        token: session.token,
      );
    } else {
      state = const AuthState.unauthenticated();
    }
  }

  /// Login with email and password.
  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AuthState.loading();

    final result = await _repository.login(
      email: email,
      password: password,
    );

    switch (result) {
      case AuthSuccess(:final data):
        state = AuthState.authenticated(
          user: data.user,
          token: data.token,
        );
      case AuthFailure(:final message):
        state = AuthState.error(message);
    }
  }

  /// Register a new user.
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AuthState.loading();

    final result = await _repository.register(
      name: name,
      email: email,
      password: password,
    );

    switch (result) {
      case AuthSuccess(:final data):
        state = AuthState.authenticated(
          user: data.user,
          token: data.token,
        );
        // Send verification email after successful registration
        if (!data.user.emailVerified) {
          await _repository.resendVerificationEmail(email);
        }
      case AuthFailure(:final message):
        state = AuthState.error(message);
    }
  }

  /// Logout the current user.
  Future<void> logout() async {
    state = const AuthState.loading();
    await _repository.signOutSocialProviders();
    await _repository.logout();
    state = const AuthState.unauthenticated();
  }

  /// Clear any error state.
  void clearError() {
    if (state is AuthStateError) {
      state = const AuthState.unauthenticated();
    }
  }

  /// Update user profile (interests, location, etc.).
  Future<bool> updateProfile({
    String? name,
    String? location,
    List<String>? interests,
    bool? onboardingCompleted,
  }) async {
    final currentState = state;
    if (currentState is! AuthStateAuthenticated) {
      return false;
    }

    final result = await _repository.updateProfile(
      name: name,
      location: location,
      interests: interests,
      onboardingCompleted: onboardingCompleted,
    );

    switch (result) {
      case AuthSuccess(:final data):
        state = AuthState.authenticated(
          user: data,
          token: currentState.token,
        );
        return true;
      case AuthFailure(:final message):
        state = AuthState.error(message);
        return false;
    }
  }

  /// Request password reset email.
  Future<bool> forgotPassword(String email) async {
    state = const AuthState.loading();

    final result = await _repository.forgotPassword(email);

    switch (result) {
      case AuthSuccess():
        state = const AuthState.unauthenticated();
        return true;
      case AuthFailure(:final message):
        state = AuthState.error(message);
        return false;
    }
  }

  /// Reset password with token.
  Future<bool> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    state = const AuthState.loading();

    final result = await _repository.resetPassword(
      token: token,
      newPassword: newPassword,
    );

    switch (result) {
      case AuthSuccess():
        state = const AuthState.unauthenticated();
        return true;
      case AuthFailure(:final message):
        state = AuthState.error(message);
        return false;
    }
  }

  /// Verify email with token.
  Future<bool> verifyEmail(String token) async {
    final currentState = state;
    state = const AuthState.loading();

    final result = await _repository.verifyEmail(token);

    switch (result) {
      case AuthSuccess():
        // Refresh user data to get updated emailVerified status
        if (currentState is AuthStateAuthenticated) {
          final session = await _repository.getStoredSession();
          if (session != null) {
            state = AuthState.authenticated(
              user: session.user,
              token: session.token,
            );
          } else {
            state = currentState;
          }
        } else {
          state = const AuthState.unauthenticated();
        }
        return true;
      case AuthFailure(:final message):
        state = AuthState.error(message);
        return false;
    }
  }

  /// Resend verification email.
  Future<bool> resendVerificationEmail() async {
    final currentState = state;
    if (currentState is! AuthStateAuthenticated) {
      return false;
    }

    final result = await _repository.resendVerificationEmail(
      currentState.user.email,
    );

    switch (result) {
      case AuthSuccess():
        return true;
      case AuthFailure(:final message):
        state = AuthState.error(message);
        return false;
    }
  }

  /// Refresh user data from server.
  Future<void> refreshUser() async {
    final currentState = state;
    if (currentState is! AuthStateAuthenticated) {
      return;
    }

    final session = await _repository.getStoredSession();
    if (session != null) {
      state = AuthState.authenticated(
        user: session.user,
        token: session.token,
      );
    }
  }

  /// Sign in with Google.
  Future<void> signInWithGoogle() async {
    state = const AuthState.loading();

    final result = await _repository.signInWithGoogle();

    switch (result) {
      case AuthSuccess(:final data):
        state = AuthState.authenticated(
          user: data.user,
          token: data.token,
        );
      case AuthFailure(:final message):
        state = AuthState.error(message);
    }
  }

  /// Sign in with Apple.
  Future<void> signInWithApple() async {
    state = const AuthState.loading();

    final result = await _repository.signInWithApple();

    switch (result) {
      case AuthSuccess(:final data):
        state = AuthState.authenticated(
          user: data.user,
          token: data.token,
        );
      case AuthFailure(:final message):
        state = AuthState.error(message);
    }
  }

  /// Check if Apple Sign-In is available.
  Future<bool> isAppleSignInAvailable() async {
    return _repository.isAppleSignInAvailable();
  }
}

/// Provider for AuthNotifier.
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});

/// Provider for checking if user is authenticated.
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authProvider);
  return authState.isAuthenticated;
});

/// Provider for getting current user.
final currentUserProvider = Provider((ref) {
  final authState = ref.watch(authProvider);
  return authState.user;
});

/// Provider for checking if user's email is verified.
final isEmailVerifiedProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.emailVerified ?? false;
});
