import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

/// A row of quick stat cards shown at the top of the dashboard.
class QuickStatsRow extends StatelessWidget {
  const QuickStatsRow({
    super.key,
    required this.bookmarksCount,
    required this.rsvpsCount,
    required this.subscriptionStatus,
  });

  final int bookmarksCount;
  final int rsvpsCount;
  final String subscriptionStatus;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: AppSpacing.horizontalLg,
        children: [
          _StatCard(
            icon: Icons.bookmark,
            value: bookmarksCount.toString(),
            label: 'Saved',
            accentColor: AppColors.accent,
          ),
          const SizedBox(width: AppSpacing.md),
          _StatCard(
            icon: Icons.event,
            value: rsvpsCount.toString(),
            label: 'RSVPs',
            accentColor: AppColors.success,
          ),
          const SizedBox(width: AppSpacing.md),
          _StatCard(
            icon: Icons.workspace_premium,
            value: _getStatusIcon(subscriptionStatus),
            label: _getStatusLabel(subscriptionStatus),
            accentColor: _getStatusColor(subscriptionStatus),
            isIconValue: true,
          ),
        ],
      ),
    );
  }

  String _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'monthly':
      case 'yearly':
        return 'star';
      case 'trial':
        return 'hourglass_top';
      default:
        return 'star_border';
    }
  }

  String _getStatusLabel(String status) {
    switch (status.toLowerCase()) {
      case 'monthly':
        return 'Monthly';
      case 'yearly':
        return 'Yearly';
      case 'trial':
        return 'Trial';
      default:
        return 'Free';
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'monthly':
      case 'yearly':
        return AppColors.warning;
      case 'trial':
        return AppColors.info;
      default:
        return AppColors.secondaryText;
    }
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.accentColor,
    this.isIconValue = false,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color accentColor;
  final bool isIconValue;

  IconData _getIconFromName(String name) {
    switch (name) {
      case 'star':
        return Icons.star;
      case 'hourglass_top':
        return Icons.hourglass_top;
      default:
        return Icons.star_border;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.cardRadius,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isIconValue)
            Icon(
              _getIconFromName(value),
              color: accentColor,
              size: 24,
            )
          else
            Text(
              value,
              style: AppTypography.titleLarge.copyWith(
                color: accentColor,
              ),
            ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}
