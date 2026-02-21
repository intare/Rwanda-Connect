import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/repositories/event_repository_impl.dart';
import '../../../../domain/entities/event.dart';
import '../../../../domain/repositories/event_repository.dart';

/// State for the events list.
class EventsState {
  const EventsState({
    this.events = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.hasMore = true,
    this.currentPage = 1,
    this.selectedType,
    this.searchQuery,
    this.selectedLocation,
    this.dateFrom,
    this.dateTo,
    this.sortOption = 'date:asc',
  });

  final List<Event> events;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final bool hasMore;
  final int currentPage;
  final EventType? selectedType;
  final String? searchQuery;
  final String? selectedLocation;
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final String sortOption;

  EventsState copyWith({
    List<Event>? events,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    bool? hasMore,
    int? currentPage,
    EventType? selectedType,
    String? searchQuery,
    String? selectedLocation,
    DateTime? dateFrom,
    DateTime? dateTo,
    String? sortOption,
    bool clearType = false,
    bool clearSearch = false,
    bool clearLocation = false,
    bool clearDateFrom = false,
    bool clearDateTo = false,
  }) {
    return EventsState(
      events: events ?? this.events,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      selectedType: clearType ? null : (selectedType ?? this.selectedType),
      searchQuery: clearSearch ? null : (searchQuery ?? this.searchQuery),
      selectedLocation:
          clearLocation ? null : (selectedLocation ?? this.selectedLocation),
      dateFrom: clearDateFrom ? null : (dateFrom ?? this.dateFrom),
      dateTo: clearDateTo ? null : (dateTo ?? this.dateTo),
      sortOption: sortOption ?? this.sortOption,
    );
  }

  /// Check if any filters are active.
  bool get hasActiveFilters =>
      selectedType != null ||
      (searchQuery != null && searchQuery!.isNotEmpty) ||
      (selectedLocation != null && selectedLocation!.isNotEmpty) ||
      dateFrom != null ||
      dateTo != null;

  /// Get count of active filters.
  int get activeFilterCount {
    int count = 0;
    if (selectedType != null) count++;
    if (searchQuery != null && searchQuery!.isNotEmpty) count++;
    if (selectedLocation != null && selectedLocation!.isNotEmpty) count++;
    if (dateFrom != null) count++;
    if (dateTo != null) count++;
    return count;
  }
}

/// Notifier for managing events list state.
class EventsNotifier extends StateNotifier<EventsState> {
  EventsNotifier(this._repository) : super(const EventsState()) {
    loadEvents();
  }

  final EventRepository _repository;
  static const int _pageSize = 20;

  /// Load initial events or refresh.
  Future<void> loadEvents({bool refresh = false}) async {
    if (state.isLoading && !refresh) return;

    state = state.copyWith(
      isLoading: true,
      error: null,
      currentPage: 1,
      events: refresh ? [] : state.events,
    );

    final params = GetEventsParams(
      page: 1,
      limit: _pageSize,
      type: state.selectedType,
      search: state.searchQuery,
      location: state.selectedLocation,
      dateFrom: state.dateFrom,
      dateTo: state.dateTo,
      sort: state.sortOption,
    );

    final result = await _repository.getEvents(params);

    switch (result) {
      case EventSuccess(:final data, :final hasMore):
        state = state.copyWith(
          events: data,
          isLoading: false,
          hasMore: hasMore,
          currentPage: 1,
        );
      case EventFailure(:final message):
        state = state.copyWith(
          isLoading: false,
          error: message,
        );
    }
  }

  /// Load more events (pagination).
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;

    state = state.copyWith(isLoadingMore: true);

    final nextPage = state.currentPage + 1;
    final params = GetEventsParams(
      page: nextPage,
      limit: _pageSize,
      type: state.selectedType,
      search: state.searchQuery,
      location: state.selectedLocation,
      dateFrom: state.dateFrom,
      dateTo: state.dateTo,
      sort: state.sortOption,
    );

    final result = await _repository.getEvents(params);

