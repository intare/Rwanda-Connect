import '../../core/network/api_endpoints.dart';
import '../../domain/entities/property.dart';
import '../models/properties/property_dto.dart';

/// Mapper to convert between PropertyDto and Property domain entity.
extension PropertyMapper on PropertyDto {
  /// Convert DTO to domain entity.
  Property toEntity() {
    // Extract image URLs
    final imageUrls = images.map((img) {
      if (img is Map<String, dynamic>) {
        final url = img['url'] as String?;
        if (url != null) {
          return url.startsWith('http') ? url : '${ApiEndpoints.serverUrl}$url';
        }
      } else if (img is String) {
        return img.startsWith('http') ? img : '${ApiEndpoints.serverUrl}$img';
      }
      return null;
    }).whereType<String>().toList();

    return Property(
      id: id.toString(),
      title: title,
      type: PropertyType.fromString(type),
      status: PropertyStatus.fromString(status),
      price: price,
      location: location,
      description: description,
      agentId: agentId,
      agentName: agentName,
      agentPhone: agentPhone,
      agentEmail: agentEmail,
      images: imageUrls,
      amenities: amenities,
      size: size,
      bedrooms: bedrooms,
      bathrooms: bathrooms,
      yearBuilt: yearBuilt,
      isFeatured: isFeatured,
      createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
      bidCount: bidCount,
      highestBid: highestBid,
    );
  }
}

/// Mapper to convert list of DTOs to entities.
extension PropertyDtoListMapper on List<PropertyDto> {
  /// Convert list of DTOs to domain entities.
  List<Property> toEntities() {
    return map((dto) => dto.toEntity()).toList();
  }
}

/// Helper class for creating PropertyDto from various sources.
class PropertyDtoMapper {
  /// Create PropertyDto from JSON map.
  static PropertyDto fromJson(Map<String, dynamic> json) {
    return PropertyDto.fromJson(json);
  }
}
