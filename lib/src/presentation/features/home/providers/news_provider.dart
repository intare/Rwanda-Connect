import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/repositories/news_repository_impl.dart';
import '../../../../domain/entities/news.dart';
import '../../../../domain/repositories/news_repository.dart';

/// State for the news feed.
class NewsFeedState {
  const NewsFeedState({
    this.news = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.hasMore = true,
    this.currentPage = 1,
    this.selectedCategory,
  });

  final List<News> news;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final bool hasMore;
  final int currentPage;
  final String? selectedCategory;

  NewsFeedState copyWith({
    List<News>? news,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    bool? hasMore,
    int? currentPage,
    String? selectedCategory,
  }) {
    return NewsFeedState(
      news: news ?? this.news,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

/// Notifier for managing news feed state.
class NewsFeedNotifier extends StateNotifier<NewsFeedState> {
  NewsFeedNotifier(this._repository) : super(const NewsFeedState()) {
    loadNews();
  }

  final NewsRepository _repository;
  static const int _pageSize = 20;

  /// Load initial news or refresh.
  Future<void> loadNews({bool refresh = false}) async {
    if (state.isLoading && !refresh) return;

    state = state.copyWith(
      isLoading: true,
      error: null,
      currentPage: 1,
      news: refresh ? [] : state.news,
    );

    final params = GetNewsParams(
      page: 1,
      limit: _pageSize,
      category: state.selectedCategory,
    );

    final result = await _repository.getNews(params);

    switch (result) {
      case NewsSuccess(:final data, :final hasMore):
        state = state.copyWith(
          news: data,
          isLoading: false,
          hasMore: hasMore,
          currentPage: 1,
        );
      case NewsFailure(:final message):
        state = state.copyWith(
          isLoading: false,
          error: message,
        );
    }
  }

  /// Load more news (pagination).
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;

    state = state.copyWith(isLoadingMore: true);

    final nextPage = state.currentPage + 1;
    final params = GetNewsParams(
      page: nextPage,
      limit: _pageSize,
      category: state.selectedCategory,
    );

    final result = await _repository.getNews(params);

    switch (result) {
      case NewsSuccess(:final data, :final hasMore):
        state = state.copyWith(
          news: [...state.news, ...data],
          isLoadingMore: false,
          hasMore: hasMore,
          currentPage: nextPage,
        );
      case NewsFailure(:final message):
        state = state.copyWith(
          isLoadingMore: false,
          error: message,
        );
    }
  }

  /// Filter by category.
  Future<void> filterByCategory(String? category) async {
    if (state.selectedCategory == category) return;

    state = state.copyWith(
      selectedCategory: category,
      news: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadNews();
  }

  /// Refresh the news feed.
  Future<void> refresh() async {
    await loadNews(refresh: true);
  }

  /// Clear error state.
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Provider for NewsFeedNotifier.
final newsFeedProvider =
    StateNotifierProvider<NewsFeedNotifier, NewsFeedState>((ref) {
  final repository = ref.watch(newsRepositoryProvider);
  return NewsFeedNotifier(repository);
});

/// Provider for available news categories.
final newsCategoriesProvider = Provider<List<String>>((ref) {
  return ['All', 'Economy', 'Investment', 'Events', 'Business', 'Policy'];
});

/// State for featured news.
class FeaturedNewsState {
  const FeaturedNewsState({
    this.news = const [],
    this.isLoading = false,
    this.error,
  });

  final List<News> news;
  final bool isLoading;
  final String? error;

  FeaturedNewsState copyWith({
    List<News>? news,
    bool? isLoading,
    String? error,
  }) {
    return FeaturedNewsState(
      news: news ?? this.news,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Notifier for managing featured news state.
class FeaturedNewsNotifier extends StateNotifier<FeaturedNewsState> {
  FeaturedNewsNotifier(this._repository) : super(const FeaturedNewsState()) {
    loadFeaturedNews();
  }

  final NewsRepository _repository;

  /// Load featured news.
  Future<void> loadFeaturedNews() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getFeaturedNews(limit: 5);

    switch (result) {
      case NewsSuccess(:final data):
        state = state.copyWith(
          news: data,
          isLoading: false,
        );
      case NewsFailure(:final message):
        state = state.copyWith(
          isLoading: false,
          error: message,
        );
    }
  }

  /// Refresh featured news.
  Future<void> refresh() async {
    state = state.copyWith(news: []);
    await loadFeaturedNews();
  }
}

/// Provider for FeaturedNewsNotifier.
final featuredNewsProvider =
    StateNotifierProvider<FeaturedNewsNotifier, FeaturedNewsState>((ref) {
  final repository = ref.watch(newsRepositoryProvider);
  return FeaturedNewsNotifier(repository);
});
