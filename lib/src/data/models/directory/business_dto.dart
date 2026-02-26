import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_dto.freezed.dart';
part 'business_dto.g.dart';

/// Data transfer object for Business from API.
@freezed
class BusinessDto with _$BusinessDto {
  const factory BusinessDto({
    required dynamic id,
    required dynamic name,
    required dynamic slug,
    required dynamic category,
    dynamic description,
    dynamic logo,
    dynamic phone,
    dynamic email,
    dynamic website,
    dynamic address,
    dynamic city,
    dynamic district,
    dynamic geo,
    @JsonKey(name: 'social') dynamic socialLinks,
    @Default([]) List<dynamic> businessHours,
    @Default([]) List<dynamic> services,
    @Default([]) List<dynamic> tags,
    @Default(false) bool isFeatured,
    @Default(0) int viewCount,
    dynamic createdAt,
  }) = _BusinessDto;

  factory BusinessDto.fromJson(Map<String, dynamic> json) =>
      _$BusinessDtoFromJson(json);
}

/// DTO for geographic location.
@freezed
class GeoLocationDto with _$GeoLocationDto {
  const factory GeoLocationDto({
    double? latitude,
    double? longitude,
  }) = _GeoLocationDto;

  factory GeoLocationDto.fromJson(Map<String, dynamic> json) =>
      _$GeoLocationDtoFromJson(json);
}

/// DTO for social media links.
@freezed
class SocialLinksDto with _$SocialLinksDto {
  const factory SocialLinksDto({
    String? facebook,
    String? twitter,
    String? instagram,
    String? linkedin,
  }) = _SocialLinksDto;

  factory SocialLinksDto.fromJson(Map<String, dynamic> json) =>
      _$SocialLinksDtoFromJson(json);
}

/// DTO for business operating hours.
@freezed
class BusinessHoursDto with _$BusinessHoursDto {
  const factory BusinessHoursDto({
    required String day,
    @JsonKey(name: 'openTime') String? open,
    @JsonKey(name: 'closeTime') String? close,
    @Default(false) bool isClosed,
  }) = _BusinessHoursDto;

  factory BusinessHoursDto.fromJson(Map<String, dynamic> json) =>
      _$BusinessHoursDtoFromJson(json);
}

/// Response for businesses list.
@freezed
class BusinessesListResponse with _$BusinessesListResponse {
  const factory BusinessesListResponse({
    required List<BusinessDto> docs,
    required int totalDocs,
    required int limit,
    required int page,
    required int totalPages,
    required bool hasNextPage,
    required bool hasPrevPage,
  }) = _BusinessesListResponse;

  factory BusinessesListResponse.fromJson(Map<String, dynamic> json) =>
      _$BusinessesListResponseFromJson(json);
}

/// Extension to get list of businesses and hasNext flag.
extension BusinessesListResponseX on BusinessesListResponse {
  List<BusinessDto> get businesses => docs;
  bool get hasNext => hasNextPage;
}
