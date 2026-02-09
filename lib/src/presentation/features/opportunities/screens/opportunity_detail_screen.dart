import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/theme.dart';
import '../../../../domain/entities/opportunity.dart';
import '../../profile/providers/subscription_provider.dart';
import '../../profile/screens/paywall_screen.dart';
import '../providers/opportunity_provider.dart';

/// Detail screen for viewing a single opportunity.
class OpportunityDetailScreen extends ConsumerWidget {
  const OpportunityDetailScreen({
    super.key,
    required this.opportunityId,
  });

  final String opportunityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final opportunityAsync = ref.watch(opportunityDetailProvider(opportunityId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Opportunity Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implement share functionality
            },
          ),
        ],
      ),
      body: opportunityAsync.when(
        data: (opportunity) {
          if (opportunity == null) {
            return const _NotFoundState();
          }
          return _OpportunityDetailContent(opportunity: opportunity);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _ErrorState(
          message: error.toString(),
          onRetry: () => ref.refresh(opportunityDetailProvider(opportunityId)),
        ),
      ),
    );
  }
}

class _OpportunityDetailContent extends StatelessWidget {
  const _OpportunityDetailContent({required this.opportunity});

  final Opportunity opportunity;

  String _formatSalary(int? salary) {
    if (salary == null) return 'Not specified';
    if (salary >= 1000) {
      return '\$${(salary / 1000).toStringAsFixed(0)}k/year';
    }
    return '\$$salary/year';
  }

  String _formatDeadline(DateTime deadline) {
    final now = DateTime.now();
    final difference = deadline.difference(now).inDays;

    if (difference < 0) {
      return 'Expired';
    } else if (difference == 0) {
      return 'Due today';
    } else if (difference == 1) {
      return 'Due tomorrow';
    } else if (difference < 7) {
      return 'Due in $difference days';
    } else {
      return '${deadline.day}/${deadline.month}/${deadline.year}';
    }
  }

  Future<void> _launchApplyUrl(BuildContext context) async {
    if (opportunity.applyUrl == null) return;

    final uri = Uri.parse(opportunity.applyUrl!);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open application link')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isExpired = opportunity.isExpired;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: AppSpacing.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.md),

                // Type badge and verified status
                Row(
                  children: [
                    _TypeBadge(type: opportunity.type),
                    if (opportunity.verified) ...[
                      const SizedBox(width: AppSpacing.md),
                      const _VerifiedBadge(),
                    ],
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),

                // Title
                Text(
                  opportunity.title,
                  style: AppTypography.headlineMedium,
                ),
                const SizedBox(height: AppSpacing.sm),

                // Company
                Text(
                  opportunity.company,
                  style: AppTypography.titleMedium.copyWith(
                    color: AppColors.secondaryText,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),

                // Info cards
                _InfoCard(
                  children: [
                    _InfoRow(
                      icon: Icons.location_on_outlined,
                      label: 'Location',
                      value: opportunity.location,
                    ),
                    const Divider(height: AppSpacing.xxl),
                    _InfoRow(
                      icon: Icons.attach_money,
                      label: 'Salary',
                      value: _formatSalary(opportunity.salary),
                    ),
                    const Divider(height: AppSpacing.xxl),
                    _InfoRow(
                      icon: Icons.schedule,
                      label: 'Deadline',
                      value: _formatDeadline(opportunity.deadline),
                      valueColor: isExpired ? AppColors.danger : null,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xxl),

                // Description
                if (opportunity.description != null &&
                    opportunity.description!.isNotEmpty) ...[
                  Text(
                    'Description',
                    style: AppTypography.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    opportunity.description!,
                    style: AppTypography.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                ],

                // Deadline warning
                if (!isExpired && opportunity.daysUntilDeadline <= 7) ...[
                  _DeadlineWarning(daysLeft: opportunity.daysUntilDeadline),
                  const SizedBox(height: AppSpacing.xxl),
                ],
              ],
            ),
          ),
        ),

        // Bottom action bar
        _BottomActionBar(
          isExpired: isExpired,
          hasApplyUrl: opportunity.applyUrl != null,
          onApply: () => _launchApplyUrl(context),
        ),
      ],
    );
  }
}

