import 'package:freezed_annotation/freezed_annotation.dart';

part 'playbook.freezed.dart';

/// Content type for playbook items.
enum PlaybookContentType {
  guide('guide', 'Guide'),
  video('video', 'Video'),
  story('story', 'Story'),
  course('course', 'Course'),
  report('report', 'Report');

  const PlaybookContentType(this.value, this.label);
  final String value;
  final String label;

  static PlaybookContentType fromString(String value) {
    return PlaybookContentType.values.firstWhere(
      (e) => e.value == value.toLowerCase(),
      orElse: () => PlaybookContentType.guide,
    );
  }
}

/// Difficulty level for playbook content.
enum PlaybookDifficulty {
  beginner('beginner', 'Beginner'),
  intermediate('intermediate', 'Intermediate'),
  advanced('advanced', 'Advanced');

  const PlaybookDifficulty(this.value, this.label);
  final String value;
  final String label;

  static PlaybookDifficulty fromString(String value) {
    return PlaybookDifficulty.values.firstWhere(
      (e) => e.value == value.toLowerCase(),
      orElse: () => PlaybookDifficulty.beginner,
    );
  }
}

/// Category for playbook content.
@freezed
class PlaybookCategory with _$PlaybookCategory {
  const PlaybookCategory._();

  const factory PlaybookCategory({
    required String id,
    required String name,
    String? description,
    String? icon,
    @Default(0) int contentCount,
  }) = _PlaybookCategory;
}

/// Author of playbook content.
@freezed
class PlaybookAuthor with _$PlaybookAuthor {
  const PlaybookAuthor._();

  const factory PlaybookAuthor({
    required String id,
    required String name,
    String? title,
    String? bio,
    String? avatar,
    String? company,
  }) = _PlaybookAuthor;
}

/// Domain entity representing a playbook content item.
@freezed
class PlaybookContent with _$PlaybookContent {
  const PlaybookContent._();

  const factory PlaybookContent({
    required String id,
    required String title,
    required PlaybookContentType type,
    required String summary,
    required String content,
    required PlaybookCategory category,
    PlaybookAuthor? author,
    @Default(PlaybookDifficulty.beginner) PlaybookDifficulty difficulty,
    String? coverImage,
    String? videoUrl,
    int? readingTimeMinutes,
    int? durationMinutes,
    @Default(false) bool isFeatured,
    @Default(false) bool isPremium,
    @Default(0) int viewCount,
    @Default(0) int likeCount,
    @Default([]) List<String> tags,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _PlaybookContent;

  /// Get formatted reading/duration time.
  String get formattedDuration {
    final minutes = readingTimeMinutes ?? durationMinutes;
    if (minutes == null) return '';
    if (minutes < 60) return '$minutes min';
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    if (remainingMinutes == 0) return '$hours hr';
    return '$hours hr $remainingMinutes min';
  }

  /// Get formatted view count.
  String get formattedViewCount {
    if (viewCount >= 1000000) {
      return '${(viewCount / 1000000).toStringAsFixed(1)}M views';
    } else if (viewCount >= 1000) {
      return '${(viewCount / 1000).toStringAsFixed(1)}K views';
    }
    return '$viewCount views';
  }

  /// Get formatted like count.
  String get formattedLikeCount {
    if (likeCount >= 1000000) {
      return '${(likeCount / 1000000).toStringAsFixed(1)}M';
    } else if (likeCount >= 1000) {
      return '${(likeCount / 1000).toStringAsFixed(1)}K';
    }
    return '$likeCount';
  }

  /// Get time ago string for created date.
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 365) {
      final years = difference.inDays ~/ 365;
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays > 30) {
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
