import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';

/// Domain entity representing a community post.
@freezed
class Post with _$Post {
  const Post._();

  const factory Post({
    required String id,
    required String authorId,
    required String authorName,
    required String content,
    required DateTime createdAt,
    String? authorAvatarUrl,
    @Default(0) int likeCount,
    @Default(0) int commentCount,
    @Default(false) bool isLiked,
  }) = _Post;

  /// Check if the post was created today.
  bool get isToday {
    final now = DateTime.now();
    return createdAt.year == now.year &&
        createdAt.month == now.month &&
        createdAt.day == now.day;
  }

  /// Get relative time string.
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    }
  }
}

/// Sort options for posts.
enum PostSortOption {
  newest('createdAt:desc', 'Newest'),
  oldest('createdAt:asc', 'Oldest');

  const PostSortOption(this.value, this.label);

  final String value;
  final String label;
}
