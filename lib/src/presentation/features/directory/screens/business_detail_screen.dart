import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/theme.dart';
import '../../../../domain/entities/business.dart';
import '../providers/directory_provider.dart';

/// Screen displaying detailed information about a business.
class BusinessDetailScreen extends ConsumerWidget {
  const BusinessDetailScreen({
    super.key,
    required this.businessId,
  });

  final String businessId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final businessAsync = ref.watch(businessDetailProvider(businessId));

    return Scaffold(
      body: businessAsync.when(
        data: (business) {
          if (business == null) {
            return _ErrorState(
              message: 'Business not found',
              onRetry: () => ref.invalidate(businessDetailProvider(businessId)),
            );
          }
          return _BusinessDetailContent(business: business);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _ErrorState(
          message: error.toString(),
          onRetry: () => ref.invalidate(businessDetailProvider(businessId)),
        ),
      ),
    );
  }
}

class _BusinessDetailContent extends StatelessWidget {
  const _BusinessDetailContent({required this.business});

  final Business business;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // App bar with gradient
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.gradientStart,
                    AppColors.gradientEnd,
                  ],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Logo
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: 0.2),
                              borderRadius: AppRadius.cardRadius,
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: business.logo != null
                                ? Image.network(
                                    business.logo!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Icon(
                                      Icons.store,
                                      color: AppColors.white,
                                      size: 32,
                                    ),
                                  )
                                : Icon(
                                    Icons.store,
                                    color: AppColors.white,
                                    size: 32,
                                  ),
                          ),
                          const SizedBox(width: AppSpacing.lg),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (business.isFeatured)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppSpacing.sm,
                                      vertical: 2,
                                    ),
                                    margin: const EdgeInsets.only(
                                      bottom: AppSpacing.xs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.warning,
                                      borderRadius: AppRadius.pillRadius,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 12,
                                          color: AppColors.white,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Featured',
                                          style:
                                              AppTypography.labelSmall.copyWith(
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                Text(
                                  business.name,
                                  style: AppTypography.headlineSmall.copyWith(
                                    color: AppColors.white,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        // Content
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category and status badges
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.1),
                        borderRadius: AppRadius.pillRadius,
                      ),
                      child: Text(
                        business.category.label,
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: business.isOpenNow
                            ? AppColors.success.withValues(alpha: 0.1)
                            : AppColors.secondaryText.withValues(alpha: 0.1),
                        borderRadius: AppRadius.pillRadius,
                      ),
                      child: Text(
                        business.isOpenNow ? 'Open Now' : 'Closed',
                        style: AppTypography.labelMedium.copyWith(
                          color: business.isOpenNow
                              ? AppColors.success
                              : AppColors.secondaryText,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.xxl),

                // Description
                if (business.description.isNotEmpty) ...[
                  Text(
                    'About',
                    style: AppTypography.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    business.description,
                    style: AppTypography.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                ],

                // Contact actions
                Text(
                  'Contact',
                  style: AppTypography.titleMedium,
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    if (business.phone != null)
                      Expanded(
                        child: _ActionButton(
                          icon: Icons.phone,
                          label: 'Call',
                          onTap: () => _launchUrl('tel:${business.phone}'),
                        ),
                      ),
                    if (business.phone != null && business.email != null)
                      const SizedBox(width: AppSpacing.md),
                    if (business.email != null)
                      Expanded(
                        child: _ActionButton(
                          icon: Icons.email,
                          label: 'Email',
                          onTap: () => _launchUrl('mailto:${business.email}'),
                        ),
                      ),
                    if ((business.phone != null || business.email != null) &&
                        business.website != null)
                      const SizedBox(width: AppSpacing.md),
                    if (business.website != null)
                      Expanded(
                        child: _ActionButton(
                          icon: Icons.language,
                          label: 'Website',
                          onTap: () => _launchUrl(business.website!),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: AppSpacing.xxl),

                // Location
                if (business.address != null || business.city != null) ...[
                  Text(
                    'Location',
                    style: AppTypography.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: AppRadius.cardRadius,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.accent.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.location_on,
                            color: AppColors.accent,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.lg),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (business.address != null)
                                Text(
                                  business.address!,
                                  style: AppTypography.bodyMedium,
                                ),
                              if (business.city != null) ...[
                                if (business.address != null)
                                  const SizedBox(height: AppSpacing.xs),
                                Text(
                                  [
                                    business.city,
                                    if (business.district != null)
                                      business.district,
                                  ].whereType<String>().join(', '),
                                  style: AppTypography.bodySmallSecondary,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                ],

                // Business hours
                if (business.businessHours != null &&
                    business.businessHours!.isNotEmpty) ...[
                  Text(
                    'Business Hours',
                    style: AppTypography.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: AppRadius.cardRadius,
                    ),
                    child: Column(
                      children: business.businessHours!.map((hours) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.xs,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _capitalizeDay(hours.day),
                                style: AppTypography.bodyMedium,
                              ),
                              Text(
                                hours.isClosed
                                    ? 'Closed'
                                    : '${hours.open ?? '-'} - ${hours.close ?? '-'}',
                                style: AppTypography.bodyMedium.copyWith(
                                  color: hours.isClosed
                                      ? AppColors.secondaryText
                                      : AppColors.primaryText,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                ],

                // Services
                if (business.services.isNotEmpty) ...[
                  Text(
                    'Services',
                    style: AppTypography.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: business.services.map((service) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: AppRadius.pillRadius,
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Text(
                          service,
                          style: AppTypography.bodySmall,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                ],

                // Social links
                if (business.socialLinks != null &&
                    (business.socialLinks!.facebook != null ||
                        business.socialLinks!.twitter != null ||
                        business.socialLinks!.instagram != null ||
                        business.socialLinks!.linkedin != null)) ...[
                  Text(
                    'Social Media',
                    style: AppTypography.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      if (business.socialLinks!.facebook != null)
                        _SocialButton(
                          icon: Icons.facebook,
                          onTap: () =>
                              _launchUrl(business.socialLinks!.facebook!),
                        ),
                      if (business.socialLinks!.twitter != null)
                        _SocialButton(
                          icon: Icons.close, // X icon placeholder
                          onTap: () =>
                              _launchUrl(business.socialLinks!.twitter!),
                        ),
                      if (business.socialLinks!.instagram != null)
                        _SocialButton(
                          icon: Icons.camera_alt,
                          onTap: () =>
                              _launchUrl(business.socialLinks!.instagram!),
                        ),
                      if (business.socialLinks!.linkedin != null)
                        _SocialButton(
                          icon: Icons.business,
                          onTap: () =>
                              _launchUrl(business.socialLinks!.linkedin!),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                ],

                const SizedBox(height: AppSpacing.xxxl),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _capitalizeDay(String day) {
    if (day.isEmpty) return day;
    return day[0].toUpperCase() + day.substring(1);
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: AppColors.accent.withValues(alpha: 0.1),
          borderRadius: AppRadius.cardRadius,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppColors.accent,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              label,
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.accent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.md),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.background,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border),
          ),
          child: Icon(
            icon,
            color: AppColors.primaryText,
          ),
        ),
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
    return Center(
      child: Padding(
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
      ),
    );
  }
}
