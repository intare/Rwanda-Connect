import 'package:json_annotation/json_annotation.dart';

part 'post_dto.g.dart';

/// Data transfer object for Post from Payload CMS API.
@JsonSerializable()
class PostDto {
  const PostDto({
    required this.id,
    required this.content,
    this.author,
    this.isPinned,
    this.likesCount,
    this.commentsCount,
    this.createdAt,
    this.updatedAt,
  });

  final dynamic id; // Can be int or String from Payload
  final String content;
  final dynamic author; // Can be object (populated) or ID
  final bool? isPinned;
  final int? likesCount;
  final int? commentsCount;
  final String? createdAt;
  final String? updatedAt;

  String get idString => id.toString();

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

  factory PostDto.fromJson(Map<String, dynamic> json) =>
      _$PostDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PostDtoToJson(this);
}

/// Request body for creating a new post.
@JsonSerializable()
class CreatePostRequest {
  const CreatePostRequest({required this.content});

  final String content;

  factory CreatePostRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePostRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePostRequestToJson(this);
}
