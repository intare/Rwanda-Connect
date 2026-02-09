import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/auth_repository.dart';
import '../mappers/user_mapper.dart';
import '../models/auth/auth_models.dart';
import '../services/auth_service.dart';

/// Implementation of AuthRepository using Payload CMS.
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthService authService})
      : _authService = authService;

  final AuthService _authService;

  @override
  Future<AuthResult<AuthSession>> login({
    required String email,
    required String password,
  }) async {
    try {
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
      await _authService.logout();
      return const AuthSuccess(null);
    } on AuthException catch (e) {
      return AuthFailure(e.message);
    } catch (e) {
      return AuthFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<AuthSession?> getStoredSession() async {
    try {
      final token = await _authService.getToken();
      if (token == null) {
        return null;
      }

      // Fetch current user profile
      final userDto = await _authService.getCurrentUser();

      return AuthSession(
        user: userDto.toEntity(),
        token: token,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    return _authService.isAuthenticated();
  }
}

/// Provider for AuthRepository.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthRepositoryImpl(authService: authService);
});
