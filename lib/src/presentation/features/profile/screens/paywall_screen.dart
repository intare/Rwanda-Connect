import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../domain/entities/subscription.dart';
import '../providers/subscription_provider.dart';

/// Paywall screen for upgrading subscription.
class PaywallScreen extends ConsumerStatefulWidget {
  const PaywallScreen({super.key});

  @override
  ConsumerState<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends ConsumerState<PaywallScreen> {
  SubscriptionPlan _selectedPlan = SubscriptionPlan.monthly;

  Future<void> _startTrial() async {
    final success = await ref.read(subscriptionProvider.notifier).activateTrial();

    if (!mounted) return;

    if (success) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your 30-day free trial has started!'),
          backgroundColor: AppColors.success,
        ),
      );
    } else {
      final error = ref.read(subscriptionProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error ?? 'Failed to start trial'),
          backgroundColor: AppColors.danger,
        ),
      );
    }
  }

  void _subscribe() {
    // TODO: Implement in-app purchase
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('In-app purchases coming soon'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(subscriptionProvider);
    final isOnFreePlan = state.subscription?.plan == SubscriptionPlan.free;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upgrade'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: AppSpacing.screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.lg),

                    // Hero section
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: AppColors.accent.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.workspace_premium,
                              size: 40,
                              color: AppColors.accent,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          Text(
                            'Unlock Full Access',
                            style: AppTypography.headlineMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            'Get access to all opportunities and premium features',
                            style: AppTypography.bodyMediumSecondary,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxxl),

                    // Features list
                    Text(
                      'What you get',
                      style: AppTypography.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const _FeatureItem(
                      icon: Icons.send,
                      title: 'Apply to opportunities',
                      description: 'Submit applications directly through the app',
                    ),
                    const _FeatureItem(
                      icon: Icons.bookmark,
                      title: 'Save & bookmark',
                      description: 'Save opportunities and events for later',
                    ),
                    const _FeatureItem(
                      icon: Icons.people,
                      title: 'Mentorship access',
                      description: 'Connect with mentors in your field',
                    ),
                    const _FeatureItem(
                      icon: Icons.analytics,
                      title: 'Premium analytics',
                      description: 'Track your application progress',
                      isPremium: true,
                    ),
                    const _FeatureItem(
                      icon: Icons.support_agent,
                      title: 'Priority support',
                      description: 'Get help faster when you need it',
                      isPremium: true,
                    ),
                    const SizedBox(height: AppSpacing.xxl),

                    // Plan selection
                    if (!isOnFreePlan) ...[
                      Text(
                        'Choose your plan',
                        style: AppTypography.titleMedium,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _PlanOption(
                        plan: SubscriptionPlan.monthly,
                        price: '\$9.99',
                        period: '/month',
                        isSelected: _selectedPlan == SubscriptionPlan.monthly,
                        onTap: () => setState(() => _selectedPlan = SubscriptionPlan.monthly),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _PlanOption(
                        plan: SubscriptionPlan.yearly,
                        price: '\$95.99',
                        period: '/year',
                        badge: 'Save 20%',
                        isSelected: _selectedPlan == SubscriptionPlan.yearly,
                        onTap: () => setState(() => _selectedPlan = SubscriptionPlan.yearly),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Bottom action
            Container(
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isOnFreePlan) ...[
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state.isActivatingTrial ? null : _startTrial,
                        child: state.isActivatingTrial
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Start 30-Day Free Trial'),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'No credit card required',
                      style: AppTypography.bodySmallSecondary,
                      textAlign: TextAlign.center,
                    ),
                  ] else ...[
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _subscribe,
                        child: Text(
                          _selectedPlan == SubscriptionPlan.monthly
                              ? 'Subscribe for \$9.99/month'
                              : 'Subscribe for \$95.99/year',
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Cancel anytime. Renews automatically.',
                      style: AppTypography.bodySmallSecondary,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
    this.isPremium = false,
  });

  final IconData icon;
  final String title;
  final String description;
  final bool isPremium;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: AppRadius.cardRadius,
            ),
            child: Icon(
              icon,
              size: AppSizes.iconMd,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(title, style: AppTypography.titleSmall),
                    if (isPremium) ...[
                      const SizedBox(width: AppSpacing.xs),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.warning.withValues(alpha: 0.1),
                          borderRadius: AppRadius.pillRadius,
                        ),
                        child: Text(
                          'PAID',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.warning,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  description,
                  style: AppTypography.bodySmallSecondary,
                ),
              ],
            ),
          ),
          const Icon(
            Icons.check_circle,
            size: AppSizes.iconMd,
            color: AppColors.success,
          ),
        ],
      ),
    );
  }
}

class _PlanOption extends StatelessWidget {
  const _PlanOption({
    required this.plan,
    required this.price,
    required this.period,
    required this.isSelected,
    required this.onTap,
    this.badge,
  });

  final SubscriptionPlan plan;
  final String price;
  final String period;
  final String? badge;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.cardRadius,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.accent : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: AppRadius.cardRadius,
          color: isSelected ? AppColors.accent.withValues(alpha: 0.05) : null,
        ),
        child: Row(
          children: [
            // Radio indicator
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.accent : AppColors.border,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.accent,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: AppSpacing.lg),
            // Plan info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        plan == SubscriptionPlan.monthly ? 'Monthly' : 'Yearly',
                        style: AppTypography.titleSmall,
                      ),
                      if (badge != null) ...[
                        const SizedBox(width: AppSpacing.sm),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.success,
                            borderRadius: AppRadius.pillRadius,
                          ),
                          child: Text(
                            badge!,
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    plan == SubscriptionPlan.monthly
                        ? 'Billed monthly'
                        : 'Billed annually',
                    style: AppTypography.bodySmallSecondary,
                  ),
                ],
              ),
            ),
            // Price
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(price, style: AppTypography.titleMedium),
                Text(period, style: AppTypography.bodySmallSecondary),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
