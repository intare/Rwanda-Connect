import '../entities/mentorship.dart';

/// Result type for mentorship operations.
sealed class MentorshipResult<T> {
  const MentorshipResult();
}

/// Success result with data.
class MentorshipSuccess<T> extends MentorshipResult<T> {
  const MentorshipSuccess(this.data, {this.hasMore = false});
  final T data;
  final bool hasMore;
}

/// Failure result with error message.
class MentorshipFailure<T> extends MentorshipResult<T> {
  const MentorshipFailure(this.message);
  final String message;
}

/// Parameters for fetching mentors list.
class GetMentorsParams {
  const GetMentorsParams({
    this.page = 1,
    this.limit = 20,
    this.expertise,
    this.search,
    this.location,
    this.isAvailable,
    this.sort = 'rating:desc',
  });

  final int page;
  final int limit;
  final MentorExpertise? expertise;
  final String? search;
  final String? location;
  final bool? isAvailable;
  final String sort;
}

/// Repository interface for mentorship operations.
abstract class MentorshipRepository {
  /// Get paginated list of mentors.
  Future<MentorshipResult<List<Mentor>>> getMentors(GetMentorsParams params);

  /// Get a single mentor by ID.
  Future<MentorshipResult<Mentor>> getMentorById(String id);

  /// Get featured/top mentors.
  Future<MentorshipResult<List<Mentor>>> getFeaturedMentors({int limit = 5});

  /// Send a mentorship request.
  Future<MentorshipResult<MentorshipRequest>> sendRequest(
    String mentorId,
    String message,
  );

  /// Get user's sent requests (as mentee).
  Future<MentorshipResult<List<MentorshipRequest>>> getSentRequests({
    int page = 1,
    int limit = 20,
  });

  /// Get received requests (as mentor).
  Future<MentorshipResult<List<MentorshipRequest>>> getReceivedRequests({
    int page = 1,
    int limit = 20,
  });

  /// Accept a mentorship request.
  Future<MentorshipResult<MentorshipConnection>> acceptRequest(
    String requestId, {
    String? message,
  });

  /// Decline a mentorship request.
  Future<MentorshipResult<void>> declineRequest(
    String requestId, {
    String? message,
  });

  /// Cancel a sent request.
  Future<MentorshipResult<void>> cancelRequest(String requestId);

  /// Get active mentorship connections.
  Future<MentorshipResult<List<MentorshipConnection>>> getConnections({
    int page = 1,
    int limit = 20,
  });

  /// End a mentorship connection.
  Future<MentorshipResult<void>> endConnection(String connectionId);

  /// Get remaining mentorship request quota.
  Future<MentorshipResult<int>> getRemainingRequestQuota();

  /// Check if user can send mentorship requests.
  Future<MentorshipResult<bool>> canSendRequests();

  /// Register as a mentor.
  Future<MentorshipResult<Mentor>> registerAsMentor({
    required String bio,
    required List<MentorExpertise> expertise,
    required int yearsExperience,
    String? linkedinUrl,
  });

  /// Update mentor profile.
  Future<MentorshipResult<Mentor>> updateMentorProfile({
    String? bio,
    List<MentorExpertise>? expertise,
    int? yearsExperience,
    String? linkedinUrl,
    bool? isAvailable,
  });

  /// Get current user's mentor profile (if registered).
  Future<MentorshipResult<Mentor?>> getMyMentorProfile();
}
