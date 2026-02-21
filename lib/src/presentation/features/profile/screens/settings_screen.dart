import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../data/cache/cache_service.dart';
import '../../auth/providers/auth_provider.dart';
import '../../notifications/providers/notification_provider.dart';
import '../../notifications/screens/notification_settings_screen.dart';

/// Settings screen for account and app preferences.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  void _showChangePasswordDialog(BuildContext context, WidgetRef ref) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final user = ref.read(currentUserProvider);

    if (user == null) return;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Change Password'),
        content: const Text(
          'We\'ll send a password reset link to your email address. '
          'You can use this link to set a new password.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              final success = await ref
                  .read(authProvider.notifier)
                  .forgotPassword(user.email);

              scaffoldMessenger.showSnackBar(
                SnackBar(
                  content: Text(
                    success
                        ? 'Password reset link sent to ${user.email}'
                        : 'Failed to send reset link. Please try again.',
                  ),
                  backgroundColor:
                      success ? AppColors.success : AppColors.danger,
                ),
              );

              if (!success) {
                ref.read(authProvider.notifier).clearError();
              }
            },
            child: const Text('Send Link'),
          ),
        ],
      ),
    );
  }

  void _showClearCacheDialog(BuildContext context, WidgetRef ref) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text(
          'This will clear all cached data including news, opportunities, and events. '
          'The app will re-download data when you\'re online.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              final cacheService = ref.read(cacheServiceProvider);
              await cacheService.clearAll();
              scaffoldMessenger.showSnackBar(
                const SnackBar(
                  content: Text('Cache cleared successfully'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context, WidgetRef ref) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'This action cannot be undone. All your data will be permanently deleted. '
          'Please contact support@rwandaconnect.com to request account deletion.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              scaffoldMessenger.showSnackBar(
                const SnackBar(
                  content: Text(
                    'Please email support@rwandaconnect.com to delete your account',
                  ),
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: const Text('Contact Support'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: AppSpacing.md),

          // Account Section
          _SectionHeader(title: 'Account'),
          _SettingsItem(
            icon: Icons.email_outlined,
            title: 'Email',
            subtitle: user?.email ?? '',
            onTap: null, // Email cannot be changed
          ),
          _SettingsItem(
            icon: Icons.lock_outline,
            title: 'Change Password',
            subtitle: 'Update your password',
            onTap: () => _showChangePasswordDialog(context, ref),
          ),
          const Divider(height: AppSpacing.xxl),

          // Notifications Section
          _SectionHeader(title: 'Notifications'),
          Builder(
            builder: (context) {
              final prefsState = ref.watch(notificationPreferencesProvider);
              final prefs = prefsState.preferences;

              return Column(
                children: [
                  _SettingsToggle(
                    icon: Icons.notifications_outlined,
                    title: 'Push Notifications',
                    subtitle: 'Receive notifications about opportunities and events',
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
                    subtitle: 'Receive weekly digest and important updates',
                    value: prefs.emailEnabled,
                    onChanged: (value) {
                      ref
                          .read(notificationPreferencesProvider.notifier)
                          .setEmailEnabled(value);
                    },
                  ),
                  _SettingsItem(
                    icon: Icons.tune,
                    title: 'Notification Preferences',
                    subtitle: 'Customize notification types',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const NotificationSettingsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
          const Divider(height: AppSpacing.xxl),

          // Storage Section
          _SectionHeader(title: 'Storage'),
          _SettingsItem(
            icon: Icons.storage_outlined,
            title: 'Clear Cache',
            subtitle: 'Free up space by clearing cached data',
            onTap: () => _showClearCacheDialog(context, ref),
          ),
          const Divider(height: AppSpacing.xxl),

          // Danger Zone
          _SectionHeader(title: 'Danger Zone'),
          _SettingsItem(
            icon: Icons.delete_outline,
            title: 'Delete Account',
            subtitle: 'Permanently delete your account and data',
            textColor: AppColors.danger,
            onTap: () => _showDeleteAccountDialog(context, ref),
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

class _SettingsItem extends StatelessWidget {
  const _SettingsItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.textColor,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? textColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: textColor ?? AppColors.primaryText,
      ),
      title: Text(
        title,
        style: AppTypography.bodyLarge.copyWith(
          color: textColor,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: AppTypography.bodySmallSecondary,
            )
          : null,
      trailing: onTap != null
          ? const Icon(
              Icons.chevron_right,
              color: AppColors.secondaryText,
            )
          : null,
      onTap: onTap,
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
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryText),
      title: Text(title, style: AppTypography.bodyLarge),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: AppTypography.bodySmallSecondary,
            )
          : null,
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeTrackColor: AppColors.primary.withValues(alpha: 0.5),
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return null;
        }),
      ),
    );
  }
}
