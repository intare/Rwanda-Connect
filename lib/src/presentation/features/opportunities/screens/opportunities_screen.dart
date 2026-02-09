import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../../../../domain/entities/opportunity.dart';
import '../providers/opportunity_provider.dart';
import '../widgets/opportunity_card.dart';
import '../widgets/opportunity_shimmer.dart';
import '../widgets/filter_bottom_sheet.dart';

/// Opportunities screen showing job listings, investments, etc.
class OpportunitiesScreen extends ConsumerStatefulWidget {
  const OpportunitiesScreen({super.key});

  @override
  ConsumerState<OpportunitiesScreen> createState() =>
      _OpportunitiesScreenState();
}

class _OpportunitiesScreenState extends ConsumerState<OpportunitiesScreen> {
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        ref.read(opportunitiesProvider.notifier).search(null);
      }
    });
  }

  void _onSearch(String query) {
    ref.read(opportunitiesProvider.notifier).search(query);
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.modal)),
      ),
      builder: (context) => const FilterBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(opportunitiesProvider);
    final types = ref.watch(opportunityTypesProvider);

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search opportunities...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                style: AppTypography.bodyLarge,
                onSubmitted: _onSearch,
              )
            : const Text('Opportunities'),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: _toggleSearch,
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: _showFilterSheet,
              ),
              if (state.hasActiveFilters)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(opportunitiesProvider.notifier).refresh(),
        child: CustomScrollView(
          slivers: [
            // Type filter chips
            SliverToBoxAdapter(
              child: SizedBox(
                height: 48,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: AppSpacing.horizontalLg,
                  itemCount: types.length + 1, // +1 for "All" chip
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // "All" chip
                      return FilterChip(
                        label: const Text('All'),
                        selected: state.selectedType == null,
                        onSelected: (_) {
                          ref
                              .read(opportunitiesProvider.notifier)
                              .filterByType(null);
                        },
                      );
                    }

                    final type = types[index - 1];
                    return FilterChip(
                      label: Text(type.label),
                      selected: state.selectedType == type,
                      onSelected: (_) {
                        ref
                            .read(opportunitiesProvider.notifier)
                            .filterByType(type);
                      },
                    );
                  },
                ),
              ),
            ),

            // Active filters indicator
            if (state.hasActiveFilters)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.md,
                    AppSpacing.lg,
                    0,
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${state.activeFilterCount} filter${state.activeFilterCount > 1 ? 's' : ''} active',
                        style: AppTypography.bodySmallSecondary,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          ref
                              .read(opportunitiesProvider.notifier)
                              .clearFilters();
                        },
                        child: const Text('Clear all'),
                      ),
                    ],
                  ),
                ),
              ),

            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.md),
            ),

            // Content
            if (state.isLoading && state.opportunities.isEmpty)
              // Loading state
              const SliverToBoxAdapter(
                child: OpportunityShimmerList(),
              )
            else if (state.error != null && state.opportunities.isEmpty)
              // Error state
              SliverToBoxAdapter(
                child: _ErrorState(
                  message: state.error!,
                  onRetry: () =>
                      ref.read(opportunitiesProvider.notifier).loadOpportunities(),
                ),
              )
            else if (state.opportunities.isEmpty)
              // Empty state
              const SliverToBoxAdapter(
                child: _EmptyState(),
              )
            else
              // Opportunities list
              SliverPadding(
                padding: AppSpacing.horizontalLg,
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == state.opportunities.length) {
                        // Load more indicator
                        if (state.hasMore) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ref.read(opportunitiesProvider.notifier).loadMore();
                          });
                          return const Padding(
                            padding: EdgeInsets.all(AppSpacing.lg),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return null;
                      }

                      final opportunity = state.opportunities[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: OpportunityCard(
                          opportunity: opportunity,
                          onTap: () => _navigateToDetail(opportunity),
                        ),
                      );
                    },
                    childCount:
                        state.opportunities.length + (state.hasMore ? 1 : 0),
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

  void _navigateToDetail(Opportunity opportunity) {
    context.push('/opportunities/${opportunity.id}');
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
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.screenPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: AppSpacing.xxxl),
          const Icon(
            Icons.work_outline,
            size: 64,
            color: AppColors.secondaryText,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'No opportunities found',
            style: AppTypography.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Try adjusting your filters or check back later',
            style: AppTypography.bodyMediumSecondary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
