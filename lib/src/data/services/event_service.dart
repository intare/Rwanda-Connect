import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../models/events/event_dto.dart';

/// Response from events list API.
class EventListResponse {
  const EventListResponse({
    required this.events,
    required this.hasNext,
    required this.total,
    required this.page,
    required this.totalPages,
  });

  final List<EventDto> events;
  final bool hasNext;
  final int total;
  final int page;
  final int totalPages;
}

/// Service for making event-related API calls using Payload CMS.
class EventService {
  EventService(this._dio, this._secureStorage);

  final Dio _dio;
  final FlutterSecureStorage _secureStorage;

  static const _tokenKey = 'auth_token';

  /// Get paginated list of events.
  Future<EventListResponse> getEvents({
    int page = 1,
    int limit = 10,
    String? type,
    String? location,
    String? search,
    String sort = 'date',
    bool? isVirtual,
    bool? isFeatured,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'limit': limit,
      'sort': sort,
      'depth': 1,
    };

    // Add filters using Payload's where syntax
    if (type != null && type.isNotEmpty) {
      queryParams['where[type][equals]'] = type;
    }

    if (location != null && location.isNotEmpty) {
      queryParams['where[location][contains]'] = location;
    }

    if (isVirtual != null) {
      queryParams['where[isVirtual][equals]'] = isVirtual;
    }

    if (isFeatured != null) {
      queryParams['where[isFeatured][equals]'] = isFeatured;
    }

    if (search != null && search.isNotEmpty) {
      queryParams['where[or][0][title][contains]'] = search;
      queryParams['where[or][1][description][contains]'] = search;
      queryParams['where[or][2][location][contains]'] = search;
    }

    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.events,
      queryParameters: queryParams,
    );

    final data = response.data!;
    final docs = data['docs'] as List<dynamic>;

    return EventListResponse(
      events: docs
          .map((item) => EventDto.fromJson(item as Map<String, dynamic>))
          .toList(),
      hasNext: data['hasNextPage'] as bool? ?? false,
      total: data['totalDocs'] as int? ?? 0,
      page: data['page'] as int? ?? 1,
      totalPages: data['totalPages'] as int? ?? 1,
    );
  }

  /// Get upcoming events.
  Future<EventListResponse> getUpcomingEvents({int limit = 5}) async {
    final queryParams = <String, dynamic>{
      'page': 1,
      'limit': limit,
      'sort': 'date',
      'depth': 1,
      'where[date][greater_than]': DateTime.now().toIso8601String(),
    };

    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.events,
      queryParameters: queryParams,
    );

    final data = response.data!;
    final docs = data['docs'] as List<dynamic>;

    return EventListResponse(
      events: docs
          .map((item) => EventDto.fromJson(item as Map<String, dynamic>))
          .toList(),
      hasNext: data['hasNextPage'] as bool? ?? false,
      total: data['totalDocs'] as int? ?? 0,
      page: data['page'] as int? ?? 1,
      totalPages: data['totalPages'] as int? ?? 1,
    );
  }

  /// Get featured events.
  Future<EventListResponse> getFeaturedEvents({int limit = 5}) async {
    return getEvents(
      page: 1,
      limit: limit,
      isFeatured: true,
      sort: 'date',
    );
  }

  /// Get a single event by ID.
  Future<EventDto> getEventById(String id) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.eventDetail(id),
    );

    return EventDto.fromJson(response.data!);
  }

  /// RSVP to an event.
  Future<RsvpResponseDto> rsvpToEvent(String eventId, String status) async {
    final token = await _secureStorage.read(key: _tokenKey);
    if (token == null) {
      throw Exception('Not authenticated');
    }

    // First check if user already has an RSVP
    final existingRsvp = await _getUserRsvp(eventId, token);

    if (existingRsvp != null) {
      // Update existing RSVP
      await _dio.patch(
        ApiEndpoints.eventRsvpDetail(existingRsvp['id'].toString()),
        data: {'status': status},
        options: Options(
          headers: {'Authorization': 'JWT $token'},
        ),
      );
    } else {
      // Create new RSVP
      await _dio.post(
        ApiEndpoints.eventRsvps,
        data: {
          'event': eventId,
          'status': status,
        },
        options: Options(
          headers: {'Authorization': 'JWT $token'},
        ),
      );
    }

    return RsvpResponseDto(eventId: eventId, status: status);
  }

  /// Get user's RSVP status for an event.
  Future<String?> getUserRsvpStatus(String eventId) async {
    final token = await _secureStorage.read(key: _tokenKey);
    if (token == null) return null;

    try {
      final rsvp = await _getUserRsvp(eventId, token);
      return rsvp?['status'] as String?;
    } catch (_) {
      return null;
    }
  }

  /// Cancel RSVP for an event.
  Future<void> cancelRsvp(String eventId) async {
    final token = await _secureStorage.read(key: _tokenKey);
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final rsvp = await _getUserRsvp(eventId, token);
    if (rsvp != null) {
      await _dio.delete(
        ApiEndpoints.eventRsvpDetail(rsvp['id'].toString()),
        options: Options(
          headers: {'Authorization': 'JWT $token'},
        ),
      );
    }
  }

  /// Helper to get user's RSVP for an event.
  Future<Map<String, dynamic>?> _getUserRsvp(String eventId, String token) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.eventRsvps,
        queryParameters: {
          'where[event][equals]': eventId,
          'limit': 1,
        },
        options: Options(
          headers: {'Authorization': 'JWT $token'},
        ),
      );

      final docs = response.data?['docs'] as List<dynamic>?;
      if (docs != null && docs.isNotEmpty) {
        return docs.first as Map<String, dynamic>;
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}

/// Provider for EventService.
final eventServiceProvider = Provider<EventService>((ref) {
  final dio = ref.watch(dioProvider);
  final secureStorage = ref.watch(secureStorageProvider);
  return EventService(dio, secureStorage);
});
