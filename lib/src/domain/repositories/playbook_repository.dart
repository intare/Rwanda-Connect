import '../entities/playbook.dart';

/// Result type for playbook operations.
sealed class PlaybookResult<T> {
  const PlaybookResult();
}

/// Success result with data.
class PlaybookSuccess<T> extends PlaybookResult<T> {
  const PlaybookSuccess(this.data, {this.hasMore = false});
  final T data;
  final bool hasMore;
}

/// Failure result with error message.
class PlaybookFailure<T> extends PlaybookResult<T> {
  const PlaybookFailure(this.message);
  final String message;
}

/// Parameters for fetching playbook content list.
class GetPlaybookParams {
  const GetPlaybookParams({
    this.page = 1,
    this.limit = 20,
    this.categoryId,
    this.type,
    this.difficulty,
    this.search,
    this.isFeatured,
    this.isPremium,
    this.sort = 'createdAt:desc',
  });

  final int page;
  final int limit;
  final String? categoryId;
  final PlaybookContentType? type;
  final PlaybookDifficulty? difficulty;
  final String? search;
  final bool? isFeatured;
  final bool? isPremium;
  final String sort;
}

/// Repository interface for playbook operations.
abstract class PlaybookRepository {
  /// Get paginated list of playbook content.
  Future<PlaybookResult<List<PlaybookContent>>> getContent(
    GetPlaybookParams params,
  );

  /// Get a single content item by ID.
  Future<PlaybookResult<PlaybookContent>> getContentById(String id);

  /// Get featured content.
  Future<PlaybookResult<List<PlaybookContent>>> getFeaturedContent({
    int limit = 5,
  });

  /// Get all categories.
  Future<PlaybookResult<List<PlaybookCategory>>> getCategories();

  /// Get content by category.
  Future<PlaybookResult<List<PlaybookContent>>> getContentByCategory(
    String categoryId, {
    int page = 1,
    int limit = 20,
  });

  /// Like a content item.
  Future<PlaybookResult<void>> likeContent(String contentId);

  /// Unlike a content item.
  Future<PlaybookResult<void>> unlikeContent(String contentId);

  /// Check if content is liked by current user.
  Future<PlaybookResult<bool>> isContentLiked(String contentId);

  /// Get user's liked content.
  Future<PlaybookResult<List<PlaybookContent>>> getLikedContent({
    int page = 1,
    int limit = 20,
  });

  /// Record a view for content.
  Future<PlaybookResult<void>> recordView(String contentId);
}
