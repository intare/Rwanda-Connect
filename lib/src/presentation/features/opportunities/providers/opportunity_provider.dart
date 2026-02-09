import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/repositories/opportunity_repository_impl.dart';
import '../../../../domain/entities/opportunity.dart';
import '../../../../domain/repositories/opportunity_repository.dart';

/// State for the opportunities list.
class OpportunitiesState {
  const OpportunitiesState({
    this.opportunities = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.hasMore = true,
    this.currentPage = 1,
    this.selectedType,
    this.searchQuery,
    this.selectedLocation,
    this.sortOption = 'deadline:asc',
  });

  final List<Opportunity> opportunities;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final bool hasMore;
  final int currentPage;
  final OpportunityType? selectedType;
  final String? searchQuery;
  final String? selectedLocation;
  final String sortOption;

  OpportunitiesState copyWith({
    List<Opportunity>? opportunities,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    bool? hasMore,
    int? currentPage,
    OpportunityType? selectedType,
    String? searchQuery,
    String? selectedLocation,
    String? sortOption,
    bool clearType = false,
    bool clearSearch = false,
    bool clearLocation = false,
  }) {
    return OpportunitiesState(
      opportunities: opportunities ?? this.opportunities,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      selectedType: clearType ? null : (selectedType ?? this.selectedType),
      searchQuery: clearSearch ? null : (searchQuery ?? this.searchQuery),
      selectedLocation:
          clearLocation ? null : (selectedLocation ?? this.selectedLocation),
      sortOption: sortOption ?? this.sortOption,
    );
  }

  /// Check if any filters are active.
  bool get hasActiveFilters =>
      selectedType != null ||
      (searchQuery != null && searchQuery!.isNotEmpty) ||
      (selectedLocation != null && selectedLocation!.isNotEmpty);

  /// Get count of active filters.
  int get activeFilterCount {
    int count = 0;
    if (selectedType != null) count++;
    if (searchQuery != null && searchQuery!.isNotEmpty) count++;
    if (selectedLocation != null && selectedLocation!.isNotEmpty) count++;
    return count;
  }
}

/// Notifier for managing opportunities list state.
class OpportunitiesNotifier extends StateNotifier<OpportunitiesState> {
  OpportunitiesNotifier(this._repository) : super(const OpportunitiesState()) {
    loadOpportunities();
  }

  final OpportunityRepository _repository;
  static const int _pageSize = 20;

  /// Load initial opportunities or refresh.
  Future<void> loadOpportunities({bool refresh = false}) async {
    if (state.isLoading && !refresh) return;

    state = state.copyWith(
      isLoading: true,
      error: null,
      currentPage: 1,
      opportunities: refresh ? [] : state.opportunities,
    );

    final params = GetOpportunitiesParams(
      page: 1,
      limit: _pageSize,
      type: state.selectedType,
      search: state.searchQuery,
      location: state.selectedLocation,
      sort: state.sortOption,
    );

    final result = await _repository.getOpportunities(params);

    switch (result) {
      case OpportunitySuccess(:final data, :final hasMore):
        state = state.copyWith(
          opportunities: data,
          isLoading: false,
          hasMore: hasMore,
          currentPage: 1,
        );
      case OpportunityFailure(:final message):
        state = state.copyWith(
          isLoading: false,
          error: message,
        );
    }
  }

  /// Load more opportunities (pagination).
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;

    state = state.copyWith(isLoadingMore: true);

    final nextPage = state.currentPage + 1;
    final params = GetOpportunitiesParams(
      page: nextPage,
      limit: _pageSize,
      type: state.selectedType,
      search: state.searchQuery,
      location: state.selectedLocation,
      sort: state.sortOption,
    );

    final result = await _repository.getOpportunities(params);

    switch (result) {
      case OpportunitySuccess(:final data, :final hasMore):
        state = state.copyWith(
          opportunities: [...state.opportunities, ...data],
          isLoadingMore: false,
          hasMore: hasMore,
          currentPage: nextPage,
        );
      case OpportunityFailure(:final message):
        state = state.copyWith(
          isLoadingMore: false,
          error: message,
        );
    }
  }

  /// Filter by opportunity type.
  Future<void> filterByType(OpportunityType? type) async {
    if (state.selectedType == type) return;

    state = state.copyWith(
      selectedType: type,
      clearType: type == null,
      opportunities: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadOpportunities();
  }

  /// Search opportunities.
  Future<void> search(String? query) async {
    final trimmedQuery = query?.trim();
    if (state.searchQuery == trimmedQuery) return;

    state = state.copyWith(
      searchQuery: trimmedQuery,
      clearSearch: trimmedQuery == null || trimmedQuery.isEmpty,
      opportunities: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadOpportunities();
  }

  /// Filter by location.
  Future<void> filterByLocation(String? location) async {
    if (state.selectedLocation == location) return;

    state = state.copyWith(
      selectedLocation: location,
      clearLocation: location == null || location.isEmpty,
      opportunities: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadOpportunities();
  }

  /// Change sort option.
  Future<void> changeSort(String sortOption) async {
    if (state.sortOption == sortOption) return;

    state = state.copyWith(
      sortOption: sortOption,
      opportunities: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadOpportunities();
  }

  /// Clear all filters.
  Future<void> clearFilters() async {
    state = state.copyWith(
      clearType: true,
      clearSearch: true,
      clearLocation: true,
      opportunities: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadOpportunities();
  }

  /// Refresh the opportunities list.
  Future<void> refresh() async {
    await loadOpportunities(refresh: true);
  }

  /// Clear error state.
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Provider for OpportunitiesNotifier.
final opportunitiesProvider =
    StateNotifierProvider<OpportunitiesNotifier, OpportunitiesState>((ref) {
  final repository = ref.watch(opportunityRepositoryProvider);
  return OpportunitiesNotifier(repository);
});

/// Provider for opportunity types.
final opportunityTypesProvider = Provider<List<OpportunityType>>((ref) {
  return OpportunityType.values;
});

/// Provider for sort options.
final opportunitySortOptionsProvider =
    Provider<List<OpportunitySortOption>>((ref) {
  return OpportunitySortOption.values;
});

/// Provider for single opportunity detail.
final opportunityDetailProvider =
    FutureProvider.family<Opportunity?, String>((ref, id) async {
  final repository = ref.watch(opportunityRepositoryProvider);
  final result = await repository.getOpportunityById(id);

  return switch (result) {
    OpportunitySuccess(:final data) => data,
    OpportunityFailure() => null,
  };
});
