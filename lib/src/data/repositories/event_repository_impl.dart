import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_interceptors.dart';
import '../../domain/entities/event.dart';
import '../../domain/repositories/event_repository.dart';
import '../mappers/event_mapper.dart';
import '../services/event_service.dart';

/// Implementation of EventRepository using Payload CMS.
class EventRepositoryImpl implements EventRepository {
  EventRepositoryImpl(this._eventService);

  final EventService _eventService;

  @override
  Future<EventResult<List<Event>>> getEvents(GetEventsParams params) async {
    try {
      final response = await _eventService.getEvents(
        page: params.page,
        limit: params.limit,
        type: params.type?.value,
        location: params.location,
        search: params.search,
        sort: _mapSort(params.sort),
      );
      final events = response.events.toEntities();
      return EventSuccess(events, hasMore: response.hasNext);
    } on DioException catch (e) {
      return EventFailure(_handleDioError(e));
    } catch (e) {
      return EventFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<EventResult<Event>> getEventById(String id) async {
    try {
      final response = await _eventService.getEventById(id);
      return EventSuccess(response.toEntity());
    } on DioException catch (e) {
      return EventFailure(_handleDioError(e));
    } catch (e) {
      return EventFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<EventResult<RsvpStatus>> rsvpToEvent(
    String eventId,
    RsvpStatus status,
  ) async {
    try {
      final response = await _eventService.rsvpToEvent(eventId, status.value);
      return EventSuccess(RsvpStatus.fromString(response.status));
    } on DioException catch (e) {
      return EventFailure(_handleDioError(e));
    } catch (e) {
      return EventFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<EventResult<RsvpStatus?>> getUserRsvpStatus(String eventId) async {
    try {
      final status = await _eventService.getUserRsvpStatus(eventId);
      if (status == null) {
        return const EventSuccess(null);
      }
      return EventSuccess(RsvpStatus.fromString(status));
    } on DioException catch (e) {
      return EventFailure(_handleDioError(e));
    } catch (e) {
      return EventFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<EventResult<void>> cancelRsvp(String eventId) async {
    try {
      await _eventService.cancelRsvp(eventId);
      return const EventSuccess(null);
    } on DioException catch (e) {
      return EventFailure(_handleDioError(e));
    } catch (e) {
      return EventFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<EventResult<List<UserRsvp>>> getUserRsvps({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _eventService.getUserRsvps(
        page: page,
        limit: limit,
      );

      final rsvps = response.rsvps
          .where((dto) => dto.event != null)
          .map((dto) => UserRsvp(
                id: dto.idString,
                event: dto.event!.toEntity(),
                status: RsvpStatus.fromString(dto.status),
                createdAt: dto.createdAtDateTime ?? DateTime.now(),
              ))
          .toList();

      return EventSuccess(rsvps, hasMore: response.hasNext);
    } on DioException catch (e) {
      return EventFailure(_handleDioError(e));
    } catch (e) {
      return EventFailure('An unexpected error occurred: $e');
    }
  }

  /// Map legacy sort format to Payload format.
  String _mapSort(String sort) {
    final parts = sort.split(':');
    if (parts.length == 2) {
      final field = parts[0];
      final direction = parts[1];
      return direction == 'desc' ? '-$field' : field;
    }
    return sort;
  }

  String _handleDioError(DioException e) {
    final error = e.error;
    if (error is ApiError) {
      return error.message;
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please try again.';
      case DioExceptionType.connectionError:
        return 'No internet connection.';
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) {
          return 'Event not found.';
        }
        return 'Server error: $statusCode';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}

/// Provider for EventRepository.
final eventRepositoryProvider = Provider<EventRepository>((ref) {
  final eventService = ref.watch(eventServiceProvider);
  return EventRepositoryImpl(eventService);
});
