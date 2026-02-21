import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../data/repositories/property_repository_impl.dart';
import '../../../../domain/entities/bid.dart';
import '../../../../domain/entities/property.dart';
import '../../../../domain/repositories/property_repository.dart';
import '../../../widgets/offline_indicator.dart';
import '../providers/property_provider.dart';
import '../widgets/bid_form.dart';

/// Screen displaying detailed property information.
class PropertyDetailScreen extends ConsumerStatefulWidget {
  const PropertyDetailScreen({
    super.key,
    required this.propertyId,
  });

  final String propertyId;

  @override
  ConsumerState<PropertyDetailScreen> createState() =>
      _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends ConsumerState<PropertyDetailScreen> {
  int _currentImageIndex = 0;
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final propertyAsync = ref.watch(propertyDetailProvider(widget.propertyId));

    return Scaffold(
      body: propertyAsync.when(
        data: (property) {
          if (property == null) {
            return const _NotFoundView();
          }
          return _PropertyContent(
            property: property,
            currentImageIndex: _currentImageIndex,
            pageController: _pageController,
            onImageChanged: (index) {
              setState(() => _currentImageIndex = index);
            },
          );
        },
        loading: () => const _LoadingView(),
        error: (error, _) => _ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(propertyDetailProvider(widget.propertyId)),
        ),
      ),
    );
  }
}

class _PropertyContent extends ConsumerWidget {
  const _PropertyContent({
    required this.property,
    required this.currentImageIndex,
    required this.pageController,
    required this.onImageChanged,
  });

  final Property property;
  final int currentImageIndex;
  final PageController pageController;
  final ValueChanged<int> onImageChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = property.images.isNotEmpty
        ? property.images
        : (property.primaryImage != null ? [property.primaryImage!] : <String>[]);

    return CustomScrollView(
      slivers: [
        // App bar with images
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                if (images.isNotEmpty)
                  PageView.builder(
                    controller: pageController,
                    itemCount: images.length,
                    onPageChanged: onImageChanged,
                    itemBuilder: (context, index) {
                      return Image.network(
                        images[index],
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildPlaceholder(),
                      );
                    },
                  )
                else
                  _buildPlaceholder(),
                // Image indicators
                if (images.length > 1)
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        images.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: currentImageIndex == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: currentImageIndex == index
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                // Status badge
                Positioned(
                  top: MediaQuery.of(context).padding.top + 56,
                  left: AppSpacing.md,
                  child: _StatusBadge(status: property.status),
                ),
              ],
            ),
          ),
        ),

        // Offline indicator
        const SliverToBoxAdapter(
          child: OfflineBanner(),
        ),

        // Content
        SliverPadding(
          padding: const EdgeInsets.all(AppSpacing.md),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Price and type
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          property.formattedPrice,
                          style: AppTypography.headlineMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            property.type.label,
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // Title
              Text(
                property.title,
                style: AppTypography.titleLarge,
              ),
              const SizedBox(height: AppSpacing.sm),

              // Location
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 18,
                    color: AppColors.secondaryText,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      property.location,
                      style: AppTypography.bodyMediumSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // Features
              _FeaturesSection(property: property),
              const SizedBox(height: AppSpacing.lg),

              // Description
              Text(
                'Description',
                style: AppTypography.titleMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                property.description,
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.lg),

              // Amenities
              if (property.amenities.isNotEmpty) ...[
                Text(
                  'Amenities',
                  style: AppTypography.titleMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: property.amenities
                      .map((amenity) => Chip(
                            label: Text(amenity),
                            visualDensity: VisualDensity.compact,
                          ))
                      .toList(),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],

              // Bids section
              if (property.status == PropertyStatus.available) ...[
                _BidsSection(propertyId: property.id),
                const SizedBox(height: AppSpacing.lg),
              ],

              // Bid form
              if (property.status == PropertyStatus.available)
                BidForm(
                  property: property,
                  onBidPlaced: () {
                    // Refresh the property to update bids
                  },
                ),

              const SizedBox(height: AppSpacing.xl),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.surface,
      child: const Center(
        child: Icon(
          Icons.home_outlined,
          size: 64,
          color: AppColors.secondaryText,
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final PropertyStatus status;

  Color get _color {
    switch (status) {
      case PropertyStatus.available:
        return AppColors.success;
      case PropertyStatus.pending:
        return AppColors.warning;
      case PropertyStatus.sold:
        return AppColors.danger;
      case PropertyStatus.rented:
        return AppColors.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status.label,
        style: AppTypography.labelSmall.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _FeaturesSection extends StatelessWidget {
  const _FeaturesSection({required this.property});

  final Property property;

  @override
  Widget build(BuildContext context) {
    final features = <_FeatureData>[];

    if (property.bedrooms != null) {
      features.add(_FeatureData(
        icon: Icons.bed_outlined,
        label: 'Bedrooms',
        value: '${property.bedrooms}',
      ));
    }

    if (property.bathrooms != null) {
      features.add(_FeatureData(
        icon: Icons.bathtub_outlined,
        label: 'Bathrooms',
        value: '${property.bathrooms}',
      ));
    }

    if (property.size != null) {
      features.add(_FeatureData(
        icon: Icons.square_foot,
        label: 'Size',
        value: property.formattedSize!,
      ));
    }

    if (property.yearBuilt != null) {
      features.add(_FeatureData(
        icon: Icons.calendar_today_outlined,
        label: 'Year Built',
        value: '${property.yearBuilt}',
      ));
    }

    if (features.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: features
            .map((f) => _FeatureItem(
                  icon: f.icon,
                  label: f.label,
                  value: f.value,
                ))
            .toList(),
      ),
    );
  }
}

class _FeatureData {
  const _FeatureData({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 24, color: AppColors.primary),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTypography.titleSmall,
        ),
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.secondaryText,
          ),
        ),
      ],
    );
  }
}

