import 'package:freezed_annotation/freezed_annotation.dart';

part 'property.freezed.dart';

/// Property type enum.
enum PropertyType {
  house('house', 'House'),
  apartment('apartment', 'Apartment'),
  land('land', 'Land'),
  residential('residential', 'Residential'),
  commercial('commercial', 'Commercial'),
  villa('villa', 'Villa'),
  office('office', 'Office Space');

  const PropertyType(this.value, this.label);
  final String value;
  final String label;

  static PropertyType fromString(String value) {
    return PropertyType.values.firstWhere(
      (e) => e.value == value.toLowerCase(),
      orElse: () => PropertyType.house,
    );
  }
}

/// Property status/listing type enum.
enum PropertyStatus {
  sale('sale', 'For Sale'),
  rent('rent', 'For Rent'),
  available('available', 'Available'),
  pending('pending', 'Pending'),
  sold('sold', 'Sold'),
  rented('rented', 'Rented');

  const PropertyStatus(this.value, this.label);
  final String value;
  final String label;

  static PropertyStatus fromString(String value) {
    return PropertyStatus.values.firstWhere(
      (e) => e.value == value.toLowerCase(),
      orElse: () => PropertyStatus.sale,
    );
  }
}

/// Domain entity representing a property listing.
@freezed
class Property with _$Property {
  const Property._();

  const factory Property({
    required String id,
    required String title,
    required PropertyType type,
    required PropertyStatus status,
    required double price,
    required String location,
    required String description,
    String? agentId,
    String? agentName,
    String? agentPhone,
    String? agentEmail,
    @Default([]) List<String> images,
    @Default([]) List<String> amenities,
    double? size,
    int? bedrooms,
    int? bathrooms,
    int? yearBuilt,
    bool? isFeatured,
    DateTime? createdAt,
    int? bidCount,
    double? highestBid,
  }) = _Property;

  /// Get formatted price.
  String get formattedPrice {
    if (price >= 1000000) {
      return '\$${(price / 1000000).toStringAsFixed(1)}M';
    } else if (price >= 1000) {
      return '\$${(price / 1000).toStringAsFixed(0)}K';
    }
    return '\$${price.toStringAsFixed(0)}';
  }

  /// Get formatted size.
  String? get formattedSize {
    if (size == null) return null;
    return '${size!.toStringAsFixed(0)} sqm';
  }

  /// Get primary image or placeholder.
  String? get primaryImage => images.isNotEmpty ? images.first : null;

  /// Check if property has bids.
  bool get hasBids => (bidCount ?? 0) > 0;
}
