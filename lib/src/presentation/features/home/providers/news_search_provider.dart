import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/repositories/news_repository_impl.dart';
import '../../../../domain/entities/news.dart';
import '../../../../domain/repositories/news_repository.dart';

/// State for news search.
class NewsSearchState {
  const NewsSearchState({
    this.query = '',
    this.results = const [],
    this.isLoading = false,
    this.error,
    this.hasMore = false,
    this.currentPage = 1,
    this.hasSearched = false,
  });

  final String query;
  final List<News> results;
  final bool isLoading;
  final String? error;
  final bool hasMore;
  final int currentPage;
  final bool hasSearched;

  NewsSearchState copyWith({
    String? query,
    List<News>? results,
    bool? isLoading,
    String? error,
    bool? hasMore,
    int? currentPage,
    bool? hasSearched,
  }) {
    return NewsSearchState(
      query: query ?? this.query,
      results: results ?? this.results,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      hasSearched: hasSearched ?? this.hasSearched,
    );
  }
}

/// Notifier for managing news search state.
class NewsSearchNotifier extends StateNotifier<NewsSearchState> {
  NewsSearchNotifier(this._repository) : super(const NewsSearchState());

  final NewsRepository _repository;
  static const int _pageSize = 20;
  Timer? _debounceTimer;

  /// Search news with debouncing.
  void search(String query) {
    _debounceTimer?.cancel();

    if (query.isEmpty) {
      state = const NewsSearchState();
      return;
    }

    state = state.copyWith(query: query);

    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      _performSearch(query);
    });
  }

  /// Perform the actual search.
  Future<void> _performSearch(String query) async {
    if (query.isEmpty) return;

    state = state.copyWith(
      isLoading: true,
      error: null,
      currentPage: 1,
      hasSearched: true,
    );

    final params = GetNewsParams(
      page: 1,
      limit: _pageSize,
      search: query,
    );

    final result = await _repository.getNews(params);

    // Check if query changed while loading
    if (state.query != query) return;

    switch (result) {
      case NewsSuccess(:final data, :final hasMore):
        state = state.copyWith(
          results: data,
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

  /// Load more search results.
  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore || state.query.isEmpty) return;

    state = state.copyWith(isLoading: true);

    final nextPage = state.currentPage + 1;
    final params = GetNewsParams(
      page: nextPage,
      limit: _pageSize,
      search: state.query,
    );

    final result = await _repository.getNews(params);

    switch (result) {
      case NewsSuccess(:final data, :final hasMore):
        state = state.copyWith(
          results: [...state.results, ...data],
          isLoading: false,
          hasMore: hasMore,
          currentPage: nextPage,
        );
      case NewsFailure(:final message):
        state = state.copyWith(
          isLoading: false,
          error: message,
        );
    }
  }

  /// Clear search.
  void clear() {
    _debounceTimer?.cancel();
    state = const NewsSearchState();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}

/// Provider for NewsSearchNotifier.
final newsSearchProvider =
    StateNotifierProvider.autoDispose<NewsSearchNotifier, NewsSearchState>(
        (ref) {
  final repository = ref.watch(newsRepositoryProvider);
  return NewsSearchNotifier(repository);
});

/// Provider for recent searches (persisted locally).
final recentSearchesProvider = StateProvider<List<String>>((ref) => []);