class _BidsSection extends ConsumerWidget {
  const _BidsSection({required this.propertyId});

  final String propertyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.watch(propertyRepositoryProvider).getPropertyBids(propertyId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final result = snapshot.data;
        if (result == null) return const SizedBox.shrink();

        return switch (result) {
          PropertySuccess<List<Bid>>(:final data) => data.isEmpty
              ? const SizedBox.shrink()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Current Bids',
                          style: AppTypography.titleMedium,
                        ),
                        Text(
                          '${data.length} bid${data.length == 1 ? '' : 's'}',
                          style: AppTypography.bodySmallSecondary,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    ...data.take(5).map((bid) => _BidItem(bid: bid)),
                  ],
                ),
          PropertyFailure() => const SizedBox.shrink(),
        };
      },
    );
  }
}

class _BidItem extends StatelessWidget {
  const _BidItem({required this.bid});

  final Bid bid;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_outline,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bid.formattedAmount,
                  style: AppTypography.titleSmall,
                ),
                Text(
                  bid.formattedDate,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ),
          _BidStatusChip(status: bid.status),
        ],
      ),
    );
  }
}

class _BidStatusChip extends StatelessWidget {
  const _BidStatusChip({required this.status});

  final BidStatus status;

  Color get _color {
    switch (status) {
      case BidStatus.pending:
        return AppColors.warning;
      case BidStatus.accepted:
        return AppColors.success;
      case BidStatus.rejected:
        return AppColors.danger;
      case BidStatus.withdrawn:
        return AppColors.secondaryText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status.label,
        style: AppTypography.labelSmall.copyWith(color: _color),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.secondaryText,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              message,
              style: AppTypography.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            FilledButton.tonal(
              onPressed: onRetry,
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotFoundView extends StatelessWidget {
  const _NotFoundView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.home_work_outlined,
              size: 64,
              color: AppColors.secondaryText,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Property not found',
              style: AppTypography.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'This property may have been removed or is no longer available.',
              style: AppTypography.bodyMediumSecondary,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            FilledButton.tonal(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
