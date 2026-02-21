import '../entities/bookmark.dart';

/// Result type for bookmark operations.
sealed class BookmarkResult<T> {
  const BookmarkResult();
}

/// Successful bookmark result.
class BookmarkSuccess<T> extends BookmarkResult<T> {
  const BookmarkSuccess(this.data, {this.hasMore = false});

  final T data;
  final bool hasMore;
}

/// Failed bookmark result.
class BookmarkFailure<T> extends BookmarkResult<T> {
  const BookmarkFailure(this.message);

  final String message;
}

/// Parameters for getting bookmarks.
class GetBookmarksParams {
  const GetBookmarksParams({
    this.page = 1,
    this.limit = 20,
    this.type,
  });

  final int page;
  final int limit;
  final BookmarkType? type;
}

/// Repository interface for bookmark operations.
abstract class BookmarkRepository {
  /// Get paginated list of user's bookmarks.
  Future<BookmarkResult<List<Bookmark>>> getBookmarks(GetBookmarksParams params);

  /// Check if an item is bookmarked.
  Future<BookmarkResult<Bookmark?>> getBookmarkByItemId(
    String itemId,
    BookmarkType type,
  );

  /// Check if an item is bookmarked (returns boolean).
  Future<bool> isBookmarked(String itemId, BookmarkType type);

  /// Add a bookmark.
  Future<BookmarkResult<Bookmark>> addBookmark(
    String itemId,
    BookmarkType type,
  );

  /// Remove a bookmark by ID.
  Future<BookmarkResult<void>> removeBookmark(String bookmarkId);

  /// Toggle bookmark status for an item.
  /// Returns the bookmark if created, null if removed.
  Future<BookmarkResult<Bookmark?>> toggleBookmark(
    String itemId,
    BookmarkType type,
  );
}
