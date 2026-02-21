import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/repositories/property_repository_impl.dart';
import '../../../../domain/entities/bid.dart';
import '../../../../domain/entities/property.dart';
import '../../../../domain/repositories/property_repository.dart';

/// State for the properties list.
class PropertiesState {
  const PropertiesState({
    this.properties = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.hasMore = true,
    this.currentPage = 1,
    this.selectedType,
    this.selectedLocation,
    this.searchQuery,
    this.minPrice,
    this.maxPrice,
    this.sortOption = 'createdAt:desc',
  });

  final List<Property> properties;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final bool hasMore;
  final int currentPage;
  final PropertyType? selectedType;
  final String? selectedLocation;
  final String? searchQuery;
  final double? minPrice;
  final double? maxPrice;
  final String sortOption;

  PropertiesState copyWith({
    List<Property>? properties,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    bool? hasMore,
    int? currentPage,
    PropertyType? selectedType,
    String? selectedLocation,
    String? searchQuery,
    double? minPrice,
    double? maxPrice,
    String? sortOption,
    bool clearType = false,
    bool clearLocation = false,
    bool clearSearch = false,
    bool clearPrice = false,
  }) {
    return PropertiesState(
      properties: properties ?? this.properties,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      selectedType: clearType ? null : (selectedType ?? this.selectedType),
      selectedLocation:
          clearLocation ? null : (selectedLocation ?? this.selectedLocation),
      searchQuery: clearSearch ? null : (searchQuery ?? this.searchQuery),
      minPrice: clearPrice ? null : (minPrice ?? this.minPrice),
      maxPrice: clearPrice ? null : (maxPrice ?? this.maxPrice),
      sortOption: sortOption ?? this.sortOption,
    );
  }

  /// Check if any filters are active.
  bool get hasActiveFilters =>
      selectedType != null ||
      selectedLocation != null ||
      (searchQuery != null && searchQuery!.isNotEmpty) ||
      minPrice != null ||
      maxPrice != null;
}

/// Notifier for managing properties list state.
class PropertiesNotifier extends StateNotifier<PropertiesState> {
  PropertiesNotifier(this._repository) : super(const PropertiesState()) {
    loadProperties();
  }

  final PropertyRepository _repository;
  static const int _pageSize = 20;

  /// Load initial properties or refresh.
  Future<void> loadProperties({bool refresh = false}) async {
    if (state.isLoading && !refresh) return;

    state = state.copyWith(
      isLoading: true,
      error: null,
      currentPage: 1,
      properties: refresh ? [] : state.properties,
    );

    final params = GetPropertiesParams(
      page: 1,
      limit: _pageSize,
      type: state.selectedType,
      location: state.selectedLocation,
      search: state.searchQuery,
      minPrice: state.minPrice,
      maxPrice: state.maxPrice,
      sort: state.sortOption,
    );

    final result = await _repository.getProperties(params);

    switch (result) {
      case PropertySuccess(:final data, :final hasMore):
        state = state.copyWith(
          properties: data,
          isLoading: false,
          hasMore: hasMore,
          currentPage: 1,
        );
      case PropertyFailure(:final message):
        state = state.copyWith(
          isLoading: false,
          error: message,
        );
    }
  }

  /// Load more properties (pagination).
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;

    state = state.copyWith(isLoadingMore: true);

    final nextPage = state.currentPage + 1;
    final params = GetPropertiesParams(
      page: nextPage,
      limit: _pageSize,
      type: state.selectedType,
      location: state.selectedLocation,
      search: state.searchQuery,
      minPrice: state.minPrice,
      maxPrice: state.maxPrice,
      sort: state.sortOption,
    );

    final result = await _repository.getProperties(params);

