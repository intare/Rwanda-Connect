import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/theme.dart';
import '../../../../domain/entities/business.dart';
import '../providers/directory_provider.dart';
import '../widgets/business_card.dart';
import '../widgets/business_shimmer.dart';
import '../widgets/category_filter_chips.dart';

/// Screen displaying the business directory.
class DirectoryScreen extends ConsumerStatefulWidget {
  const DirectoryScreen({super.key});

  @override
  ConsumerState<DirectoryScreen> createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends ConsumerState<DirectoryScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(directoryProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(directoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Directory'),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(directoryProvider.notifier).refresh(),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Search bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search businesses...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: state.searchQuery != null &&
                            state.searchQuery!.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              ref.read(directoryProvider.notifier).search(null);
                            },
                          )
                        : null,
                  ),
                  onSubmitted: (value) {
                    ref.read(directoryProvider.notifier).search(value);
                  },
                ),
              ),
            ),

            // Category filter chips
            SliverToBoxAdapter(
              child: CategoryFilterChips(
                selectedCategory: state.selectedCategory,
                onCategorySelected: (category) {
                  ref.read(directoryProvider.notifier).filterByCategory(category);
                },
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.lg),
            ),

            // Featured section (only show if not filtering)
            if (!state.hasActiveFilters && state.featuredBusinesses.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: AppSpacing.horizontalLg,
                  child: Text(
                    'Featured',
                    style: AppTypography.titleMedium,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.md),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 180,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: AppSpacing.horizontalLg,
                    itemCount: state.featuredBusinesses.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(width: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final business = state.featuredBusinesses[index];
                      return SizedBox(
                        width: 280,
                        child: _FeaturedBusinessCard(
                          business: business,
                          onTap: () => _navigateToDetail(business.id),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.xxl),
              ),
            ],

            // All businesses header
            SliverToBoxAdapter(
              child: Padding(
                padding: AppSpacing.horizontalLg,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      state.hasActiveFilters ? 'Results' : 'All Businesses',
                      style: AppTypography.titleMedium,
                    ),
                    if (state.hasActiveFilters)
                      TextButton(
                        onPressed: () {
                          _searchController.clear();
                          ref.read(directoryProvider.notifier).clearFilters();
                        },
                        child: const Text('Clear filters'),
                      ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.md),
            ),

            // Content
            if (state.isLoading && state.businesses.isEmpty)
              const SliverToBoxAdapter(
                child: BusinessShimmerList(),
              )
            else if (state.error != null && state.businesses.isEmpty)
              SliverToBoxAdapter(
                child: _ErrorState(
                  message: state.error!,
                  onRetry: () =>
                      ref.read(directoryProvider.notifier).loadBusinesses(),
                ),
              )
            else if (state.businesses.isEmpty)
              const SliverToBoxAdapter(
                child: _EmptyState(),
              )
            else
              SliverPadding(
                padding: AppSpacing.horizontalLg,
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == state.businesses.length) {
                        return const Padding(
                          padding: EdgeInsets.all(AppSpacing.lg),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      final business = state.businesses[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: BusinessCard(
                          business: business,
                          onTap: () => _navigateToDetail(business.id),
                        ),
                      );
                    },
                    childCount:
                        state.businesses.length + (state.hasMore ? 1 : 0),
                  ),
                ),
              ),

            // Bottom padding
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.xxxl),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetail(String businessId) {
    context.push(
      AppRoutes.businessDetail.replaceFirst(':id', businessId),
    );
  }
}

class _FeaturedBusinessCard extends StatelessWidget {
  const _FeaturedBusinessCard({
    required this.business,
    required this.onTap,
  });

  final Business business;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.gradientStart,
              AppColors.gradientEnd,
            ],
          ),
          borderRadius: AppRadius.cardRadius,
        ),
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Logo
                Container(
                  width: 48,
                  height: 48,
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
                            size: 24,
                          ),
                        )
                      : Icon(
                          Icons.store,
                          color: AppColors.white,
                          size: 24,
                        ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        business.name,
                        style: AppTypography.titleMedium.copyWith(
                          color: AppColors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.2),
                          borderRadius: AppRadius.pillRadius,
                        ),
                        child: Text(
                          business.category.label,
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.star,
                  color: AppColors.warning,
                  size: 20,
                ),
              ],
            ),
            const Spacer(),
            if (business.description.isNotEmpty)
              Text(
                business.description,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.white.withValues(alpha: 0.8),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            const SizedBox(height: AppSpacing.sm),
            if (business.city != null)
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 14,
                    color: AppColors.white.withValues(alpha: 0.7),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    business.city!,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
          ],
        ),
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
            const SizedBox(height: AppSpacing.xxxl),
            const Icon(
              Icons.store_outlined,
              size: 64,
              color: AppColors.secondaryText,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'No businesses found',
              style: AppTypography.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Try adjusting your search or filters',
              style: AppTypography.bodyMediumSecondary,
              textAlign: TextAlign.center,
            ),
          ],
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
            const SizedBox(height: AppSpacing.xxxl),
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
