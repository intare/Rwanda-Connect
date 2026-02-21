import '../../core/network/api_endpoints.dart';
import '../../domain/entities/user.dart';
import '../models/auth/user_dto.dart';

/// Mapper to convert between UserDto and User domain entity.
extension UserMapper on UserDto {
  /// Convert DTO to domain entity.
  User toEntity() {
    // Convert interests from List<dynamic> to List<String>
    final interestsList = interests
            ?.map((e) => e is Map ? e['interest']?.toString() ?? '' : e.toString())
            .where((e) => e.isNotEmpty)
            .toList() ??
        [];

    // Extract profile image URL
    String? imageUrl;
    if (profileImage is Map<String, dynamic>) {
      final relativeUrl = profileImage['url'] as String?;
      if (relativeUrl != null) {
        imageUrl = relativeUrl.startsWith('http')
            ? relativeUrl
            : '${ApiEndpoints.serverUrl}$relativeUrl';
      }
    }

    return User(
      id: idString,
      name: name ?? 'User',
      email: email,
      location: location,
      profileImageUrl: imageUrl,
      interests: interestsList,
      onboardingCompleted: onboardingCompleted ?? false,
      emailVerified: emailVerified ?? false,
    );
  }
}

/// Mapper to convert User entity to DTO.
extension UserEntityMapper on User {
  /// Convert domain entity to DTO.
  UserDto toDto() {
    return UserDto(
      id: id,
      name: name,
      email: email,
      location: location,
      interests: interests,
    );
  }
}
