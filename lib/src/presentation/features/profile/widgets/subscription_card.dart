import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../domain/entities/subscription.dart';
import '../providers/subscription_provider.dart';

/// Card displaying subscription status and upgrade options.
class SubscriptionCard extends ConsumerWidget {
  const SubscriptionCard({
    super.key,
    this.onUpgrade,
    this.onManage,
  });

  final VoidCallback? onUpgrade;
  final VoidCallback? onManage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(subscriptionProvider);
    final subscription = state.subscription;

    if (subscription == null) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                _PlanBadge(plan: subscription.plan),
                const Spacer(),
                if (subscription.status == SubscriptionStatus.active)
                  const _StatusIndicator(isActive: true)
                else
                  const _StatusIndicator(isActive: false),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Plan details
            Text(
              _getPlanTitle(subscription),
              style: AppTypography.titleMedium,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              _getPlanDescription(subscription),
              style: AppTypography.bodyMediumSecondary,
            ),

            // Trial countdown
            if (subscription.plan == SubscriptionPlan.trial &&
                subscription.trialDaysRemaining != null) ...[
              const SizedBox(height: AppSpacing.md),
              _TrialCountdown(daysRemaining: subscription.trialDaysRemaining!),
            ],

            const SizedBox(height: AppSpacing.lg),

            // Action buttons
            if (subscription.plan == SubscriptionPlan.free)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onUpgrade,
                  child: const Text('Start Free Trial'),
                ),
              )
            else if (subscription.plan == SubscriptionPlan.trial)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onUpgrade,
                  child: const Text('Upgrade to Premium'),
                ),
              )
            else
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: onManage,
                  child: const Text('Manage Subscription'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getPlanTitle(Subscription subscription) {
    return switch (subscription.plan) {
      SubscriptionPlan.free => 'Free Plan',
      SubscriptionPlan.trial => '30-Day Free Trial',
      SubscriptionPlan.monthly => 'Monthly Premium',
      SubscriptionPlan.yearly => 'Yearly Premium',
    };
  }

  String _getPlanDescription(Subscription subscription) {
    return switch (subscription.plan) {
      SubscriptionPlan.free =>
        'Upgrade to apply to opportunities and access premium features.',
      SubscriptionPlan.trial =>
        'Enjoy full access to all features during your trial.',
      SubscriptionPlan.monthly =>
        'Full access to all features. Billed monthly.',
      SubscriptionPlan.yearly =>
        'Full access to all features. Save 20% with annual billing.',
    };
  }
}

class _PlanBadge extends StatelessWidget {
  const _PlanBadge({required this.plan});

  final SubscriptionPlan plan;

  @override
  Widget build(BuildContext context) {
    final (color, icon) = switch (plan) {
      SubscriptionPlan.free => (AppColors.secondaryText, Icons.person_outline),
      SubscriptionPlan.trial => (AppColors.warning, Icons.access_time),
      SubscriptionPlan.monthly => (AppColors.accent, Icons.star),
      SubscriptionPlan.yearly => (AppColors.success, Icons.workspace_premium),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: AppRadius.pillRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppSizes.iconSm, color: color),
          const SizedBox(width: AppSpacing.xs),
          Text(
            plan.value.toUpperCase(),
            style: AppTypography.labelSmall.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

class _StatusIndicator extends StatelessWidget {
  const _StatusIndicator({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? AppColors.success : AppColors.danger,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          isActive ? 'Active' : 'Inactive',
          style: AppTypography.labelSmall.copyWith(
            color: isActive ? AppColors.success : AppColors.danger,
          ),
        ),
      ],
    );
  }
}

class _TrialCountdown extends StatelessWidget {
  const _TrialCountdown({required this.daysRemaining});

  final int daysRemaining;

  @override
  Widget build(BuildContext context) {
    final isUrgent = daysRemaining <= 7;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: (isUrgent ? AppColors.warning : AppColors.accent)
            .withValues(alpha: 0.1),
        borderRadius: AppRadius.cardRadius,
      ),
      child: Row(
        children: [
          Icon(
            Icons.timer_outlined,
            size: AppSizes.iconMd,
            color: isUrgent ? AppColors.warning : AppColors.accent,
          ),
          const SizedBox(width: AppSpacing.md),
          Text(
            daysRemaining == 0
                ? 'Trial ends today!'
                : daysRemaining == 1
                    ? '1 day remaining'
                    : '$daysRemaining days remaining',
            style: AppTypography.labelMedium.copyWith(
              color: isUrgent ? AppColors.warning : AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }
}
