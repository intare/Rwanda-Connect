// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
  id: json['id'],
  name: json['name'] as String?,
  email: json['email'] as String,
  location: json['location'] as String?,
  interests: json['interests'] as List<dynamic>?,
  onboardingCompleted: json['onboardingCompleted'] as bool?,
  emailVerified: json['_verified'] as bool?,
  profileImage: json['profileImage'],
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'location': instance.location,
  'interests': instance.interests,
  'onboardingCompleted': instance.onboardingCompleted,
  '_verified': instance.emailVerified,
  'profileImage': instance.profileImage,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
