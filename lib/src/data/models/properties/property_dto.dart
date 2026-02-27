import 'package:freezed_annotation/freezed_annotation.dart';

part 'property_dto.freezed.dart';
part 'property_dto.g.dart';

/// Data transfer object for Property from API.
/// Maps to Payload CMS real-estate collection.
@freezed
class PropertyDto with _$PropertyDto {
  const factory PropertyDto({
    required dynamic id,
    required String title,
    @JsonKey(name: 'category') @Default('house') String type,
    @JsonKey(name: 'listingType') @Default('sale') String status,
    @Default(0) double price,
    @Default('RWF') String currency,
    @Default('') String location,
    @Default('') String description,
    @JsonKey(name: 'contactPhone') String? agentPhone,
    @JsonKey(name: 'contactEmail') String? agentEmail,
    @Default([]) List<dynamic> images,
    @JsonKey(name: 'areaSqm') double? size,
    int? bedrooms,
    int? bathrooms,
    @Default(false) bool isFeatured,
    @Default(true) bool isAvailable,
    @JsonKey(name: 'datePosted') String? createdAt,
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
