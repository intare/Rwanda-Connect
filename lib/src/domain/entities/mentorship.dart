import 'package:freezed_annotation/freezed_annotation.dart';

part 'mentorship.freezed.dart';

/// Mentor expertise area.
enum MentorExpertise {
  careerDevelopment('career_development', 'Career Development'),
  entrepreneurship('entrepreneurship', 'Entrepreneurship'),
  technology('technology', 'Technology'),
  finance('finance', 'Finance'),
  marketing('marketing', 'Marketing'),
  leadership('leadership', 'Leadership'),
  networking('networking', 'Networking'),
  education('education', 'Education'),
  healthcare('healthcare', 'Healthcare'),
  law('law', 'Law'),
  other('other', 'Other');

  const MentorExpertise(this.value, this.label);
  final String value;
  final String label;

  static MentorExpertise fromString(String value) {
    return MentorExpertise.values.firstWhere(
      (e) => e.value == value.toLowerCase(),
      orElse: () => MentorExpertise.other,
    );
  }
}

/// Mentorship request status.
enum MentorshipRequestStatus {
  pending('pending', 'Pending'),
  accepted('accepted', 'Accepted'),
  declined('declined', 'Declined'),
  cancelled('cancelled', 'Cancelled'),
  completed('completed', 'Completed');

  const MentorshipRequestStatus(this.value, this.label);
  final String value;
  final String label;

  static MentorshipRequestStatus fromString(String value) {
    return MentorshipRequestStatus.values.firstWhere(
      (e) => e.value == value.toLowerCase(),
      orElse: () => MentorshipRequestStatus.pending,
    );
  }
}

/// Domain entity representing a mentor profile.
@freezed
class Mentor with _$Mentor {
  const Mentor._();

  const factory Mentor({
    required String id,
    required String userId,
    required String name,
    String? avatar,
    String? title,
    String? company,
    String? bio,
    required List<MentorExpertise> expertise,
    @Default(0) int yearsExperience,
    String? linkedinUrl,
    String? location,
    @Default([]) List<String> languages,
    @Default(true) bool isAvailable,
    @Default(0) int totalMentees,
    @Default(0.0) double rating,
    @Default(0) int reviewCount,
    DateTime? createdAt,
  }) = _Mentor;

  /// Get formatted expertise list.
  String get formattedExpertise {
    return expertise.map((e) => e.label).join(', ');
  }

  /// Get formatted rating.
  String get formattedRating {
    return rating.toStringAsFixed(1);
  }

  /// Get initials for avatar placeholder.
  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }
}

/// Domain entity representing a mentorship request.
@freezed
class MentorshipRequest with _$MentorshipRequest {
  const MentorshipRequest._();

  const factory MentorshipRequest({
    required String id,
    required String mentorId,
    required String menteeId,
    required MentorshipRequestStatus status,
    required String message,
    String? mentorName,
    String? mentorAvatar,
    String? mentorTitle,
    String? menteeName,
    String? menteeAvatar,
    String? responseMessage,
    required DateTime createdAt,
    DateTime? respondedAt,
  }) = _MentorshipRequest;

  /// Check if request is pending.
  bool get isPending => status == MentorshipRequestStatus.pending;

  /// Check if request is active (accepted).
  bool get isActive => status == MentorshipRequestStatus.accepted;

  /// Get time ago string.
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 30) {
      final months = difference.inDays ~/ 30;
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

/// Domain entity representing an active mentorship connection.
@freezed
class MentorshipConnection with _$MentorshipConnection {
  const MentorshipConnection._();

  const factory MentorshipConnection({
    required String id,
    required String mentorId,
    required String menteeId,
    required Mentor mentor,
    String? menteeName,
    String? menteeAvatar,
    required DateTime startedAt,
    DateTime? endedAt,
    @Default(false) bool isActive,
    String? notes,
  }) = _MentorshipConnection;

  /// Get duration string.
  String get duration {
    final end = endedAt ?? DateTime.now();
    final difference = end.difference(startedAt);

    if (difference.inDays > 365) {
      final years = difference.inDays ~/ 365;
      return '$years ${years == 1 ? 'year' : 'years'}';
    } else if (difference.inDays > 30) {
      final months = difference.inDays ~/ 30;
      return '$months ${months == 1 ? 'month' : 'months'}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'}';
    } else {
      return 'Started today';
    }
  }
}
