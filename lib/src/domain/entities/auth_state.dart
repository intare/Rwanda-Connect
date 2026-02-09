import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';

part 'auth_state.freezed.dart';

/// Represents the authentication state of the app.
@freezed
class AuthState with _$AuthState {
  const AuthState._();

  /// Initial state - checking if user is logged in.
  const factory AuthState.initial() = AuthStateInitial;

  /// User is authenticated.
  const factory AuthState.authenticated({
    required User user,
    required String token,
  }) = AuthStateAuthenticated;

  /// User is not authenticated.
  const factory AuthState.unauthenticated() = AuthStateUnauthenticated;

  /// Authentication is in progress.
  const factory AuthState.loading() = AuthStateLoading;

  /// Authentication failed.
  const factory AuthState.error(String message) = AuthStateError;

  /// Check if user is authenticated.
  bool get isAuthenticated => this is AuthStateAuthenticated;

  /// Get user if authenticated, null otherwise.
  User? get user => mapOrNull(authenticated: (state) => state.user);

  /// Get token if authenticated, null otherwise.
  String? get token => mapOrNull(authenticated: (state) => state.token);
}
