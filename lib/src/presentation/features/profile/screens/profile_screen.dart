import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/theme.dart';
import '../../../../domain/entities/user.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/subscription_provider.dart';
import '../widgets/subscription_card.dart';
import 'about_screen.dart';
import 'edit_profile_screen.dart';
import 'help_screen.dart';
import 'paywall_screen.dart';
import 'privacy_policy_screen.dart';
import 'settings_screen.dart';
import 'terms_of_service_screen.dart';

/// Profile screen showing user information and settings.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  void _handleLogout(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(authProvider.notifier).logout();
            },
            style: TextButton.styleFrom(
              foregroundColor: AppColors.danger,
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  void _openPaywall(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PaywallScreen(),
        fullscreenDialog: true,
      ),
    );
  }

  Future<void> _openBillingPortal(BuildContext context, WidgetRef ref) async {
    final url = await ref.read(subscriptionProvider.notifier).getBillingPortalUrl();

    if (url != null) {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open billing portal'),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final subscriptionState = ref.watch(subscriptionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(subscriptionProvider.notifier).refresh();
        },
        child: ListView(
          padding: AppSpacing.screenPadding,
          children: [
            const SizedBox(height: AppSpacing.lg),
            _UserHeader(user: user),
            const SizedBox(height: AppSpacing.xxl),

            // Subscription card
            if (subscriptionState.isLoading && subscriptionState.subscription == null)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.xxl),
                  child: Center(child: CircularProgressIndicator()),
                ),
              )
            else
              SubscriptionCard(
                onUpgrade: () => _openPaywall(context),
                onManage: () => _openBillingPortal(context, ref),
              ),

            const SizedBox(height: AppSpacing.xxl),

            // Interests section
            Text(
              'Interests',
              style: AppTypography.titleMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            _InterestsList(interests: user?.interests ?? []),
            const SizedBox(height: AppSpacing.xxl),

            // Menu items
            _ProfileMenuItem(
              icon: Icons.person_outline,
              title: 'Edit Profile',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                );
              },
            ),
            _ProfileMenuItem(
              icon: Icons.bookmark_outline,
              title: 'Saved Items',
              subtitle: subscriptionState.canBookmark ? null : 'Upgrade to access',
              onTap: () {
                if (!subscriptionState.canBookmark) {
                  _openPaywall(context);
                } else {
                  context.push(AppRoutes.bookmarks);
                }
              },
            ),
            _ProfileMenuItem(
              icon: Icons.calendar_today_outlined,
              title: 'My RSVPs',
              onTap: () {
                context.push(AppRoutes.myRsvps);
              },
            ),
            _ProfileMenuItem(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const HelpScreen()),
                );
              },
            ),
            _ProfileMenuItem(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
                );
              },
            ),
            _ProfileMenuItem(
              icon: Icons.description_outlined,
              title: 'Terms of Service',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const TermsOfServiceScreen()),
                );
              },
            ),
            _ProfileMenuItem(
              icon: Icons.info_outline,
              title: 'About',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AboutScreen()),
                );
              },
            ),
            const SizedBox(height: AppSpacing.xxl),

            // Sign out button
            OutlinedButton(
              onPressed: () => _handleLogout(context, ref),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.danger,
                side: const BorderSide(color: AppColors.danger),
              ),
              child: const Text('Sign Out'),
            ),
            const SizedBox(height: AppSpacing.lg),

            // App version
            Center(
              child: Text(
                'Rwanda Connect v1.0.0',
                style: AppTypography.bodySmallSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.xxxl),
          ],
        ),
      ),
    );
  }
}

class _UserHeader extends StatelessWidget {
  const _UserHeader({this.user});

  final User? user;

  String _getInitials(String? name) {
    if (name == null || name.isEmpty) return '?';
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CircleAvatar(
            radius: AppSizes.avatarXl / 2,
            backgroundColor: AppColors.primary,
            child: Text(
              _getInitials(user?.name),
              style: AppTypography.displaySmall.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          user?.name ?? 'User',
          style: AppTypography.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          user?.email ?? '',
          style: AppTypography.bodyMediumSecondary,
          textAlign: TextAlign.center,
        ),
        if (user?.location != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: AppSizes.iconSm,
                color: AppColors.secondaryText,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                user!.location!,
                style: AppTypography.bodySmallSecondary,
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _InterestsList extends StatelessWidget {
  const _InterestsList({required this.interests});

  final List<String> interests;

  @override
  Widget build(BuildContext context) {
    if (interests.isEmpty) {
      return Text(
        'No interests added yet',
        style: AppTypography.bodyMediumSecondary,
      );
    }

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: interests.map((interest) => _InterestTag(label: interest)).toList(),
    );
  }
}

class _InterestTag extends StatelessWidget {
  const _InterestTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: AppRadius.pillRadius,
      ),
      child: Text(
        label,
        style: AppTypography.labelMedium,
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.primaryText),
      title: Text(title, style: AppTypography.bodyLarge),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.warning,
              ),
            )
          : null,
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.secondaryText,
      ),
      onTap: onTap,
    );
  }
}
