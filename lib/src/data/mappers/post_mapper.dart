import '../../domain/entities/post.dart';
import '../models/community/post_dto.dart';

/// Extension to convert PostDto to Post entity.
extension PostDtoMapper on PostDto {
  Post toEntity() {
    return Post(
      id: id.toString(),
      authorId: authorId,
      authorName: authorName ?? 'Anonymous',
      content: content,
      createdAt: createdAt != null
          ? DateTime.tryParse(createdAt!) ?? DateTime.now()
          : DateTime.now(),
      authorAvatarUrl: _getAuthorAvatarUrl(),
      likeCount: likesCount ?? 0,
      commentCount: commentsCount ?? 0,
      isLiked: false, // Will be computed separately if needed
    );
  }

  String? _getAuthorAvatarUrl() {
    if (author is Map<String, dynamic>) {
      final avatar = author['avatar'];
      if (avatar is Map<String, dynamic>) {
        return avatar['url'] as String?;
      }
    }
    return null;
  }
}

/// Extension to convert list of PostDto to list of Post entities.
extension PostDtoListMapper on List<PostDto> {
  List<Post> toEntities() {
    return map((dto) => dto.toEntity()).toList();
  }
}
