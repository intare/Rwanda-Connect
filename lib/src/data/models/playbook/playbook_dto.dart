import 'package:freezed_annotation/freezed_annotation.dart';

part 'playbook_dto.freezed.dart';
part 'playbook_dto.g.dart';

/// Data transfer object for PlaybookCategory from API.
@freezed
class PlaybookCategoryDto with _$PlaybookCategoryDto {
  const factory PlaybookCategoryDto({
    required dynamic id,
    required String name,
    String? description,
    String? icon,
    int? contentCount,
  }) = _PlaybookCategoryDto;

  factory PlaybookCategoryDto.fromJson(Map<String, dynamic> json) =>
      _$PlaybookCategoryDtoFromJson(json);
}

/// Data transfer object for PlaybookAuthor from API.
@freezed
class PlaybookAuthorDto with _$PlaybookAuthorDto {
  const factory PlaybookAuthorDto({
    required dynamic id,
    required String name,
    String? title,
    String? bio,
    dynamic avatar,
    String? company,
  }) = _PlaybookAuthorDto;

  factory PlaybookAuthorDto.fromJson(Map<String, dynamic> json) =>
      _$PlaybookAuthorDtoFromJson(json);
}

/// Data transfer object for PlaybookContent from API.
@freezed
class PlaybookContentDto with _$PlaybookContentDto {
  const factory PlaybookContentDto({
    required dynamic id,
    required String title,
    @Default('guide') String type,
    required String summary,
    @Default('') String content,
    required dynamic category,
    dynamic author,
    @Default('beginner') String difficulty,
    dynamic coverImage,
    String? videoUrl,
    int? readingTimeMinutes,
    int? durationMinutes,
    @Default(false) bool isFeatured,
    @Default(false) bool isPremium,
    @Default(0) int viewCount,
    @Default(0) int likeCount,
    @Default([]) List<String> tags,
    required String createdAt,
    String? updatedAt,
  }) = _PlaybookContentDto;

  factory PlaybookContentDto.fromJson(Map<String, dynamic> json) =>
      _$PlaybookContentDtoFromJson(json);
}

/// Response for playbook content list.
@freezed
class PlaybookListResponse with _$PlaybookListResponse {
  const factory PlaybookListResponse({
    required List<PlaybookContentDto> docs,
    required int totalDocs,
    required int limit,
    required int page,
    required int totalPages,
    required bool hasNextPage,
    required bool hasPrevPage,
  }) = _PlaybookListResponse;

  factory PlaybookListResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaybookListResponseFromJson(json);
}

/// Response for categories list.
@freezed
class PlaybookCategoriesResponse with _$PlaybookCategoriesResponse {
  const factory PlaybookCategoriesResponse({
    required List<PlaybookCategoryDto> docs,
    required int totalDocs,
    required int limit,
    required int page,
    required int totalPages,
    required bool hasNextPage,
    required bool hasPrevPage,
  }) = _PlaybookCategoriesResponse;

  factory PlaybookCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaybookCategoriesResponseFromJson(json);
}
