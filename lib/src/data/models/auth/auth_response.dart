import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_dto.dart';

part 'auth_response.freezed.dart';
part 'auth_response.g.dart';

/// DTO for authentication response (login/register).
@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required String token,
    required UserDto user,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}