    switch (result) {
      case EventSuccess(:final data, :final hasMore):
        state = state.copyWith(
          events: [...state.events, ...data],
          isLoadingMore: false,
          hasMore: hasMore,
          currentPage: nextPage,
        );
      case EventFailure(:final message):
        state = state.copyWith(
          isLoadingMore: false,
          error: message,
        );
    }
  }

  /// Filter by event type.
  Future<void> filterByType(EventType? type) async {
    if (state.selectedType == type) return;

    state = state.copyWith(
      selectedType: type,
      clearType: type == null,
      events: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadEvents();
  }

  /// Search events.
  Future<void> search(String? query) async {
    final trimmedQuery = query?.trim();
    if (state.searchQuery == trimmedQuery) return;

    state = state.copyWith(
      searchQuery: trimmedQuery,
      clearSearch: trimmedQuery == null || trimmedQuery.isEmpty,
      events: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadEvents();
  }

  /// Filter by location.
  Future<void> filterByLocation(String? location) async {
    if (state.selectedLocation == location) return;

    state = state.copyWith(
      selectedLocation: location,
      clearLocation: location == null || location.isEmpty,
      events: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadEvents();
  }

  /// Filter by date range.
  Future<void> filterByDateRange(DateTime? from, DateTime? to) async {
    state = state.copyWith(
      dateFrom: from,
      dateTo: to,
      clearDateFrom: from == null,
      clearDateTo: to == null,
      events: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadEvents();
  }

  /// Change sort option.
  Future<void> changeSort(String sortOption) async {
    if (state.sortOption == sortOption) return;

    state = state.copyWith(
      sortOption: sortOption,
      events: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadEvents();
  }

  /// Clear all filters.
  Future<void> clearFilters() async {
    state = state.copyWith(
      clearType: true,
      clearSearch: true,
      clearLocation: true,
      clearDateFrom: true,
      clearDateTo: true,
      events: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadEvents();
  }

  /// Refresh the events list.
  Future<void> refresh() async {
    await loadEvents(refresh: true);
  }

  /// Clear error state.
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Provider for EventsNotifier.
final eventsProvider =
    StateNotifierProvider<EventsNotifier, EventsState>((ref) {
  final repository = ref.watch(eventRepositoryProvider);
  return EventsNotifier(repository);
});

/// Provider for event types.
final eventTypesProvider = Provider<List<EventType>>((ref) {
  return EventType.values;
});

/// Provider for sort options.
final eventSortOptionsProvider = Provider<List<EventSortOption>>((ref) {
  return EventSortOption.values;
});

/// Provider for single event detail.
final eventDetailProvider =
    FutureProvider.family<Event?, String>((ref, id) async {
  final repository = ref.watch(eventRepositoryProvider);
  final result = await repository.getEventById(id);

  return switch (result) {
    EventSuccess(:final data) => data,
    EventFailure() => null,
  };
});

/// Provider for RSVP action.
final rsvpProvider = FutureProvider.family<RsvpStatus?, ({String eventId, RsvpStatus status})>(
  (ref, params) async {
    final repository = ref.watch(eventRepositoryProvider);
    final result = await repository.rsvpToEvent(params.eventId, params.status);

    return switch (result) {
      EventSuccess(:final data) => data,
      EventFailure() => null,
    };
  },
);

/// State for user's RSVP status on an event.
class EventRsvpState {
  const EventRsvpState({
    this.status,
    this.isLoading = false,
    this.error,
  });

  final RsvpStatus? status;
  final bool isLoading;
  final String? error;

  EventRsvpState copyWith({
    RsvpStatus? status,
    bool? isLoading,
    String? error,
    bool clearStatus = false,
  }) {
    return EventRsvpState(
      status: clearStatus ? null : (status ?? this.status),
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Notifier for managing user's RSVP status for a specific event.
class EventRsvpNotifier extends StateNotifier<EventRsvpState> {
  EventRsvpNotifier(this._repository, this._eventId)
      : super(const EventRsvpState()) {
    _loadStatus();
  }

  final EventRepository _repository;
  final String _eventId;

  /// Load current RSVP status.
  Future<void> _loadStatus() async {
    state = state.copyWith(isLoading: true);

    final result = await _repository.getUserRsvpStatus(_eventId);

    switch (result) {
      case EventSuccess(:final data):
        state = state.copyWith(
          status: data,
          isLoading: false,
        );
      case EventFailure(:final message):
        state = state.copyWith(
          isLoading: false,
          error: message,
        );
    }
  }

  /// Submit RSVP.
  Future<bool> rsvp(RsvpStatus status) async {
    if (state.isLoading) return false;

    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.rsvpToEvent(_eventId, status);

    switch (result) {
      case EventSuccess(:final data):
        state = state.copyWith(
          status: data,
          isLoading: false,
        );
        return true;
      case EventFailure(:final message):
        state = state.copyWith(
          isLoading: false,
          error: message,
        );
        return false;
    }
  }

  /// Cancel RSVP.
  Future<bool> cancel() async {
    if (state.isLoading) return false;

    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.cancelRsvp(_eventId);

    switch (result) {
      case EventSuccess():
        state = state.copyWith(
          clearStatus: true,
          isLoading: false,
        );
        return true;
      case EventFailure(:final message):
        state = state.copyWith(
          isLoading: false,
          error: message,
        );
        return false;
    }
  }
}

/// Provider for user's RSVP status on a specific event.
final eventRsvpProvider =
    StateNotifierProvider.family<EventRsvpNotifier, EventRsvpState, String>(
  (ref, eventId) {
    final repository = ref.watch(eventRepositoryProvider);
    return EventRsvpNotifier(repository, eventId);
  },
);

/// State for user's RSVPs list (My RSVPs).
class MyRsvpsState {
  const MyRsvpsState({
    this.rsvps = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.hasMore = true,
    this.currentPage = 1,
  });

  final List<UserRsvp> rsvps;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final bool hasMore;
  final int currentPage;

  MyRsvpsState copyWith({
    List<UserRsvp>? rsvps,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    bool? hasMore,
    int? currentPage,
  }) {
    return MyRsvpsState(
      rsvps: rsvps ?? this.rsvps,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

/// Notifier for managing user's RSVPs list.
class MyRsvpsNotifier extends StateNotifier<MyRsvpsState> {
  MyRsvpsNotifier(this._repository) : super(const MyRsvpsState()) {
    loadRsvps();
  }

  final EventRepository _repository;
  static const int _pageSize = 20;

  /// Load initial RSVPs or refresh.
  Future<void> loadRsvps({bool refresh = false}) async {
    if (state.isLoading && !refresh) return;

    state = state.copyWith(
      isLoading: true,
      error: null,
      currentPage: 1,
      rsvps: refresh ? [] : state.rsvps,
    );

    final result = await _repository.getUserRsvps(page: 1, limit: _pageSize);

    switch (result) {
      case EventSuccess(:final data, :final hasMore):
        state = state.copyWith(
          rsvps: data,
          isLoading: false,
          hasMore: hasMore,
          currentPage: 1,
        );
      case EventFailure(:final message):
        state = state.copyWith(
          isLoading: false,
          error: message,
        );
    }
  }

  /// Load more RSVPs (pagination).
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;

    state = state.copyWith(isLoadingMore: true);

    final nextPage = state.currentPage + 1;
    final result = await _repository.getUserRsvps(page: nextPage, limit: _pageSize);

    switch (result) {
      case EventSuccess(:final data, :final hasMore):
        state = state.copyWith(
          rsvps: [...state.rsvps, ...data],
          isLoadingMore: false,
          hasMore: hasMore,
          currentPage: nextPage,
        );
      case EventFailure(:final message):
        state = state.copyWith(
          isLoadingMore: false,
          error: message,
        );
    }
  }

  /// Remove an RSVP from the list (after canceling).
  void removeRsvp(String rsvpId) {
    state = state.copyWith(
      rsvps: state.rsvps.where((r) => r.id != rsvpId).toList(),
    );
  }

  /// Refresh the RSVPs list.
  Future<void> refresh() async {
    await loadRsvps(refresh: true);
  }
}

/// Provider for user's RSVPs list.
final myRsvpsProvider =
    StateNotifierProvider<MyRsvpsNotifier, MyRsvpsState>((ref) {
  final repository = ref.watch(eventRepositoryProvider);
  return MyRsvpsNotifier(repository);
});
