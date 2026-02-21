import 'package:json_annotation/json_annotation.dart';

part 'comment_dto.g.dart';

/// Data transfer object for Comment from Payload CMS API.
@JsonSerializable()
class CommentDto {
  const CommentDto({
    required this.id,
    required this.content,
    this.post,
    this.author,
    this.createdAt,
    this.updatedAt,
  });

  final dynamic id; // Can be int or String from Payload
  final String content;
  final dynamic post; // Can be object (populated) or ID
  final dynamic author; // Can be object (populated) or ID
  final String? createdAt;
  final String? updatedAt;

  String get idString => id.toString();

  /// Get post ID regardless of population.
  String get postId {
    if (post is Map<String, dynamic>) {
      return post['id'].toString();
    }
    return post.toString();
  }

  /// Get author name from populated author object.
  String? get authorName {
    if (author is Map<String, dynamic>) {
      return author['name'] as String? ?? author['email'] as String?;
    }
    return null;
  }

  /// Get author ID regardless of population.
  String get authorId {
    if (author is Map<String, dynamic>) {
      return author['id'].toString();
    }
    return author.toString();
  }

  /// Get author avatar URL from populated author object.
  String? get authorAvatarUrl {
    if (author is Map<String, dynamic>) {
      final avatar = author['avatar'];
      if (avatar is Map<String, dynamic>) {
        return avatar['url'] as String?;
      }
    }
    return null;
  }

  factory CommentDto.fromJson(Map<String, dynamic> json) =>
      _$CommentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CommentDtoToJson(this);
}

/// Request body for creating a new comment.
@JsonSerializable(createFactory: false)
class CreateCommentRequest {
  const CreateCommentRequest({
    required this.post,
    required this.content,
  });

  final String post;
  final String content;

  Map<String, dynamic> toJson() => _$CreateCommentRequestToJson(this);
}