    switch (result) {
      case PropertySuccess(:final data, :final hasMore):
        state = state.copyWith(
          properties: [...state.properties, ...data],
          isLoadingMore: false,
          hasMore: hasMore,
          currentPage: nextPage,
        );
      case PropertyFailure(:final message):
        state = state.copyWith(
          isLoadingMore: false,
          error: message,
        );
    }
  }

  /// Filter by property type.
  Future<void> filterByType(PropertyType? type) async {
    if (state.selectedType == type) return;

    state = state.copyWith(
      selectedType: type,
      clearType: type == null,
      properties: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadProperties();
  }

  /// Filter by location.
  Future<void> filterByLocation(String? location) async {
    final trimmedLocation = location?.trim();
    if (state.selectedLocation == trimmedLocation) return;

    state = state.copyWith(
      selectedLocation: trimmedLocation,
      clearLocation: trimmedLocation == null || trimmedLocation.isEmpty,
      properties: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadProperties();
  }

  /// Search properties.
  Future<void> search(String? query) async {
    final trimmedQuery = query?.trim();
    if (state.searchQuery == trimmedQuery) return;

    state = state.copyWith(
      searchQuery: trimmedQuery,
      clearSearch: trimmedQuery == null || trimmedQuery.isEmpty,
      properties: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadProperties();
  }

  /// Filter by price range.
  Future<void> filterByPrice(double? min, double? max) async {
    state = state.copyWith(
      minPrice: min,
      maxPrice: max,
      clearPrice: min == null && max == null,
      properties: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadProperties();
  }

  /// Change sort option.
  Future<void> changeSort(String sortOption) async {
    if (state.sortOption == sortOption) return;

    state = state.copyWith(
      sortOption: sortOption,
      properties: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadProperties();
  }

  /// Clear all filters.
  Future<void> clearFilters() async {
    state = state.copyWith(
      clearType: true,
      clearLocation: true,
      clearSearch: true,
      clearPrice: true,
      properties: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadProperties();
  }

  /// Refresh the properties list.
  Future<void> refresh() async {
    await loadProperties(refresh: true);
  }
}

/// Provider for PropertiesNotifier.
final propertiesProvider =
    StateNotifierProvider<PropertiesNotifier, PropertiesState>((ref) {
  final repository = ref.watch(propertyRepositoryProvider);
  return PropertiesNotifier(repository);
});

/// Provider for single property detail.
final propertyDetailProvider =
    FutureProvider.family<Property?, String>((ref, id) async {
  final repository = ref.watch(propertyRepositoryProvider);
  final result = await repository.getPropertyById(id);

  return switch (result) {
    PropertySuccess(:final data) => data,
    PropertyFailure() => null,
  };
});

/// Provider for featured properties.
final featuredPropertiesProvider = FutureProvider<List<Property>>((ref) async {
  final repository = ref.watch(propertyRepositoryProvider);
  final result = await repository.getFeaturedProperties();

  return switch (result) {
    PropertySuccess(:final data) => data,
    PropertyFailure() => [],
  };
});

/// State for user's bids.
class UserBidsState {
  const UserBidsState({
    this.bids = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.hasMore = true,
    this.currentPage = 1,
  });

  final List<Bid> bids;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final bool hasMore;
  final int currentPage;

  UserBidsState copyWith({
    List<Bid>? bids,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    bool? hasMore,
    int? currentPage,
  }) {
    return UserBidsState(
      bids: bids ?? this.bids,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

/// Notifier for managing user's bids.
class UserBidsNotifier extends StateNotifier<UserBidsState> {
  UserBidsNotifier(this._repository) : super(const UserBidsState()) {
    loadBids();
  }

  final PropertyRepository _repository;
  static const int _pageSize = 20;

  /// Load user's bids.
  Future<void> loadBids({bool refresh = false}) async {
    if (state.isLoading && !refresh) return;

    state = state.copyWith(
      isLoading: true,
      error: null,
      currentPage: 1,
      bids: refresh ? [] : state.bids,
    );

    final result = await _repository.getUserBids(page: 1, limit: _pageSize);

    switch (result) {
      case PropertySuccess(:final data, :final hasMore):
        state = state.copyWith(
          bids: data,
          isLoading: false,
          hasMore: hasMore,
          currentPage: 1,
        );
      case PropertyFailure(:final message):
        state = state.copyWith(
          isLoading: false,
          error: message,
        );
    }
  }

  /// Load more bids.
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;

    state = state.copyWith(isLoadingMore: true);

    final nextPage = state.currentPage + 1;
    final result = await _repository.getUserBids(page: nextPage, limit: _pageSize);

    switch (result) {
      case PropertySuccess(:final data, :final hasMore):
        state = state.copyWith(
          bids: [...state.bids, ...data],
          isLoadingMore: false,
          hasMore: hasMore,
          currentPage: nextPage,
        );
      case PropertyFailure(:final message):
        state = state.copyWith(
          isLoadingMore: false,
          error: message,
        );
    }
  }

  /// Withdraw a bid.
  Future<bool> withdrawBid(String bidId) async {
    final result = await _repository.withdrawBid(bidId);

    switch (result) {
      case PropertySuccess():
        // Update the bid status locally
        final updatedBids = state.bids.map((bid) {
          if (bid.id == bidId) {
            return Bid(
              id: bid.id,
              propertyId: bid.propertyId,
              userId: bid.userId,
              amount: bid.amount,
              status: BidStatus.withdrawn,
              createdAt: bid.createdAt,
              updatedAt: DateTime.now(),
              propertyTitle: bid.propertyTitle,
              propertyImage: bid.propertyImage,
              message: bid.message,
            );
          }
          return bid;
        }).toList();
        state = state.copyWith(bids: updatedBids);
        return true;
      case PropertyFailure():
        return false;
    }
  }

  /// Refresh bids.
  Future<void> refresh() async {
    await loadBids(refresh: true);
  }
}

/// Provider for UserBidsNotifier.
final userBidsProvider =
    StateNotifierProvider<UserBidsNotifier, UserBidsState>((ref) {
  final repository = ref.watch(propertyRepositoryProvider);
  return UserBidsNotifier(repository);
});

/// Sort options for properties.
enum PropertySortOption {
  newest('createdAt:desc', 'Newest First'),
  oldest('createdAt:asc', 'Oldest First'),
  priceLow('price:asc', 'Price: Low to High'),
  priceHigh('price:desc', 'Price: High to Low');

  const PropertySortOption(this.value, this.label);
  final String value;
  final String label;
}