class _TypeBadge extends StatelessWidget {
  const _TypeBadge({required this.type});

  final OpportunityType type;

  Color _getTypeColor() {
    return switch (type) {
      OpportunityType.job => AppColors.accent,
      OpportunityType.investment => AppColors.success,
      OpportunityType.scholarship => AppColors.warning,
      OpportunityType.tender => AppColors.info,
    };
  }

  @override
  Widget build(BuildContext context) {
    final color = _getTypeColor();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: AppRadius.pillRadius,
      ),
      child: Text(
        type.label,
        style: AppTypography.labelMedium.copyWith(color: color),
      ),
    );
  }
}

class _VerifiedBadge extends StatelessWidget {
  const _VerifiedBadge();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.verified,
          size: AppSizes.iconMd,
          color: AppColors.success,
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          'Verified',
          style: AppTypography.labelMedium.copyWith(
            color: AppColors.success,
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: AppSizes.iconMd,
          color: AppColors.secondaryText,
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.bodySmallSecondary,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                value,
                style: AppTypography.bodyLarge.copyWith(
                  color: valueColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DeadlineWarning extends StatelessWidget {
  const _DeadlineWarning({required this.daysLeft});

  final int daysLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.1),
        borderRadius: AppRadius.cardRadius,
        border: Border.all(
          color: AppColors.warning.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: AppColors.warning,
            size: AppSizes.iconMd,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              daysLeft == 0
                  ? 'This opportunity expires today!'
                  : daysLeft == 1
                      ? 'Only 1 day left to apply!'
                      : 'Only $daysLeft days left to apply!',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.warning,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomActionBar extends ConsumerWidget {
  const _BottomActionBar({
    required this.isExpired,
    required this.hasApplyUrl,
    required this.onApply,
  });

  final bool isExpired;
  final bool hasApplyUrl;
  final VoidCallback onApply;

  void _openPaywall(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PaywallScreen(),
        fullscreenDialog: true,
      ),
    );
  }

  void _handleApply(BuildContext context, bool canApply) {
    if (!canApply) {
      _openPaywall(context);
      return;
    }
    onApply();
  }

  void _handleBookmark(BuildContext context, bool canBookmark) {
    if (!canBookmark) {
      _openPaywall(context);
      return;
    }
    // TODO: Implement bookmark functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Bookmark feature coming soon')),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscriptionState = ref.watch(subscriptionProvider);
    final canApply = subscriptionState.canApply;
    final canBookmark = subscriptionState.canBookmark;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Bookmark button
            IconButton.outlined(
              onPressed: () => _handleBookmark(context, canBookmark),
              icon: Icon(
                canBookmark ? Icons.bookmark_border : Icons.lock_outline,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            // Apply button
            Expanded(
              child: ElevatedButton(
                onPressed: isExpired || !hasApplyUrl
                    ? null
                    : () => _handleApply(context, canApply),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!canApply && !isExpired && hasApplyUrl) ...[
                      const Icon(Icons.lock_outline, size: 18),
                      const SizedBox(width: AppSpacing.sm),
                    ],
                    Text(
                      isExpired
                          ? 'Expired'
                          : hasApplyUrl
                              ? canApply
                                  ? 'Apply Now'
                                  : 'Upgrade to Apply'
                              : 'No Application Link',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotFoundState extends StatelessWidget {
  const _NotFoundState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.screenPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_off,
            size: 64,
            color: AppColors.secondaryText,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Opportunity Not Found',
            style: AppTypography.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'This opportunity may have been removed or is no longer available.',
            style: AppTypography.bodyMediumSecondary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.screenPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: AppColors.secondaryText,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Something went wrong',
            style: AppTypography.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            message,
            style: AppTypography.bodyMediumSecondary,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xxl),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}
