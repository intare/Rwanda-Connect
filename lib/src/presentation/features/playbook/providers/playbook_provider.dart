import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/repositories/playbook_repository_impl.dart';
import '../../../../domain/entities/playbook.dart';
import '../../../../domain/repositories/playbook_repository.dart';

/// State for the playbook content list.
class PlaybookState {
  const PlaybookState({
    this.content = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.hasMore = true,
    this.currentPage = 1,
    this.selectedCategory,
    this.selectedType,
    this.selectedDifficulty,
    this.searchQuery,
    this.sortOption = 'createdAt:desc',
  });

  final List<PlaybookContent> content;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final bool hasMore;
  final int currentPage;
  final PlaybookCategory? selectedCategory;
  final PlaybookContentType? selectedType;
  final PlaybookDifficulty? selectedDifficulty;
  final String? searchQuery;
  final String sortOption;

  PlaybookState copyWith({
    List<PlaybookContent>? content,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    bool? hasMore,
    int? currentPage,
    PlaybookCategory? selectedCategory,
    PlaybookContentType? selectedType,
    PlaybookDifficulty? selectedDifficulty,
    String? searchQuery,
    String? sortOption,
    bool clearCategory = false,
    bool clearType = false,
    bool clearDifficulty = false,
    bool clearSearch = false,
  }) {
    return PlaybookState(
      content: content ?? this.content,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      selectedCategory:
          clearCategory ? null : (selectedCategory ?? this.selectedCategory),
      selectedType: clearType ? null : (selectedType ?? this.selectedType),
      selectedDifficulty:
          clearDifficulty ? null : (selectedDifficulty ?? this.selectedDifficulty),
      searchQuery: clearSearch ? null : (searchQuery ?? this.searchQuery),
      sortOption: sortOption ?? this.sortOption,
    );
  }

  /// Check if any filters are active.
  bool get hasActiveFilters =>
      selectedCategory != null ||
      selectedType != null ||
      selectedDifficulty != null ||
      (searchQuery != null && searchQuery!.isNotEmpty);
}

/// Notifier for managing playbook content list state.
class PlaybookNotifier extends StateNotifier<PlaybookState> {
  PlaybookNotifier(this._repository) : super(const PlaybookState()) {
    loadContent();
  }

  final PlaybookRepository _repository;
  static const int _pageSize = 20;

  /// Load initial content or refresh.
  Future<void> loadContent({bool refresh = false}) async {
    if (state.isLoading && !refresh) return;

    state = state.copyWith(
      isLoading: true,
      error: null,
      currentPage: 1,
      content: refresh ? [] : state.content,
    );

    final params = GetPlaybookParams(
      page: 1,
      limit: _pageSize,
      categoryId: state.selectedCategory?.id,
      type: state.selectedType,
      difficulty: state.selectedDifficulty,
      search: state.searchQuery,
      sort: state.sortOption,
    );

    final result = await _repository.getContent(params);

    switch (result) {
      case PlaybookSuccess(:final data, :final hasMore):
        state = state.copyWith(
          content: data,
          isLoading: false,
          hasMore: hasMore,
          currentPage: 1,
        );
      case PlaybookFailure(:final message):
        state = state.copyWith(
          isLoading: false,
          error: message,
        );
    }
  }

  /// Load more content (pagination).
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;

    state = state.copyWith(isLoadingMore: true);

    final nextPage = state.currentPage + 1;
    final params = GetPlaybookParams(
      page: nextPage,
      limit: _pageSize,
      categoryId: state.selectedCategory?.id,
      type: state.selectedType,
      difficulty: state.selectedDifficulty,
      search: state.searchQuery,
      sort: state.sortOption,
    );

    final result = await _repository.getContent(params);

