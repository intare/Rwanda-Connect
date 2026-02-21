import '../entities/comment.dart';
import '../entities/post.dart';

/// Result type for post operations.
sealed class PostResult<T> {
  const PostResult();
}

class PostSuccess<T> extends PostResult<T> {
  const PostSuccess(this.data, {this.hasMore = false, this.isFromCache = false});
  final T data;
  final bool hasMore;
  final bool isFromCache;
}

class PostFailure<T> extends PostResult<T> {
  const PostFailure(this.message);
  final String message;
}

/// Parameters for fetching posts.
class GetPostsParams {
  const GetPostsParams({
    this.page = 1,
    this.limit = 20,
    this.search,
    this.sort = 'createdAt:desc',
  });

  final int page;
  final int limit;
  final String? search;
  final String sort;

  GetPostsParams copyWith({
    int? page,
    int? limit,
    String? search,
    String? sort,
    bool clearSearch = false,
  }) {
    return GetPostsParams(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      search: clearSearch ? null : (search ?? this.search),
      sort: sort ?? this.sort,
    );
  }

  Map<String, dynamic> toQueryParams() {
    return {
      'page': page,
      'limit': limit,
      if (search != null && search!.isNotEmpty) 'search': search,
      'sort': sort,
    };
  }

  /// Check if search filter is active.
  bool get hasActiveFilters => search != null && search!.isNotEmpty;
}

/// Repository interface for post operations.
abstract class PostRepository {
  /// Get paginated list of posts.
  Future<PostResult<List<Post>>> getPosts(GetPostsParams params);

  /// Get a single post by ID.
  Future<PostResult<Post>> getPostById(String id);

  /// Create a new post.
  Future<PostResult<Post>> createPost(String content);

  /// Update a post.
  Future<PostResult<Post>> updatePost(String postId, String content);

  /// Delete a post.
  Future<PostResult<void>> deletePost(String postId);

  /// Like a post.
  Future<PostResult<bool>> likePost(String postId);

  /// Unlike a post.
  Future<PostResult<bool>> unlikePost(String postId);

  /// Get comments for a post.
  Future<PostResult<List<Comment>>> getComments(GetCommentsParams params);

  /// Create a comment on a post.
  Future<PostResult<Comment>> createComment(String postId, String content);

  /// Delete a comment.
  Future<PostResult<void>> deleteComment(String commentId);
}

/// Parameters for fetching comments.
class GetCommentsParams {
  const GetCommentsParams({
    required this.postId,
    this.page = 1,
    this.limit = 20,
  });

  final String postId;
  final int page;
  final int limit;
}
