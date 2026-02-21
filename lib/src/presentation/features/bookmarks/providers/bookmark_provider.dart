import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/repositories/bookmark_repository_impl.dart';
import '../../../../domain/entities/bookmark.dart';
import '../../../../domain/repositories/bookmark_repository.dart';

/// State for the bookmarks list.
class BookmarksState {
  const BookmarksState({
    this.bookmarks = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.hasMore = true,
    this.currentPage = 1,
    this.selectedType,
  });

  final List<Bookmark> bookmarks;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final bool hasMore;
  final int currentPage;
  final BookmarkType? selectedType;

  BookmarksState copyWith({
    List<Bookmark>? bookmarks,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    bool? hasMore,
    int? currentPage,
    BookmarkType? selectedType,
    bool clearType = false,
  }) {
    return BookmarksState(
      bookmarks: bookmarks ?? this.bookmarks,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      selectedType: clearType ? null : (selectedType ?? this.selectedType),
    );
  }
}

/// Notifier for managing bookmarks list state.
class BookmarksNotifier extends StateNotifier<BookmarksState> {
  BookmarksNotifier(this._repository) : super(const BookmarksState()) {
    loadBookmarks();
  }

  final BookmarkRepository _repository;
  static const int _pageSize = 20;

  /// Load initial bookmarks or refresh.
  Future<void> loadBookmarks({bool refresh = false}) async {
    if (state.isLoading && !refresh) return;

    state = state.copyWith(
      isLoading: true,
      error: null,
      currentPage: 1,
      bookmarks: refresh ? [] : state.bookmarks,
    );

    final params = GetBookmarksParams(
      page: 1,
      limit: _pageSize,
      type: state.selectedType,
    );

    final result = await _repository.getBookmarks(params);

    switch (result) {
      case BookmarkSuccess(:final data, :final hasMore):
        state = state.copyWith(
          bookmarks: data,
          isLoading: false,
          hasMore: hasMore,
          currentPage: 1,
        );
      case BookmarkFailure(:final message):
        state = state.copyWith(
          isLoading: false,
          error: message,
        );
    }
  }

  /// Load more bookmarks (pagination).
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;

    state = state.copyWith(isLoadingMore: true);

    final nextPage = state.currentPage + 1;
    final params = GetBookmarksParams(
      page: nextPage,
      limit: _pageSize,
      type: state.selectedType,
    );

    final result = await _repository.getBookmarks(params);

    switch (result) {
      case BookmarkSuccess(:final data, :final hasMore):
        state = state.copyWith(
          bookmarks: [...state.bookmarks, ...data],
          isLoadingMore: false,
          hasMore: hasMore,
          currentPage: nextPage,
        );
      case BookmarkFailure(:final message):
        state = state.copyWith(
          isLoadingMore: false,
          error: message,
        );
    }
  }

  /// Filter by bookmark type.
  Future<void> filterByType(BookmarkType? type) async {
    if (state.selectedType == type) return;

    state = state.copyWith(
      selectedType: type,
      clearType: type == null,
      bookmarks: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadBookmarks();
  }

  /// Remove a bookmark from the list.
  void removeFromList(String bookmarkId) {
    state = state.copyWith(
      bookmarks: state.bookmarks.where((b) => b.id != bookmarkId).toList(),
    );
  }

  /// Refresh the bookmarks list.
  Future<void> refresh() async {
    await loadBookmarks(refresh: true);
  }

  /// Clear error state.
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Provider for BookmarksNotifier.
final bookmarksProvider =
    StateNotifierProvider<BookmarksNotifier, BookmarksState>((ref) {
  final repository = ref.watch(bookmarkRepositoryProvider);
  return BookmarksNotifier(repository);
});

/// State for individual item bookmark status.
class BookmarkStatusState {
  const BookmarkStatusState({
    this.isBookmarked = false,
    this.bookmarkId,
    this.isLoading = false,
    this.error,
  });

  final bool isBookmarked;
  final String? bookmarkId;
  final bool isLoading;
  final String? error;

  BookmarkStatusState copyWith({
    bool? isBookmarked,
    String? bookmarkId,
    bool? isLoading,
    String? error,
    bool clearBookmarkId = false,
  }) {
    return BookmarkStatusState(
      isBookmarked: isBookmarked ?? this.isBookmarked,
      bookmarkId: clearBookmarkId ? null : (bookmarkId ?? this.bookmarkId),
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Notifier for managing individual item bookmark status.
class BookmarkStatusNotifier extends StateNotifier<BookmarkStatusState> {
  BookmarkStatusNotifier(
    this._repository,
    this._itemId,
    this._type,
  ) : super(const BookmarkStatusState()) {
    _checkStatus();
  }

  final BookmarkRepository _repository;
  final String _itemId;
  final BookmarkType _type;

  /// Check if item is bookmarked.
  Future<void> _checkStatus() async {
    state = state.copyWith(isLoading: true);

    final result = await _repository.getBookmarkByItemId(_itemId, _type);

    switch (result) {
      case BookmarkSuccess(:final data):
        state = state.copyWith(
          isBookmarked: data != null,
          bookmarkId: data?.id,
          isLoading: false,
        );
      case BookmarkFailure(:final message):
        state = state.copyWith(
          isLoading: false,
          error: message,
        );
    }
  }

  /// Toggle bookmark status.
  Future<bool> toggle() async {
    if (state.isLoading) return state.isBookmarked;

    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.toggleBookmark(_itemId, _type);

    switch (result) {
      case BookmarkSuccess(:final data):
        final isNowBookmarked = data != null;
        state = state.copyWith(
          isBookmarked: isNowBookmarked,
          bookmarkId: data?.id,
          isLoading: false,
          clearBookmarkId: !isNowBookmarked,
        );
        return isNowBookmarked;
      case BookmarkFailure(:final message):
        state = state.copyWith(
          isLoading: false,
          error: message,
        );
        return state.isBookmarked;
    }
  }
}

/// Provider family for individual item bookmark status.
final bookmarkStatusProvider = StateNotifierProvider.family<
    BookmarkStatusNotifier, BookmarkStatusState, ({String itemId, BookmarkType type})>(
  (ref, params) {
    final repository = ref.watch(bookmarkRepositoryProvider);
    return BookmarkStatusNotifier(repository, params.itemId, params.type);
  },
);

/// Convenience provider for opportunity bookmark status.
final opportunityBookmarkStatusProvider = StateNotifierProvider.family<
    BookmarkStatusNotifier, BookmarkStatusState, String>(
  (ref, opportunityId) {
    final repository = ref.watch(bookmarkRepositoryProvider);
    return BookmarkStatusNotifier(
      repository,
      opportunityId,
      BookmarkType.opportunity,
    );
  },
);
