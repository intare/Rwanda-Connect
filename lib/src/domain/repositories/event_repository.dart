import '../entities/event.dart';

/// Result type for event operations.
sealed class EventResult<T> {
  const EventResult();
}

class EventSuccess<T> extends EventResult<T> {
  const EventSuccess(this.data, {this.hasMore = false});
  final T data;
  final bool hasMore;
}

class EventFailure<T> extends EventResult<T> {
  const EventFailure(this.message);
  final String message;
}

/// Parameters for fetching events.
class GetEventsParams {
  const GetEventsParams({
    this.page = 1,
    this.limit = 20,
    this.search,
    this.type,
    this.location,
    this.dateFrom,
    this.dateTo,
    this.sort = 'date:asc',
  });

  final int page;
  final int limit;
  final String? search;
  final EventType? type;
  final String? location;
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final String sort;

  GetEventsParams copyWith({
    int? page,
    int? limit,
    String? search,
    EventType? type,
    String? location,
    DateTime? dateFrom,
    DateTime? dateTo,
    String? sort,
    bool clearType = false,
    bool clearSearch = false,
    bool clearLocation = false,
    bool clearDateFrom = false,
    bool clearDateTo = false,
  }) {
    return GetEventsParams(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      search: clearSearch ? null : (search ?? this.search),
      type: clearType ? null : (type ?? this.type),
      location: clearLocation ? null : (location ?? this.location),
      dateFrom: clearDateFrom ? null : (dateFrom ?? this.dateFrom),
      dateTo: clearDateTo ? null : (dateTo ?? this.dateTo),
      sort: sort ?? this.sort,
    );
  }

  Map<String, dynamic> toQueryParams() {
    return {
      'page': page,
      'limit': limit,
      if (search != null && search!.isNotEmpty) 'search': search,
      if (type != null) 'type': type!.value,
      if (location != null && location!.isNotEmpty) 'location': location,
      if (dateFrom != null) 'dateFrom': dateFrom!.toIso8601String(),
      if (dateTo != null) 'dateTo': dateTo!.toIso8601String(),
      'sort': sort,
    };
  }

  /// Check if any filters are active.
  bool get hasActiveFilters =>
      type != null ||
      (search != null && search!.isNotEmpty) ||
      (location != null && location!.isNotEmpty) ||
      dateFrom != null ||
      dateTo != null;
}

/// Repository interface for event operations.
abstract class EventRepository {
  /// Get paginated list of events.
  Future<EventResult<List<Event>>> getEvents(GetEventsParams params);

  /// Get a single event by ID.
  Future<EventResult<Event>> getEventById(String id);

  /// RSVP to an event.
  Future<EventResult<RsvpStatus>> rsvpToEvent(String eventId, RsvpStatus status);
}
