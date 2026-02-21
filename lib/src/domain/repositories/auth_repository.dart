import '../entities/user.dart';

/// Result type for auth operations.
sealed class AuthResult<T> {
  const AuthResult();
}

class AuthSuccess<T> extends AuthResult<T> {
  const AuthSuccess(this.data);
  final T data;
}

class AuthFailure<T> extends AuthResult<T> {
  const AuthFailure(this.message, {this.code});
  final String message;
  final String? code;
}

/// Data class for authenticated session.
class AuthSession {
  const AuthSession({
    required this.user,
    required this.token,
  });

  final User user;
  final String token;
}

/// Repository interface for authentication operations.
abstract class AuthRepository {
  /// Login with email and password.
  Future<AuthResult<AuthSession>> login({
    required String email,
    required String password,
  });

  /// Register a new user.
  Future<AuthResult<AuthSession>> register({
    required String name,
    required String email,
    required String password,
  });

  /// Logout the current user.
  Future<AuthResult<void>> logout();

  /// Get the currently stored session if any.
  Future<AuthSession?> getStoredSession();

  /// Check if user is currently authenticated.
  Future<bool> isAuthenticated();

  /// Update user profile.
  Future<AuthResult<User>> updateProfile({
    String? name,
    String? location,
    List<String>? interests,
    bool? onboardingCompleted,
  });

  /// Request a password reset email.
  Future<AuthResult<void>> forgotPassword(String email);

  /// Reset password using token from email.
  Future<AuthResult<void>> resetPassword({
    required String token,
    required String newPassword,
  });

  /// Verify email with token.
  Future<AuthResult<void>> verifyEmail(String token);

  /// Resend verification email.
  Future<AuthResult<void>> resendVerificationEmail(String email);

  /// Sign in with Google.
  Future<AuthResult<AuthSession>> signInWithGoogle();

  /// Sign in with Apple.
  Future<AuthResult<AuthSession>> signInWithApple();

  /// Check if Apple Sign-In is available.
  Future<bool> isAppleSignInAvailable();

  /// Sign out from social providers.
  Future<void> signOutSocialProviders();
}
