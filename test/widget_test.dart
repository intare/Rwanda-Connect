import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rwanda_connect/main.dart';
import 'package:rwanda_connect/src/domain/entities/auth_state.dart';
import 'package:rwanda_connect/src/domain/entities/user.dart';
import 'package:rwanda_connect/src/domain/repositories/auth_repository.dart';
import 'package:rwanda_connect/src/presentation/features/auth/providers/auth_provider.dart';

void main() {
  testWidgets('App renders splash screen initially', (
    WidgetTester tester,
  ) async {
    // Build the app with ProviderScope
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith((ref) => MockInitialAuthNotifier()),
        ],
        child: RwandaConnectApp(),
      ),
    );

    // Initially shows splash screen
    expect(find.text('Rwanda Connect'), findsOneWidget);
  });

  testWidgets('App shows login when unauthenticated', (
    WidgetTester tester,
  ) async {
    // Build the app with overridden auth state
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Override auth provider to return unauthenticated state
          authProvider.overrideWith((ref) => MockAuthNotifier()),
        ],
        child: const RwandaConnectApp(),
      ),
    );

    // Pump a few frames to let the router redirect
    await tester.pump();
    await tester.pump();
    await tester.pump();

    // Verify we're on the login screen
    expect(find.text('Rwanda Connect'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
    expect(find.text('Create Account'), findsOneWidget);
  });
}

/// Mock auth notifier that returns unauthenticated state immediately.
class MockAuthNotifier extends AuthNotifier {
  MockAuthNotifier() : super(_MockAuthRepository());

  @override
  AuthState get state => const AuthState.unauthenticated();
}

/// Mock auth notifier that keeps the initial splash state.
class MockInitialAuthNotifier extends AuthNotifier {
  MockInitialAuthNotifier() : super(_MockAuthRepository());

  @override
  AuthState get state => const AuthState.initial();
}

/// Mock auth repository for testing.
class _MockAuthRepository implements AuthRepository {
  @override
  Future<AuthResult<AuthSession>> login({
    required String email,
    required String password,
  }) async {
    return const AuthFailure('Mock');
  }

  @override
  Future<AuthResult<AuthSession>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    return const AuthFailure('Mock');
  }

  @override
  Future<AuthResult<void>> logout() async {
    return const AuthSuccess(null);
  }

  @override
  Future<AuthSession?> getStoredSession() async => null;

  @override
  Future<bool> isAuthenticated() async => false;

  @override
  Future<AuthResult<User>> updateProfile({
    String? name,
    String? location,
    List<String>? interests,
    bool? onboardingCompleted,
  }) async {
    return const AuthFailure('Mock');
  }

  @override
  Future<AuthResult<void>> forgotPassword(String email) async {
    return const AuthFailure('Mock');
  }

  @override
  Future<AuthResult<void>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    return const AuthFailure('Mock');
  }

  @override
  Future<AuthResult<void>> verifyEmail(String token) async {
    return const AuthFailure('Mock');
  }

  @override
  Future<AuthResult<void>> resendVerificationEmail(String email) async {
    return const AuthFailure('Mock');
  }

  @override
  Future<AuthResult<AuthSession>> signInWithGoogle() async {
    return const AuthFailure('Mock');
  }

  @override
  Future<AuthResult<AuthSession>> signInWithApple() async {
    return const AuthFailure('Mock');
  }

  @override
  Future<bool> isAppleSignInAvailable() async => false;

  @override
  Future<void> signOutSocialProviders() async {}
}
