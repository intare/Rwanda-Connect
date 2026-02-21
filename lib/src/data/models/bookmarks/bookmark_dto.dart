import 'package:json_annotation/json_annotation.dart';

import '../opportunities/opportunity_dto.dart';

part 'bookmark_dto.g.dart';

/// DTO for bookmark from Payload CMS API.
@JsonSerializable(createToJson: true)
class BookmarkDto {
  const BookmarkDto({
    required this.id,
    required this.user,
    required this.type,
    required this.itemId,
    this.opportunity,
    this.createdAt,
    this.updatedAt,
  });

  final dynamic id; // Can be int or String from Payload
  final dynamic user; // Can be user ID or populated user object
  @JsonKey(name: 'entityType')
  final String type;
  @JsonKey(name: 'entityId')
  final String itemId;
  final OpportunityDto? opportunity;
  final String? createdAt;
  final String? updatedAt;

  factory BookmarkDto.fromJson(Map<String, dynamic> json) =>
      _$BookmarkDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BookmarkDtoToJson(this);
}

/// Extension to get string ID and parsed dates.
extension BookmarkDtoX on BookmarkDto {
  String get idString => id.toString();

  String get userIdString {
    if (user is Map) {
      return (user as Map)['id']?.toString() ?? '';
    }
    return user.toString();
  }

  DateTime? get createdAtDateTime {
    if (createdAt == null) return null;
    return DateTime.tryParse(createdAt!);
  }
}

/// Request body for creating a bookmark.
@JsonSerializable(createFactory: false)
class CreateBookmarkRequest {
  const CreateBookmarkRequest({required this.type, required this.itemId});

  @JsonKey(name: 'entityType')
  final String type;
  @JsonKey(name: 'entityId')
  final String itemId;

  Map<String, dynamic> toJson() => _$CreateBookmarkRequestToJson(this);
}
