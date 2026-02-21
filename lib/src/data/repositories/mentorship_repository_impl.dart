import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_interceptors.dart';
import '../../core/network/connectivity_service.dart';
import '../../domain/entities/mentorship.dart';
import '../../domain/repositories/mentorship_repository.dart';
import '../mappers/mentorship_mapper.dart';
import '../services/mentorship_service.dart';

/// Implementation of MentorshipRepository with offline awareness.
class MentorshipRepositoryImpl implements MentorshipRepository {
  MentorshipRepositoryImpl(
    this._mentorshipService,
    this._connectivityService,
  );

  final MentorshipService _mentorshipService;
  final ConnectivityService _connectivityService;

  @override
  Future<MentorshipResult<List<Mentor>>> getMentors(
    GetMentorsParams params,
  ) async {
    if (!_connectivityService.isOnline) {
      return const MentorshipFailure(
        'No internet connection. Mentors require online access.',
      );
    }

    try {
      final response = await _mentorshipService.getMentors(
        page: params.page,
        limit: params.limit,
        expertise: params.expertise?.value,
        search: params.search,
        location: params.location,
        isAvailable: params.isAvailable,
        sort: _mapSort(params.sort),
      );

      final mentors = response.docs.toEntities();
      return MentorshipSuccess(mentors, hasMore: response.hasNextPage);
    } on DioException catch (e) {
      return MentorshipFailure(_handleDioError(e));
    } catch (e) {
      return MentorshipFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<MentorshipResult<Mentor>> getMentorById(String id) async {
    if (!_connectivityService.isOnline) {
      return const MentorshipFailure(
        'No internet connection. Mentor details require online access.',
      );
    }

    try {
      final response = await _mentorshipService.getMentorById(id);
      return MentorshipSuccess(response.toEntity());
    } on DioException catch (e) {
      return MentorshipFailure(_handleDioError(e));
    } catch (e) {
      return MentorshipFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<MentorshipResult<List<Mentor>>> getFeaturedMentors({
    int limit = 5,
  }) async {
    if (!_connectivityService.isOnline) {
      return const MentorshipFailure('No internet connection.');
    }

    try {
      final response = await _mentorshipService.getFeaturedMentors(limit: limit);
      final mentors = response.docs.toEntities();
      return MentorshipSuccess(mentors);
    } on DioException catch (e) {
      return MentorshipFailure(_handleDioError(e));
    } catch (e) {
      return MentorshipFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<MentorshipResult<MentorshipRequest>> sendRequest(
    String mentorId,
    String message,
  ) async {
    if (!_connectivityService.isOnline) {
      return const MentorshipFailure(
        'No internet connection. Cannot send request offline.',
      );
    }

    try {
      final response = await _mentorshipService.sendRequest(mentorId, message);
      return MentorshipSuccess(response.toEntity());
    } on DioException catch (e) {
      return MentorshipFailure(_handleDioError(e));
    } catch (e) {
      return MentorshipFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<MentorshipResult<List<MentorshipRequest>>> getSentRequests({
    int page = 1,
    int limit = 20,
  }) async {
    if (!_connectivityService.isOnline) {
      return const MentorshipFailure('No internet connection.');
    }

    try {
      final response = await _mentorshipService.getSentRequests(
        page: page,
        limit: limit,
      );
      final requests = response.docs.toEntities();
      return MentorshipSuccess(requests, hasMore: response.hasNextPage);
    } on DioException catch (e) {
      return MentorshipFailure(_handleDioError(e));
    } catch (e) {
      return MentorshipFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<MentorshipResult<List<MentorshipRequest>>> getReceivedRequests({
    int page = 1,
    int limit = 20,
  }) async {
    if (!_connectivityService.isOnline) {
      return const MentorshipFailure('No internet connection.');
    }

    try {
      final response = await _mentorshipService.getReceivedRequests(
        page: page,
        limit: limit,
      );
      final requests = response.docs.toEntities();
      return MentorshipSuccess(requests, hasMore: response.hasNextPage);
    } on DioException catch (e) {
      return MentorshipFailure(_handleDioError(e));
    } catch (e) {
      return MentorshipFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<MentorshipResult<MentorshipConnection>> acceptRequest(
    String requestId, {
    String? message,
  }) async {
    if (!_connectivityService.isOnline) {
      return const MentorshipFailure('No internet connection.');
    }

    try {
      final response = await _mentorshipService.acceptRequest(
        requestId,
        message: message,
      );
      return MentorshipSuccess(response.toEntity());
    } on DioException catch (e) {
      return MentorshipFailure(_handleDioError(e));
    } catch (e) {
      return MentorshipFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<MentorshipResult<void>> declineRequest(
    String requestId, {
    String? message,
  }) async {
    if (!_connectivityService.isOnline) {
      return const MentorshipFailure('No internet connection.');
    }

    try {
      await _mentorshipService.declineRequest(requestId, message: message);
      return const MentorshipSuccess(null);
    } on DioException catch (e) {
      return MentorshipFailure(_handleDioError(e));
    } catch (e) {
      return MentorshipFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<MentorshipResult<void>> cancelRequest(String requestId) async {
    if (!_connectivityService.isOnline) {
      return const MentorshipFailure('No internet connection.');
    }

    try {
      await _mentorshipService.cancelRequest(requestId);
      return const MentorshipSuccess(null);
    } on DioException catch (e) {
      return MentorshipFailure(_handleDioError(e));
    } catch (e) {
      return MentorshipFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<MentorshipResult<List<MentorshipConnection>>> getConnections({
    int page = 1,
    int limit = 20,
  }) async {
    if (!_connectivityService.isOnline) {
      return const MentorshipFailure('No internet connection.');
    }

    try {
      final response = await _mentorshipService.getConnections(
        page: page,
        limit: limit,
      );
      final connections = response.docs.toEntities();
      return MentorshipSuccess(connections, hasMore: response.hasNextPage);
    } on DioException catch (e) {
      return MentorshipFailure(_handleDioError(e));
    } catch (e) {
      return MentorshipFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<MentorshipResult<void>> endConnection(String connectionId) async {
    if (!_connectivityService.isOnline) {
      return const MentorshipFailure('No internet connection.');
    }

    try {
      await _mentorshipService.endConnection(connectionId);
      return const MentorshipSuccess(null);
    } on DioException catch (e) {
      return MentorshipFailure(_handleDioError(e));
    } catch (e) {
      return MentorshipFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<MentorshipResult<int>> getRemainingRequestQuota() async {
    if (!_connectivityService.isOnline) {
      return const MentorshipFailure('No internet connection.');
    }

    try {
      final quota = await _mentorshipService.getRemainingRequestQuota();
      return MentorshipSuccess(quota);
    } on DioException catch (e) {
      return MentorshipFailure(_handleDioError(e));
    } catch (e) {
      return MentorshipFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<MentorshipResult<bool>> canSendRequests() async {
    final quotaResult = await getRemainingRequestQuota();
    return switch (quotaResult) {
      MentorshipSuccess(:final data) => MentorshipSuccess(data > 0),
      MentorshipFailure(:final message) => MentorshipFailure(message),
    };
  }

  @override
  Future<MentorshipResult<Mentor>> registerAsMentor({
    required String bio,
    required List<MentorExpertise> expertise,
    required int yearsExperience,
    String? linkedinUrl,
  }) async {
    if (!_connectivityService.isOnline) {
      return const MentorshipFailure('No internet connection.');
    }

    try {
      final response = await _mentorshipService.registerAsMentor(
        bio: bio,
        expertise: expertise.map((e) => e.value).toList(),
        yearsExperience: yearsExperience,
        linkedinUrl: linkedinUrl,
      );
      return MentorshipSuccess(response.toEntity());
    } on DioException catch (e) {
      return MentorshipFailure(_handleDioError(e));
    } catch (e) {
      return MentorshipFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<MentorshipResult<Mentor>> updateMentorProfile({
    String? bio,
    List<MentorExpertise>? expertise,
    int? yearsExperience,
    String? linkedinUrl,
    bool? isAvailable,
  }) async {
    if (!_connectivityService.isOnline) {
      return const MentorshipFailure('No internet connection.');
    }

    // First get current profile to get the ID
    final profileResult = await getMyMentorProfile();
    if (profileResult is MentorshipFailure) {
      return MentorshipFailure((profileResult as MentorshipFailure).message);
    }

    final profile = (profileResult as MentorshipSuccess<Mentor?>).data;
    if (profile == null) {
      return const MentorshipFailure('No mentor profile found.');
    }

    try {
      final response = await _mentorshipService.updateMentorProfile(
        profile.id,
        bio: bio,
        expertise: expertise?.map((e) => e.value).toList(),
        yearsExperience: yearsExperience,
        linkedinUrl: linkedinUrl,
        isAvailable: isAvailable,
      );
      return MentorshipSuccess(response.toEntity());
    } on DioException catch (e) {
      return MentorshipFailure(_handleDioError(e));
    } catch (e) {
      return MentorshipFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<MentorshipResult<Mentor?>> getMyMentorProfile() async {
    if (!_connectivityService.isOnline) {
      return const MentorshipFailure('No internet connection.');
    }

    try {
      final response = await _mentorshipService.getMyMentorProfile();
      return MentorshipSuccess(response?.toEntity());
    } on DioException catch (e) {
      return MentorshipFailure(_handleDioError(e));
    } catch (e) {
      return MentorshipFailure('An unexpected error occurred: $e');
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
          return 'Mentor not found.';
        }
        if (statusCode == 403) {
          return 'You don\'t have permission to perform this action.';
        }
        if (statusCode == 429) {
          return 'You have reached your mentorship request limit.';
        }
        return 'Server error: $statusCode';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}

/// Provider for MentorshipRepository.
final mentorshipRepositoryProvider = Provider<MentorshipRepository>((ref) {
  final mentorshipService = ref.watch(mentorshipServiceProvider);
  final connectivityService = ref.watch(connectivityServiceProvider);
  return MentorshipRepositoryImpl(
    mentorshipService,
    connectivityService,
  );
});
