import '../../core/network/api_endpoints.dart';
import '../../domain/entities/playbook.dart';
import '../models/playbook/playbook_dto.dart';

/// Extension to convert PlaybookCategoryDto to PlaybookCategory entity.
extension PlaybookCategoryDtoMapper on PlaybookCategoryDto {
  PlaybookCategory toEntity() {
    return PlaybookCategory(
      id: id.toString(),
      name: name,
      description: description,
      icon: icon,
      contentCount: contentCount ?? 0,
    );
  }
}

/// Extension to convert list of PlaybookCategoryDto to list of PlaybookCategory.
extension PlaybookCategoryDtoListMapper on List<PlaybookCategoryDto> {
  List<PlaybookCategory> toEntities() {
    return map((dto) => dto.toEntity()).toList();
  }
}

/// Extension to convert PlaybookAuthorDto to PlaybookAuthor entity.
extension PlaybookAuthorDtoMapper on PlaybookAuthorDto {
  PlaybookAuthor toEntity() {
    String? avatarUrl;
    if (avatar != null) {
      if (avatar is Map<String, dynamic>) {
        final url = avatar['url'] as String?;
        if (url != null) {
          avatarUrl = url.startsWith('http') ? url : '${ApiEndpoints.serverUrl}$url';
        }
      } else if (avatar is String) {
        avatarUrl = avatar.startsWith('http') ? avatar : '${ApiEndpoints.serverUrl}$avatar';
      }
    }

    return PlaybookAuthor(
      id: id.toString(),
      name: name,
      title: title,
      bio: bio,
      avatar: avatarUrl,
      company: company,
    );
  }
}

/// Extension to convert PlaybookContentDto to PlaybookContent entity.
extension PlaybookContentDtoMapper on PlaybookContentDto {
  PlaybookContent toEntity() {
    // Parse category
    PlaybookCategory categoryEntity;
    if (category is Map<String, dynamic>) {
      categoryEntity = PlaybookCategoryDto.fromJson(category as Map<String, dynamic>).toEntity();
    } else {
      categoryEntity = PlaybookCategory(
        id: category.toString(),
        name: 'Unknown',
      );
    }

    // Parse author
    PlaybookAuthor? authorEntity;
    if (author != null && author is Map<String, dynamic>) {
      authorEntity = PlaybookAuthorDto.fromJson(author as Map<String, dynamic>).toEntity();
    }

    // Parse cover image
    String? coverImageUrl;
    if (coverImage != null) {
      if (coverImage is Map<String, dynamic>) {
        final url = coverImage['url'] as String?;
        if (url != null) {
          coverImageUrl = url.startsWith('http') ? url : '${ApiEndpoints.serverUrl}$url';
        }
      } else if (coverImage is String) {
        coverImageUrl = coverImage.startsWith('http') ? coverImage : '${ApiEndpoints.serverUrl}$coverImage';
      }
    }

    return PlaybookContent(
      id: id.toString(),
      title: title,
      type: PlaybookContentType.fromString(type),
      summary: summary,
      content: content,
      category: categoryEntity,
      author: authorEntity,
      difficulty: PlaybookDifficulty.fromString(difficulty),
      coverImage: coverImageUrl,
      videoUrl: videoUrl,
      readingTimeMinutes: readingTimeMinutes,
      durationMinutes: durationMinutes,
      isFeatured: isFeatured,
      isPremium: isPremium,
      viewCount: viewCount,
      likeCount: likeCount,
      tags: tags,
      createdAt: DateTime.tryParse(createdAt) ?? DateTime.now(),
      updatedAt: updatedAt != null ? DateTime.tryParse(updatedAt!) : null,
    );
  }
}

/// Extension to convert list of PlaybookContentDto to list of PlaybookContent.
extension PlaybookContentDtoListMapper on List<PlaybookContentDto> {
  List<PlaybookContent> toEntities() {
    return map((dto) => dto.toEntity()).toList();
  }
}
