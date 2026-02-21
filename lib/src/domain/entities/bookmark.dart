import 'package:freezed_annotation/freezed_annotation.dart';

import 'opportunity.dart';

part 'bookmark.freezed.dart';

/// Domain entity representing a saved bookmark.
@freezed
class Bookmark with _$Bookmark {
  const Bookmark._();

  const factory Bookmark({
    required String id,
    required String userId,
    required BookmarkType type,
    required String itemId,
    required DateTime createdAt,
    /// The bookmarked opportunity (populated when type is opportunity).
    Opportunity? opportunity,
  }) = _Bookmark;
}

/// Types of items that can be bookmarked.
enum BookmarkType {
  opportunity('opportunity', 'Opportunity'),
  event('event', 'Event'),
  news('news', 'News');

  const BookmarkType(this.value, this.label);

  /// API value for this type.
  final String value;

  /// Display label for this type.
  final String label;

  /// Parse from API string value.
  static BookmarkType fromString(String value) {
    return BookmarkType.values.firstWhere(
      (e) => e.value.toLowerCase() == value.toLowerCase(),
      orElse: () => BookmarkType.opportunity,
    );
  }
}
