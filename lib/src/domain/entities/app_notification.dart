import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_notification.freezed.dart';

/// Type of notification.
enum NotificationType {
  opportunity,
  event,
  community,
  system,
  subscription,
}

/// Domain entity representing an in-app notification.
@freezed
class AppNotification with _$AppNotification {
  const AppNotification._();

  const factory AppNotification({
    required String id,
    required String title,
    required String body,
    required NotificationType type,
    required DateTime createdAt,
    @Default(false) bool isRead,
    String? actionUrl,
    String? imageUrl,
    Map<String, dynamic>? data,
  }) = _AppNotification;

  /// Get time ago string.
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 7) {
      return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  /// Get icon for notification type.
  String get typeIcon {
    switch (type) {
      case NotificationType.opportunity:
        return 'work';
      case NotificationType.event:
        return 'event';
      case NotificationType.community:
        return 'forum';
      case NotificationType.system:
        return 'info';
      case NotificationType.subscription:
        return 'card_membership';
    }
  }
}
