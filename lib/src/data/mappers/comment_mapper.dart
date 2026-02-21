import '../../domain/entities/comment.dart';
import '../models/community/comment_dto.dart';

/// Mapper to convert between CommentDto and Comment domain entity.
extension CommentMapper on CommentDto {
  /// Convert DTO to domain entity.
  Comment toEntity() {
    return Comment(
      id: id.toString(),
      postId: postId,
      authorId: authorId,
      authorName: authorName ?? 'Anonymous',
      content: content,
      createdAt: createdAt != null
          ? DateTime.tryParse(createdAt!) ?? DateTime.now()
          : DateTime.now(),
      authorAvatarUrl: authorAvatarUrl,
    );
  }
}

/// Mapper to convert list of DTOs to entities.
extension CommentDtoListMapper on List<CommentDto> {
  /// Convert list of DTOs to domain entities.
  List<Comment> toEntities() {
    return map((dto) => dto.toEntity()).toList();
  }
}
