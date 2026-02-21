import 'package:freezed_annotation/freezed_annotation.dart';

part 'mentorship_dto.freezed.dart';
part 'mentorship_dto.g.dart';

/// Data transfer object for Mentor from API.
@freezed
class MentorDto with _$MentorDto {
  const factory MentorDto({
    required dynamic id,
    required String userId,
    required String name,
    dynamic avatar,
    String? title,
    String? company,
    String? bio,
    @Default([]) List<String> expertise,
    @Default(0) int yearsExperience,
    String? linkedinUrl,
    String? location,
    @Default([]) List<String> languages,
    @Default(true) bool isAvailable,
    @Default(0) int totalMentees,
    @Default(0.0) double rating,
    @Default(0) int reviewCount,
    String? createdAt,
  }) = _MentorDto;

  factory MentorDto.fromJson(Map<String, dynamic> json) =>
      _$MentorDtoFromJson(json);
}

/// Data transfer object for MentorshipRequest from API.
@freezed
class MentorshipRequestDto with _$MentorshipRequestDto {
  const factory MentorshipRequestDto({
    required dynamic id,
    required dynamic mentor,
    required dynamic mentee,
    @Default('pending') String status,
    required String message,
    String? responseMessage,
    required String createdAt,
    String? respondedAt,
  }) = _MentorshipRequestDto;

  factory MentorshipRequestDto.fromJson(Map<String, dynamic> json) =>
      _$MentorshipRequestDtoFromJson(json);
}

/// Data transfer object for MentorshipConnection from API.
@freezed
class MentorshipConnectionDto with _$MentorshipConnectionDto {
  const factory MentorshipConnectionDto({
    required dynamic id,
    required dynamic mentor,
    required dynamic mentee,
    required String startedAt,
    String? endedAt,
    @Default(true) bool isActive,
    String? notes,
  }) = _MentorshipConnectionDto;

  factory MentorshipConnectionDto.fromJson(Map<String, dynamic> json) =>
      _$MentorshipConnectionDtoFromJson(json);
}

/// Response for mentors list.
@freezed
class MentorsListResponse with _$MentorsListResponse {
  const factory MentorsListResponse({
    required List<MentorDto> docs,
    required int totalDocs,
    required int limit,
    required int page,
    required int totalPages,
    required bool hasNextPage,
    required bool hasPrevPage,
  }) = _MentorsListResponse;

  factory MentorsListResponse.fromJson(Map<String, dynamic> json) =>
      _$MentorsListResponseFromJson(json);
}

/// Response for mentorship requests list.
@freezed
class MentorshipRequestsListResponse with _$MentorshipRequestsListResponse {
  const factory MentorshipRequestsListResponse({
    required List<MentorshipRequestDto> docs,
    required int totalDocs,
    required int limit,
    required int page,
    required int totalPages,
    required bool hasNextPage,
    required bool hasPrevPage,
  }) = _MentorshipRequestsListResponse;

  factory MentorshipRequestsListResponse.fromJson(Map<String, dynamic> json) =>
      _$MentorshipRequestsListResponseFromJson(json);
}

/// Response for mentorship connections list.
@freezed
class MentorshipConnectionsListResponse with _$MentorshipConnectionsListResponse {
  const factory MentorshipConnectionsListResponse({
    required List<MentorshipConnectionDto> docs,
    required int totalDocs,
    required int limit,
    required int page,
    required int totalPages,
    required bool hasNextPage,
    required bool hasPrevPage,
  }) = _MentorshipConnectionsListResponse;

  factory MentorshipConnectionsListResponse.fromJson(Map<String, dynamic> json) =>
      _$MentorshipConnectionsListResponseFromJson(json);
}

/// Request to send a mentorship request.
@freezed
class SendMentorshipRequestDto with _$SendMentorshipRequestDto {
  const factory SendMentorshipRequestDto({
    required String mentorId,
    required String message,
  }) = _SendMentorshipRequestDto;

  factory SendMentorshipRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SendMentorshipRequestDtoFromJson(json);
}

/// Request to register as mentor.
@freezed
class RegisterMentorDto with _$RegisterMentorDto {
  const factory RegisterMentorDto({
    required String bio,
    required List<String> expertise,
    required int yearsExperience,
    String? linkedinUrl,
  }) = _RegisterMentorDto;

  factory RegisterMentorDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterMentorDtoFromJson(json);
}
