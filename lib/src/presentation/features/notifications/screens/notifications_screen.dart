import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../domain/entities/app_notification.dart';
import '../providers/notification_provider.dart';

/// Screen showing notification history.
class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  void _showClearDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Clear Notifications'),
        content: const Text(
          'Are you sure you want to clear all notifications? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              ref.read(notificationsProvider.notifier).clearAll();
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          if (state.notifications.isNotEmpty) ...[
            if (state.unreadCount > 0)
              TextButton(
                onPressed: () {
                  ref.read(notificationsProvider.notifier).markAllAsRead();
                },
                child: const Text('Mark All Read'),
              ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _showClearDialog(context, ref),
              tooltip: 'Clear all',
            ),
          ],
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.notifications.isEmpty
              ? const _EmptyState()
              : RefreshIndicator(
                  onRefresh: () =>
                      ref.read(notificationsProvider.notifier).loadNotifications(),
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                    itemCount: state.notifications.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final notification = state.notifications[index];
                      return _NotificationTile(
                        notification: notification,
                        onTap: () {
                          ref
                              .read(notificationsProvider.notifier)
                              .markAsRead(notification.id);
                          // Handle navigation based on notification type/data
                          _handleNotificationTap(context, notification);
                        },
                      );
                    },
                  ),
                ),
    );
  }

  void _handleNotificationTap(BuildContext context, AppNotification notification) {
    // Can navigate to specific screens based on notification type
    // For now, just mark as read
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opened: ${notification.title}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_off_outlined,
              size: 80,
              color: AppColors.secondaryText.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'No Notifications',
              style: AppTypography.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'You\'re all caught up! Check back later for updates on opportunities, events, and more.',
              style: AppTypography.bodyMediumSecondary,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({
    required this.notification,
    required this.onTap,
  });

  final AppNotification notification;
  final VoidCallback onTap;

  IconData _getIcon() {
    switch (notification.type) {
      case NotificationType.opportunity:
        return Icons.work_outline;
      case NotificationType.event:
        return Icons.event_outlined;
      case NotificationType.community:
        return Icons.forum_outlined;
      case NotificationType.system:
        return Icons.info_outline;
      case NotificationType.subscription:
        return Icons.card_membership_outlined;
    }
  }

  Color _getIconColor() {
    switch (notification.type) {
      case NotificationType.opportunity:
        return AppColors.primary;
      case NotificationType.event:
        return AppColors.accent;
      case NotificationType.community:
        return Colors.purple;
      case NotificationType.system:
        return AppColors.secondaryText;
      case NotificationType.subscription:
        return AppColors.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: notification.isRead
            ? null
            : AppColors.primary.withValues(alpha: 0.05),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _getIconColor().withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getIcon(),
                color: _getIconColor(),
                size: 22,
              ),
            ),
            const SizedBox(width: AppSpacing.md),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: AppTypography.titleSmall.copyWith(
                            fontWeight: notification.isRead
                                ? FontWeight.normal
                                : FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        notification.timeAgo,
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    notification.body,
                    style: AppTypography.bodyMedium.copyWith(
                      color: notification.isRead
                          ? AppColors.secondaryText
                          : AppColors.primaryText,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Unread indicator
            if (!notification.isRead) ...[
              const SizedBox(width: AppSpacing.sm),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
