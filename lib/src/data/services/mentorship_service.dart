import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../models/mentorship/mentorship_dto.dart';

/// Service for making mentorship-related API calls.
class MentorshipService {
  MentorshipService(this._dio);

  final Dio _dio;

  /// Get paginated list of mentors.
  Future<MentorsListResponse> getMentors({
    int page = 1,
    int limit = 20,
    String? expertise,
    String? search,
    String? location,
    bool? isAvailable,
    String? sort,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'limit': limit,
      'depth': 1,
    };

    if (expertise != null) queryParams['where[expertise][contains]'] = expertise;
    if (search != null) queryParams['where[name][contains]'] = search;
    if (location != null) queryParams['where[location][contains]'] = location;
    if (isAvailable != null) queryParams['where[isAvailable][equals]'] = isAvailable;
    if (sort != null) queryParams['sort'] = sort;

    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.mentors,
      queryParameters: queryParams,
    );

    return MentorsListResponse.fromJson(response.data!);
  }

  /// Get a single mentor by ID.
  Future<MentorDto> getMentorById(String id) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.mentorDetail(id),
      queryParameters: {'depth': 1},
    );
    return MentorDto.fromJson(response.data!);
  }

  /// Get featured/top mentors.
  Future<MentorsListResponse> getFeaturedMentors({int limit = 5}) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.mentors,
      queryParameters: {
        'where[isAvailable][equals]': true,
        'sort': '-rating',
        'limit': limit,
        'depth': 1,
      },
    );
    return MentorsListResponse.fromJson(response.data!);
  }

  /// Send a mentorship request.
  Future<MentorshipRequestDto> sendRequest(String mentorId, String message) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.mentorshipRequests,
      data: {
        'mentor': mentorId,
        'message': message,
      },
    );
    return MentorshipRequestDto.fromJson(response.data!['doc'] ?? response.data!);
  }

  /// Get user's sent requests.
  Future<MentorshipRequestsListResponse> getSentRequests({
    int page = 1,
    int limit = 20,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.mentorshipRequests,
      queryParameters: {
        'where[type][equals]': 'sent',
        'page': page,
        'limit': limit,
        'sort': '-createdAt',
        'depth': 2,
      },
    );
    return MentorshipRequestsListResponse.fromJson(response.data!);
  }

  /// Get received requests (for mentors).
  Future<MentorshipRequestsListResponse> getReceivedRequests({
    int page = 1,
    int limit = 20,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.mentorshipRequests,
      queryParameters: {
        'where[type][equals]': 'received',
        'page': page,
        'limit': limit,
        'sort': '-createdAt',
        'depth': 2,
      },
    );
    return MentorshipRequestsListResponse.fromJson(response.data!);
  }

  /// Accept a mentorship request.
  Future<MentorshipConnectionDto> acceptRequest(String requestId, {String? message}) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.mentorshipRequestAction(requestId, 'accept'),
      data: {
        if (message != null) 'message': message,
      },
    );
    return MentorshipConnectionDto.fromJson(response.data!['connection'] ?? response.data!);
  }

  /// Decline a mentorship request.
  Future<void> declineRequest(String requestId, {String? message}) async {
    await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.mentorshipRequestAction(requestId, 'decline'),
      data: {
        if (message != null) 'message': message,
      },
    );
  }

  /// Cancel a sent request.
  Future<void> cancelRequest(String requestId) async {
    await _dio.delete<Map<String, dynamic>>(
      ApiEndpoints.mentorshipRequestDetail(requestId),
    );
  }

  /// Get active mentorship connections.
  Future<MentorshipConnectionsListResponse> getConnections({
    int page = 1,
    int limit = 20,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.mentorshipConnections,
      queryParameters: {
        'where[isActive][equals]': true,
        'page': page,
        'limit': limit,
        'sort': '-startedAt',
        'depth': 2,
      },
    );
    return MentorshipConnectionsListResponse.fromJson(response.data!);
  }

  /// End a mentorship connection.
  Future<void> endConnection(String connectionId) async {
    await _dio.patch<Map<String, dynamic>>(
      ApiEndpoints.mentorshipConnectionDetail(connectionId),
      data: {
        'isActive': false,
        'endedAt': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Get remaining mentorship request quota.
  Future<int> getRemainingRequestQuota() async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.mentorshipQuota,
    );
    return response.data!['remaining'] as int? ?? 0;
  }

  /// Register as a mentor.
  Future<MentorDto> registerAsMentor({
    required String bio,
    required List<String> expertise,
    required int yearsExperience,
    String? linkedinUrl,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.mentors,
      data: {
        'bio': bio,
        'expertise': expertise,
        'yearsExperience': yearsExperience,
        if (linkedinUrl != null) 'linkedinUrl': linkedinUrl,
      },
    );
    return MentorDto.fromJson(response.data!['doc'] ?? response.data!);
  }

  /// Update mentor profile.
  Future<MentorDto> updateMentorProfile(
    String mentorId, {
    String? bio,
    List<String>? expertise,
    int? yearsExperience,
    String? linkedinUrl,
    bool? isAvailable,
  }) async {
    final response = await _dio.patch<Map<String, dynamic>>(
      ApiEndpoints.mentorDetail(mentorId),
      data: {
        if (bio != null) 'bio': bio,
        if (expertise != null) 'expertise': expertise,
        if (yearsExperience != null) 'yearsExperience': yearsExperience,
        if (linkedinUrl != null) 'linkedinUrl': linkedinUrl,
        if (isAvailable != null) 'isAvailable': isAvailable,
      },
    );
    return MentorDto.fromJson(response.data!['doc'] ?? response.data!);
  }

  /// Get current user's mentor profile.
  Future<MentorDto?> getMyMentorProfile() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.myMentorProfile,
      );
      if (response.data != null && response.data!.isNotEmpty) {
        return MentorDto.fromJson(response.data!);
      }
      return null;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      }
      rethrow;
    }
  }
}

/// Provider for MentorshipService.
final mentorshipServiceProvider = Provider<MentorshipService>((ref) {
  final dio = ref.watch(dioProvider);
  return MentorshipService(dio);
});
