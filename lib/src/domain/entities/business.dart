import 'package:freezed_annotation/freezed_annotation.dart';

part 'business.freezed.dart';

/// Domain entity representing a business in the directory.
@freezed
class Business with _$Business {
  const Business._();

  const factory Business({
    required String id,
    required String name,
    required String slug,
    required BusinessCategory category,
    required String description,
    String? logo,
    String? phone,
    String? email,
    String? website,
    String? address,
    String? city,
    String? district,
    GeoLocation? geo,
    SocialLinks? socialLinks,
    List<BusinessHours>? businessHours,
    @Default([]) List<String> services,
    @Default([]) List<String> tags,
    @Default(false) bool isFeatured,
    @Default(0) int viewCount,
    DateTime? createdAt,
  }) = _Business;

  /// Check if the business is open now based on business hours.
  bool get isOpenNow {
    if (businessHours == null || businessHours!.isEmpty) return false;

    final now = DateTime.now();
    final currentDay = _getDayName(now.weekday);
    final currentTime = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    final todayHours = businessHours!.where((h) => h.day == currentDay).firstOrNull;
    if (todayHours == null || todayHours.isClosed) return false;

    final openTime = todayHours.open;
    final closeTime = todayHours.close;
    if (openTime == null || closeTime == null) return false;

    return currentTime.compareTo(openTime) >= 0 && currentTime.compareTo(closeTime) <= 0;
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'monday';
      case 2:
        return 'tuesday';
      case 3:
        return 'wednesday';
      case 4:
        return 'thursday';
      case 5:
        return 'friday';
      case 6:
        return 'saturday';
      case 7:
        return 'sunday';
      default:
        return 'monday';
    }
  }
}

/// Geographic location for a business.
@freezed
class GeoLocation with _$GeoLocation {
  const factory GeoLocation({
    required double latitude,
    required double longitude,
  }) = _GeoLocation;
}

/// Social media links for a business.
@freezed
class SocialLinks with _$SocialLinks {
  const factory SocialLinks({
    String? facebook,
    String? twitter,
    String? instagram,
    String? linkedin,
  }) = _SocialLinks;
}

/// Business operating hours for a day.
@freezed
class BusinessHours with _$BusinessHours {
  const factory BusinessHours({
    required String day,
    String? open,
    String? close,
    @Default(false) bool isClosed,
  }) = _BusinessHours;
}

/// Categories of businesses in the directory.
enum BusinessCategory {
  realEstate('real_estate', 'Real Estate'),
  hospitality('hospitality', 'Hospitality'),
  retail('retail', 'Retail'),
  professionalServices('professional_services', 'Professional Services'),
  technology('technology', 'Technology'),
  finance('finance', 'Finance'),
  health('health', 'Health'),
  education('education', 'Education'),
  construction('construction', 'Construction'),
  agriculture('agriculture', 'Agriculture'),
  other('other', 'Other');

  const BusinessCategory(this.value, this.label);

  final String value;
  final String label;

  static BusinessCategory fromString(String value) {
    return BusinessCategory.values.firstWhere(
      (e) => e.value.toLowerCase() == value.toLowerCase(),
      orElse: () => BusinessCategory.other,
    );
  }
}
