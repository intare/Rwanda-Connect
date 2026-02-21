import 'package:freezed_annotation/freezed_annotation.dart';

part 'property_dto.freezed.dart';
part 'property_dto.g.dart';

/// Data transfer object for Property from API.
@freezed
class PropertyDto with _$PropertyDto {
  const factory PropertyDto({
    required dynamic id,
    required String title,
    required String type,
    @Default('available') String status,
    required double price,
    required String location,
    @Default('') String description,
    String? agentId,
    String? agentName,
    String? agentPhone,
    String? agentEmail,
    @Default([]) List<dynamic> images,
    @Default([]) List<String> amenities,
    double? size,
    int? bedrooms,
    int? bathrooms,
    int? yearBuilt,
    @Default(false) bool isFeatured,
    String? createdAt,
    int? bidCount,
    double? highestBid,
  }) = _PropertyDto;

  factory PropertyDto.fromJson(Map<String, dynamic> json) =>
      _$PropertyDtoFromJson(json);
}

/// Response for properties list.
@freezed
class PropertiesListResponse with _$PropertiesListResponse {
  const factory PropertiesListResponse({
    required List<PropertyDto> docs,
    required int totalDocs,
    required int limit,
    required int page,
    required int totalPages,
    required bool hasNextPage,
    required bool hasPrevPage,
  }) = _PropertiesListResponse;

  factory PropertiesListResponse.fromJson(Map<String, dynamic> json) =>
      _$PropertiesListResponseFromJson(json);
}

/// Extension to get list of properties and hasNext flag.
extension PropertiesListResponseX on PropertiesListResponse {
  List<PropertyDto> get properties => docs;
  bool get hasNext => hasNextPage;
}
