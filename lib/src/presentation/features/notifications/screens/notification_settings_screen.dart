import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../data/services/local_notification_service.dart';
import '../../../../domain/entities/app_notification.dart';
import '../providers/notification_provider.dart';

/// Screen for managing notification preferences.
class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationPreferencesProvider);
    final prefs = state.preferences;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: AppSpacing.md),

          // Main toggles section
          _SectionHeader(title: 'Notification Channels'),
          _SettingsToggle(
            icon: Icons.notifications_outlined,
            title: 'Push Notifications',
            subtitle: 'Receive notifications on your device',
            value: prefs.pushEnabled,
            onChanged: (value) {
              ref
                  .read(notificationPreferencesProvider.notifier)
                  .setPushEnabled(value);
            },
          ),
          _SettingsToggle(
            icon: Icons.email_outlined,
            title: 'Email Notifications',
            subtitle: 'Receive updates via email',
            value: prefs.emailEnabled,
            onChanged: (value) {
              ref
                  .read(notificationPreferencesProvider.notifier)
                  .setEmailEnabled(value);
            },
          ),

          const Divider(height: AppSpacing.xxl),

          // Category toggles
          _SectionHeader(title: 'Notification Types'),
          Padding(
            padding: AppSpacing.horizontalLg,
            child: Text(
              'Choose which types of notifications you want to receive',
              style: AppTypography.bodySmallSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          _SettingsToggle(
            icon: Icons.work_outline,
            title: 'Opportunity Alerts',
            subtitle: 'New opportunities matching your interests',
            value: prefs.opportunityAlerts,
            enabled: prefs.pushEnabled,
            onChanged: (value) {
              ref
                  .read(notificationPreferencesProvider.notifier)
                  .setOpportunityAlerts(value);
            },
          ),
          _SettingsToggle(
            icon: Icons.event_outlined,
            title: 'Event Reminders',
            subtitle: 'Upcoming events and RSVP reminders',
            value: prefs.eventReminders,
            enabled: prefs.pushEnabled,
            onChanged: (value) {
              ref
                  .read(notificationPreferencesProvider.notifier)
                  .setEventReminders(value);
            },
          ),
          _SettingsToggle(
            icon: Icons.forum_outlined,
            title: 'Community Updates',
            subtitle: 'Replies and mentions in discussions',
            value: prefs.communityUpdates,
            enabled: prefs.pushEnabled,
            onChanged: (value) {
              ref
                  .read(notificationPreferencesProvider.notifier)
                  .setCommunityUpdates(value);
            },
          ),
          _SettingsToggle(
            icon: Icons.card_membership_outlined,
            title: 'Subscription Alerts',
            subtitle: 'Trial expiration and billing updates',
            value: prefs.subscriptionAlerts,
            enabled: prefs.pushEnabled,
            onChanged: (value) {
              ref
                  .read(notificationPreferencesProvider.notifier)
                  .setSubscriptionAlerts(value);
            },
          ),

          const SizedBox(height: AppSpacing.xxl),

          // Test notification button
          Padding(
            padding: AppSpacing.screenPadding,
            child: OutlinedButton.icon(
              onPressed: prefs.pushEnabled
                  ? () async {
                      final service = ref.read(localNotificationServiceProvider);
                      await service.showNotification(
                        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
                        title: 'Test Notification',
                        body: 'This is a test notification from Rwanda Connect.',
                        type: NotificationType.system,
                      );
                      ref.read(notificationsProvider.notifier).loadNotifications();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Test notification sent!'),
                          ),
                        );
                      }
                    }
                  : null,
              icon: const Icon(Icons.send),
              label: const Text('Send Test Notification'),
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),

          // Info section
          Padding(
            padding: AppSpacing.screenPadding,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.info.withValues(alpha: 0.1),
                borderRadius: AppRadius.cardRadius,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.info,
                    size: 24,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      'You can also manage notifications in your device settings.',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.info,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xxxl),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: Text(
        title.toUpperCase(),
        style: AppTypography.labelSmall.copyWith(
          color: AppColors.secondaryText,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _SettingsToggle extends StatelessWidget {
  const _SettingsToggle({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
    this.enabled = true,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final bool value;
  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: ListTile(
        leading: Icon(
          icon,
          color: enabled ? AppColors.primaryText : AppColors.secondaryText,
        ),
        title: Text(
          title,
          style: AppTypography.bodyLarge,
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: AppTypography.bodySmallSecondary,
              )
            : null,
        trailing: Switch(
          value: value && enabled,
          onChanged: enabled ? onChanged : null,
          activeTrackColor: AppColors.primary.withValues(alpha: 0.5),
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primary;
            }
            return null;
          }),
        ),
      ),
    );
  }
}
