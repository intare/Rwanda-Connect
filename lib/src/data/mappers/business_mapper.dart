import '../../core/network/api_endpoints.dart';
import '../../domain/entities/business.dart';
import '../models/directory/business_dto.dart';

/// Helper to extract a string from a dynamic value.
/// Handles cases where value might be a string or object with name/value fields.
String? _extractString(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  if (value is Map<String, dynamic>) {
    return (value['name'] ?? value['value'] ?? value['label'] ?? '').toString();
  }
  return value.toString();
}

/// Helper to extract strings from a dynamic list.
/// Handles cases where items might be strings or objects with name/value fields.
List<String> _extractStrings(List<dynamic> items) {
  return items.map((item) {
    if (item is String) {
      return item;
    } else if (item is Map<String, dynamic>) {
      return (item['name'] ?? item['value'] ?? item['label'] ?? '').toString();
    }
    return item.toString();
  }).where((s) => s.isNotEmpty).toList();
}

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

    // Extract category value (can be string or object with name/value field)
    String categoryValue;
    if (category is Map<String, dynamic>) {
      final catMap = category as Map<String, dynamic>;
      categoryValue = (catMap['name'] ?? catMap['value'] ?? catMap['slug'] ?? 'other').toString();
    } else {
      categoryValue = category?.toString() ?? 'other';
    }

    // Extract description (can be string or object)
    String descriptionValue = '';
    if (description is String) {
      descriptionValue = description;
    } else if (description is Map<String, dynamic>) {
      descriptionValue = (description['text'] ?? description['value'] ?? '').toString();
    }

    // Parse geo location
    GeoLocation? geoEntity;
    if (geo is Map<String, dynamic>) {
      final geoMap = geo as Map<String, dynamic>;
      final lat = geoMap['latitude'];
      final lng = geoMap['longitude'];
      if (lat != null && lng != null) {
        geoEntity = GeoLocation(
          latitude: (lat is num) ? lat.toDouble() : double.tryParse(lat.toString()) ?? 0,
          longitude: (lng is num) ? lng.toDouble() : double.tryParse(lng.toString()) ?? 0,
        );
      }
    }

    // Parse social links
    SocialLinks? socialLinksEntity;
    if (socialLinks is Map<String, dynamic>) {
      final socialMap = socialLinks as Map<String, dynamic>;
      socialLinksEntity = SocialLinks(
        facebook: _extractString(socialMap['facebook']),
        twitter: _extractString(socialMap['twitter'] ?? socialMap['x']),
        instagram: _extractString(socialMap['instagram']),
        linkedin: _extractString(socialMap['linkedin']),
      );
    }

    // Parse business hours
    List<BusinessHours> businessHoursEntities = [];
    for (final hour in businessHours) {
      if (hour is Map<String, dynamic>) {
        businessHoursEntities.add(BusinessHours(
          day: hour['day']?.toString() ?? '',
          open: _extractString(hour['openTime'] ?? hour['open']),
          close: _extractString(hour['closeTime'] ?? hour['close']),
          isClosed: hour['isClosed'] == true,
        ));
      }
    }

    // Parse createdAt
    DateTime? createdAtDate;
    if (createdAt is String) {
      createdAtDate = DateTime.tryParse(createdAt as String);
    }

    return Business(
      id: id.toString(),
      name: _extractString(name) ?? '',
      slug: _extractString(slug) ?? '',
      category: BusinessCategory.fromString(categoryValue),
      description: descriptionValue,
      logo: logoUrl,
      phone: _extractString(phone),
      email: _extractString(email),
      website: _extractString(website),
      address: _extractString(address),
      city: _extractString(city),
      district: _extractString(district),
      geo: geoEntity,
      socialLinks: socialLinksEntity,
      businessHours: businessHoursEntities,
      services: _extractStrings(services),
      tags: _extractStrings(tags),
      isFeatured: isFeatured,
      viewCount: viewCount,
      createdAt: createdAtDate,
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
