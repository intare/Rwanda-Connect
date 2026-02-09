import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

/// DTO for user data from API responses.
@JsonSerializable()
class UserDto {
  const UserDto({
    required this.id,
    this.name,
    required this.email,
    this.location,
    this.interests,
    this.onboardingCompleted,
    this.createdAt,
    this.updatedAt,
  });

  final dynamic id; // Can be int or String from Payload
  final String? name;
  final String email;
  final String? location;
  final List<dynamic>? interests;
  final bool? onboardingCompleted;
  final String? createdAt;
  final String? updatedAt;

  String get idString => id.toString();

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
