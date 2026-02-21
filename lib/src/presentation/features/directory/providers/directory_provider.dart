import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/repositories/directory_repository_impl.dart';
import '../../../../domain/entities/business.dart';
import '../../../../domain/repositories/directory_repository.dart';

/// State for the businesses list.
class DirectoryState {
  const DirectoryState({
    this.businesses = const [],
    this.featuredBusinesses = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.hasMore = true,
    this.currentPage = 1,
    this.selectedCategory,
    this.searchQuery,
    this.selectedCity,
    this.sortOption = 'name:asc',
  });

  final List<Business> businesses;
  final List<Business> featuredBusinesses;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final bool hasMore;
  final int currentPage;
  final BusinessCategory? selectedCategory;
  final String? searchQuery;
  final String? selectedCity;
  final String sortOption;

  DirectoryState copyWith({
    List<Business>? businesses,
    List<Business>? featuredBusinesses,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    bool? hasMore,
    int? currentPage,
    BusinessCategory? selectedCategory,
    String? searchQuery,
    String? selectedCity,
    String? sortOption,
    bool clearCategory = false,
    bool clearSearch = false,
    bool clearCity = false,
  }) {
    return DirectoryState(
      businesses: businesses ?? this.businesses,
      featuredBusinesses: featuredBusinesses ?? this.featuredBusinesses,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      selectedCategory:
          clearCategory ? null : (selectedCategory ?? this.selectedCategory),
      searchQuery: clearSearch ? null : (searchQuery ?? this.searchQuery),
      selectedCity: clearCity ? null : (selectedCity ?? this.selectedCity),
      sortOption: sortOption ?? this.sortOption,
    );
  }

  /// Check if any filters are active.
  bool get hasActiveFilters =>
      selectedCategory != null ||
      (searchQuery != null && searchQuery!.isNotEmpty) ||
      (selectedCity != null && selectedCity!.isNotEmpty);

  /// Get count of active filters.
  int get activeFilterCount {
    int count = 0;
    if (selectedCategory != null) count++;
    if (searchQuery != null && searchQuery!.isNotEmpty) count++;
    if (selectedCity != null && selectedCity!.isNotEmpty) count++;
    return count;
  }
}

/// Notifier for managing businesses list state.
class DirectoryNotifier extends StateNotifier<DirectoryState> {
  DirectoryNotifier(this._repository) : super(const DirectoryState()) {
    _loadInitialData();
  }

  final DirectoryRepository _repository;
  static const int _pageSize = 20;

  /// Load initial data including featured businesses.
  Future<void> _loadInitialData() async {
    await Future.wait([
      loadBusinesses(),
      _loadFeaturedBusinesses(),
    ]);
  }

  /// Load featured businesses.
  Future<void> _loadFeaturedBusinesses() async {
    final result = await _repository.getFeaturedBusinesses(limit: 5);

    if (result is DirectorySuccess<List<Business>>) {
      state = state.copyWith(featuredBusinesses: result.data);
    }
  }

  /// Load initial businesses or refresh.
  Future<void> loadBusinesses({bool refresh = false}) async {
    if (state.isLoading && !refresh) return;

    state = state.copyWith(
      isLoading: true,
      error: null,
      currentPage: 1,
      businesses: refresh ? [] : state.businesses,
    );

    final params = GetBusinessesParams(
      page: 1,
      limit: _pageSize,
      category: state.selectedCategory,
      search: state.searchQuery,
      city: state.selectedCity,
      sort: state.sortOption,
    );

    final result = await _repository.getBusinesses(params);

    switch (result) {
      case DirectorySuccess(:final data, :final hasMore):
        state = state.copyWith(
          businesses: data,
          isLoading: false,
          hasMore: hasMore,
          currentPage: 1,
        );
      case DirectoryFailure(:final message):
        state = state.copyWith(
          isLoading: false,
          error: message,
        );
    }
  }

  /// Load more businesses (pagination).
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;

    state = state.copyWith(isLoadingMore: true);

    final nextPage = state.currentPage + 1;
    final params = GetBusinessesParams(
      page: nextPage,
      limit: _pageSize,
      category: state.selectedCategory,
      search: state.searchQuery,
      city: state.selectedCity,
      sort: state.sortOption,
    );

    final result = await _repository.getBusinesses(params);

    switch (result) {
      case DirectorySuccess(:final data, :final hasMore):
        state = state.copyWith(
          businesses: [...state.businesses, ...data],
          isLoadingMore: false,
          hasMore: hasMore,
          currentPage: nextPage,
        );
      case DirectoryFailure(:final message):
        state = state.copyWith(
          isLoadingMore: false,
          error: message,
        );
    }
  }

  /// Filter by business category.
  Future<void> filterByCategory(BusinessCategory? category) async {
    if (state.selectedCategory == category) return;

    state = state.copyWith(
      selectedCategory: category,
      clearCategory: category == null,
      businesses: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadBusinesses();
  }

  /// Search businesses.
  Future<void> search(String? query) async {
    final trimmedQuery = query?.trim();
    if (state.searchQuery == trimmedQuery) return;

    state = state.copyWith(
      searchQuery: trimmedQuery,
      clearSearch: trimmedQuery == null || trimmedQuery.isEmpty,
      businesses: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadBusinesses();
  }

  /// Filter by city.
  Future<void> filterByCity(String? city) async {
    if (state.selectedCity == city) return;

    state = state.copyWith(
      selectedCity: city,
      clearCity: city == null || city.isEmpty,
      businesses: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadBusinesses();
  }

  /// Change sort option.
  Future<void> changeSort(String sortOption) async {
    if (state.sortOption == sortOption) return;

    state = state.copyWith(
      sortOption: sortOption,
      businesses: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadBusinesses();
  }

  /// Clear all filters.
  Future<void> clearFilters() async {
    state = state.copyWith(
      clearCategory: true,
      clearSearch: true,
      clearCity: true,
      businesses: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadBusinesses();
  }

  /// Refresh the businesses list.
  Future<void> refresh() async {
    await Future.wait([
      loadBusinesses(refresh: true),
      _loadFeaturedBusinesses(),
    ]);
  }

  /// Clear error state.
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Provider for DirectoryNotifier.
final directoryProvider =
    StateNotifierProvider<DirectoryNotifier, DirectoryState>((ref) {
  final repository = ref.watch(directoryRepositoryProvider);
  return DirectoryNotifier(repository);
});

/// Provider for business categories.
final businessCategoriesProvider = Provider<List<BusinessCategory>>((ref) {
  return BusinessCategory.values;
});

/// Provider for single business detail.
final businessDetailProvider =
    FutureProvider.family<Business?, String>((ref, id) async {
  final repository = ref.watch(directoryRepositoryProvider);
  final result = await repository.getBusinessById(id);

  return switch (result) {
    DirectorySuccess(:final data) => data,
    DirectoryFailure() => null,
  };
});

/// Provider for available cities.
final citiesProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.watch(directoryRepositoryProvider);
  final result = await repository.getCities();

  return switch (result) {
    DirectorySuccess(:final data) => data,
    DirectoryFailure() => [],
  };
});