    switch (result) {
      case PlaybookSuccess(:final data, :final hasMore):
        state = state.copyWith(
          content: [...state.content, ...data],
          isLoadingMore: false,
          hasMore: hasMore,
          currentPage: nextPage,
        );
      case PlaybookFailure(:final message):
        state = state.copyWith(
          isLoadingMore: false,
          error: message,
        );
    }
  }

  /// Filter by category.
  Future<void> filterByCategory(PlaybookCategory? category) async {
    if (state.selectedCategory?.id == category?.id) return;

    state = state.copyWith(
      selectedCategory: category,
      clearCategory: category == null,
      content: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadContent();
  }

  /// Filter by content type.
  Future<void> filterByType(PlaybookContentType? type) async {
    if (state.selectedType == type) return;

    state = state.copyWith(
      selectedType: type,
      clearType: type == null,
      content: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadContent();
  }

  /// Filter by difficulty.
  Future<void> filterByDifficulty(PlaybookDifficulty? difficulty) async {
    if (state.selectedDifficulty == difficulty) return;

    state = state.copyWith(
      selectedDifficulty: difficulty,
      clearDifficulty: difficulty == null,
      content: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadContent();
  }

  /// Search content.
  Future<void> search(String? query) async {
    final trimmedQuery = query?.trim();
    if (state.searchQuery == trimmedQuery) return;

    state = state.copyWith(
      searchQuery: trimmedQuery,
      clearSearch: trimmedQuery == null || trimmedQuery.isEmpty,
      content: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadContent();
  }

  /// Change sort option.
  Future<void> changeSort(String sortOption) async {
    if (state.sortOption == sortOption) return;

    state = state.copyWith(
      sortOption: sortOption,
      content: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadContent();
  }

  /// Clear all filters.
  Future<void> clearFilters() async {
    state = state.copyWith(
      clearCategory: true,
      clearType: true,
      clearDifficulty: true,
      clearSearch: true,
      content: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadContent();
  }

  /// Refresh the content list.
  Future<void> refresh() async {
    await loadContent(refresh: true);
  }
}

/// Provider for PlaybookNotifier.
final playbookProvider =
    StateNotifierProvider<PlaybookNotifier, PlaybookState>((ref) {
  final repository = ref.watch(playbookRepositoryProvider);
  return PlaybookNotifier(repository);
});

/// Provider for single content detail.
final playbookContentProvider =
    FutureProvider.family<PlaybookContent?, String>((ref, id) async {
  final repository = ref.watch(playbookRepositoryProvider);
  final result = await repository.getContentById(id);

  return switch (result) {
    PlaybookSuccess(:final data) => data,
    PlaybookFailure() => null,
  };
});

/// Provider for featured content.
final featuredPlaybookProvider =
    FutureProvider<List<PlaybookContent>>((ref) async {
  final repository = ref.watch(playbookRepositoryProvider);
  final result = await repository.getFeaturedContent();

  return switch (result) {
    PlaybookSuccess(:final data) => data,
    PlaybookFailure() => [],
  };
});

/// Provider for categories.
final playbookCategoriesProvider =
    FutureProvider<List<PlaybookCategory>>((ref) async {
  final repository = ref.watch(playbookRepositoryProvider);
  final result = await repository.getCategories();

  return switch (result) {
    PlaybookSuccess(:final data) => data,
    PlaybookFailure() => [],
  };
});

/// Provider for content like status.
final contentLikeProvider =
    FutureProvider.family<bool, String>((ref, contentId) async {
  final repository = ref.watch(playbookRepositoryProvider);
  final result = await repository.isContentLiked(contentId);

  return switch (result) {
    PlaybookSuccess(:final data) => data,
    PlaybookFailure() => false,
  };
});

/// Sort options for playbook content.
enum PlaybookSortOption {
  newest('createdAt:desc', 'Newest First'),
  oldest('createdAt:asc', 'Oldest First'),
  popular('viewCount:desc', 'Most Popular'),
  mostLiked('likeCount:desc', 'Most Liked');

  const PlaybookSortOption(this.value, this.label);
  final String value;
  final String label;
}
