import '../../domain/entities/bookmark.dart';
import '../mappers/opportunity_mapper.dart';
import '../models/bookmarks/bookmark_dto.dart';

/// Mapper to convert between BookmarkDto and Bookmark domain entity.
extension BookmarkMapper on BookmarkDto {
  /// Convert DTO to domain entity.
  Bookmark toEntity() {
    return Bookmark(
      id: id.toString(),
      userId: userIdString,
      type: BookmarkType.fromString(type),
      itemId: itemId,
      createdAt: createdAtDateTime ?? DateTime.now(),
      opportunity: opportunity?.toEntity(),
    );
  }
}

/// Mapper to convert list of DTOs to entities.
extension BookmarkDtoListMapper on List<BookmarkDto> {
  /// Convert list of DTOs to domain entities.
  List<Bookmark> toEntities() {
    return map((dto) => dto.toEntity()).toList();
  }
}
