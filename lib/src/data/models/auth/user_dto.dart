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
    this.emailVerified,
    this.profileImage,
    this.createdAt,
    this.updatedAt,
  });

  final dynamic id; // Can be int or String from Payload
  final String? name;
  final String email;
  final String? location;
  final List<dynamic>? interests;
  final bool? onboardingCompleted;
  @JsonKey(name: '_verified')
  final bool? emailVerified;
  final dynamic profileImage; // Can be object or ID
  final String? createdAt;
  final String? updatedAt;

  String get idString => id.toString();

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  /// Creates a copy of this UserDto with the given fields replaced.
  UserDto copyWith({
    dynamic id,
    String? name,
    String? email,
    String? location,
    List<dynamic>? interests,
    bool? onboardingCompleted,
    bool? emailVerified,
    dynamic profileImage,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserDto(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      location: location ?? this.location,
      interests: interests ?? this.interests,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      emailVerified: emailVerified ?? this.emailVerified,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
