import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/repositories/post_repository_impl.dart';
import '../../../../domain/entities/post.dart';
import '../../../../domain/repositories/post_repository.dart';

/// State for the posts list.
class PostsState {
  const PostsState({
    this.posts = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isCreatingPost = false,
    this.error,
    this.hasMore = true,
    this.currentPage = 1,
    this.searchQuery,
    this.sortOption = 'createdAt:desc',
  });

  final List<Post> posts;
  final bool isLoading;
  final bool isLoadingMore;
  final bool isCreatingPost;
  final String? error;
  final bool hasMore;
  final int currentPage;
  final String? searchQuery;
  final String sortOption;

  PostsState copyWith({
    List<Post>? posts,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isCreatingPost,
    String? error,
    bool? hasMore,
    int? currentPage,
    String? searchQuery,
    String? sortOption,
    bool clearSearch = false,
  }) {
    return PostsState(
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isCreatingPost: isCreatingPost ?? this.isCreatingPost,
      error: error,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      searchQuery: clearSearch ? null : (searchQuery ?? this.searchQuery),
      sortOption: sortOption ?? this.sortOption,
    );
  }

  /// Check if search filter is active.
  bool get hasActiveFilters =>
      searchQuery != null && searchQuery!.isNotEmpty;
}

/// Notifier for managing posts list state.
class PostsNotifier extends StateNotifier<PostsState> {
  PostsNotifier(this._repository) : super(const PostsState()) {
    loadPosts();
  }

  final PostRepository _repository;
  static const int _pageSize = 20;

  /// Load initial posts or refresh.
  Future<void> loadPosts({bool refresh = false}) async {
    if (state.isLoading && !refresh) return;

    state = state.copyWith(
      isLoading: true,
      error: null,
      currentPage: 1,
      posts: refresh ? [] : state.posts,
    );

    final params = GetPostsParams(
      page: 1,
      limit: _pageSize,
      search: state.searchQuery,
      sort: state.sortOption,
    );

    final result = await _repository.getPosts(params);

    switch (result) {
      case PostSuccess(:final data, :final hasMore):
        state = state.copyWith(
          posts: data,
          isLoading: false,
          hasMore: hasMore,
          currentPage: 1,
        );
      case PostFailure(:final message):
        state = state.copyWith(
          isLoading: false,
          error: message,
        );
    }
  }

  /// Load more posts (pagination).
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;

    state = state.copyWith(isLoadingMore: true);

    final nextPage = state.currentPage + 1;
    final params = GetPostsParams(
      page: nextPage,
      limit: _pageSize,
      search: state.searchQuery,
      sort: state.sortOption,
    );

    final result = await _repository.getPosts(params);

    switch (result) {
      case PostSuccess(:final data, :final hasMore):
        state = state.copyWith(
          posts: [...state.posts, ...data],
          isLoadingMore: false,
          hasMore: hasMore,
          currentPage: nextPage,
        );
      case PostFailure(:final message):
        state = state.copyWith(
          isLoadingMore: false,
          error: message,
        );
    }
  }

  /// Search posts.
  Future<void> search(String? query) async {
    final trimmedQuery = query?.trim();
    if (state.searchQuery == trimmedQuery) return;

    state = state.copyWith(
      searchQuery: trimmedQuery,
      clearSearch: trimmedQuery == null || trimmedQuery.isEmpty,
      posts: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadPosts();
  }

  /// Change sort option.
  Future<void> changeSort(String sortOption) async {
    if (state.sortOption == sortOption) return;

    state = state.copyWith(
      sortOption: sortOption,
      posts: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadPosts();
  }

  /// Create a new post.
  Future<bool> createPost(String content) async {
    if (state.isCreatingPost) return false;

    state = state.copyWith(isCreatingPost: true, error: null);

    final result = await _repository.createPost(content);

    switch (result) {
      case PostSuccess(:final data):
        // Add new post to the top of the list
        state = state.copyWith(
          posts: [data, ...state.posts],
          isCreatingPost: false,
        );
        return true;
      case PostFailure(:final message):
        state = state.copyWith(
          isCreatingPost: false,
          error: message,
        );
        return false;
    }
  }

  /// Toggle like on a post.
  Future<void> toggleLike(String postId) async {
    final postIndex = state.posts.indexWhere((p) => p.id == postId);
    if (postIndex == -1) return;

    final post = state.posts[postIndex];
    final newIsLiked = !post.isLiked;
    final newLikeCount = post.likeCount + (newIsLiked ? 1 : -1);

    // Optimistic update
    final updatedPost = Post(
      id: post.id,
      authorId: post.authorId,
      authorName: post.authorName,
      content: post.content,
      createdAt: post.createdAt,
      authorAvatarUrl: post.authorAvatarUrl,
      likeCount: newLikeCount,
      commentCount: post.commentCount,
      isLiked: newIsLiked,
    );

    final updatedPosts = [...state.posts];
    updatedPosts[postIndex] = updatedPost;
    state = state.copyWith(posts: updatedPosts);

    // Make API call
    final result = newIsLiked
        ? await _repository.likePost(postId)
        : await _repository.unlikePost(postId);

    // Revert on failure
    if (result is PostFailure<bool>) {
      final revertedPosts = [...state.posts];
      revertedPosts[postIndex] = post;
      state = state.copyWith(posts: revertedPosts, error: result.message);
    }
  }

  /// Refresh the posts list.
  Future<void> refresh() async {
    await loadPosts(refresh: true);
  }

  /// Clear error state.
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Provider for PostsNotifier.
final postsProvider = StateNotifierProvider<PostsNotifier, PostsState>((ref) {
  final repository = ref.watch(postRepositoryProvider);
  return PostsNotifier(repository);
});

/// Provider for sort options.
final postSortOptionsProvider = Provider<List<PostSortOption>>((ref) {
  return PostSortOption.values;
});
