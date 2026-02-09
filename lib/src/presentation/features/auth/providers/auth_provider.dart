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
      case AuthFailure(:final message):
        state = AuthState.error(message);
    }
  }

  /// Logout the current user.
  Future<void> logout() async {
    state = const AuthState.loading();
    await _repository.logout();
    state = const AuthState.unauthenticated();
  }

  /// Clear any error state.
  void clearError() {
    if (state is AuthStateError) {
      state = const AuthState.unauthenticated();
    }
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
