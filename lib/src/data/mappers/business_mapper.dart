import '../../core/network/api_endpoints.dart';
import '../../domain/entities/business.dart';
import '../models/directory/business_dto.dart';

/// Mapper to convert between BusinessDto and Business domain entity.
extension BusinessMapper on BusinessDto {
  /// Convert DTO to domain entity.
  Business toEntity() {
    // Extract logo URL
    String? logoUrl;
    if (logo is Map<String, dynamic>) {
      final url = (logo as Map<String, dynamic>)['url'] as String?;
      if (url != null) {
        logoUrl = url.startsWith('http') ? url : '${ApiEndpoints.serverUrl}$url';
      }
    } else if (logo is String) {
      logoUrl = (logo as String).startsWith('http')
          ? logo as String
          : '${ApiEndpoints.serverUrl}$logo';
    }

    return Business(
      id: id.toString(),
      name: name,
      slug: slug,
      category: BusinessCategory.fromString(category),
      description: description,
      logo: logoUrl,
      phone: phone,
      email: email,
      website: website,
      address: address,
      city: city,
      district: district,
      geo: geo?.toEntity(),
      socialLinks: socialLinks?.toEntity(),
      businessHours: businessHours.map((h) => h.toEntity()).toList(),
      services: services,
      tags: tags,
      isFeatured: isFeatured,
      viewCount: viewCount,
      createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
    );
  }
}

/// Mapper for GeoLocationDto.
extension GeoLocationMapper on GeoLocationDto {
  GeoLocation? toEntity() {
    if (latitude == null || longitude == null) return null;
    return GeoLocation(
      latitude: latitude!,
      longitude: longitude!,
    );
  }
}

/// Mapper for SocialLinksDto.
extension SocialLinksMapper on SocialLinksDto {
  SocialLinks toEntity() {
    return SocialLinks(
      facebook: facebook,
      twitter: twitter,
      instagram: instagram,
      linkedin: linkedin,
    );
  }
}

/// Mapper for BusinessHoursDto.
extension BusinessHoursMapper on BusinessHoursDto {
  BusinessHours toEntity() {
    return BusinessHours(
      day: day,
      open: open,
      close: close,
      isClosed: isClosed,
    );
  }
}

/// Mapper to convert list of DTOs to entities.
extension BusinessDtoListMapper on List<BusinessDto> {
  /// Convert list of DTOs to domain entities.
  List<Business> toEntities() {
    return map((dto) => dto.toEntity()).toList();
  }
}

/// Helper class for creating BusinessDto from various sources.
class BusinessDtoMapper {
  /// Create BusinessDto from JSON map.
  static BusinessDto fromJson(Map<String, dynamic> json) {
    return BusinessDto.fromJson(json);
  }
}
