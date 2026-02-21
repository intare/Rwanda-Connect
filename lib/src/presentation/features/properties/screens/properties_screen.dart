import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../../../widgets/offline_indicator.dart';
import '../providers/property_provider.dart';
import '../widgets/property_card.dart';
import '../widgets/property_filter_bottom_sheet.dart';
import '../widgets/property_shimmer.dart';

/// Screen displaying the list of properties with filtering and search.
class PropertiesScreen extends ConsumerStatefulWidget {
  const PropertiesScreen({super.key});

  @override
  ConsumerState<PropertiesScreen> createState() => _PropertiesScreenState();
}

class _PropertiesScreenState extends ConsumerState<PropertiesScreen> {
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
      ref.read(propertiesProvider.notifier).loadMore();
    }
  }

  void _onSearch() {
    ref.read(propertiesProvider.notifier).search(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(propertiesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Properties'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'My Bids',
            onPressed: () => context.push('/properties/bids'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Offline indicator
          const OfflineBanner(),

          // Search and filter bar
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search properties...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                _onSearch();
                              },
                            )
                          : null,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                    ),
                    onSubmitted: (_) => _onSearch(),
                    onChanged: (value) {
                      setState(() {}); // Rebuild to show/hide clear button
                    },
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Badge(
                  isLabelVisible: state.hasActiveFilters,
                  child: IconButton.filledTonal(
                    icon: const Icon(Icons.tune),
                    tooltip: 'Filter',
                    onPressed: () => showPropertyFilterBottomSheet(context),
                  ),
                ),
              ],
            ),
          ),

          // Active filters chips
          if (state.hasActiveFilters)
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                children: [
                  if (state.selectedType != null)
                    _FilterChip(
                      label: state.selectedType!.label,
                      onRemove: () => ref
                          .read(propertiesProvider.notifier)
                          .filterByType(null),
                    ),
                  if (state.selectedLocation != null)
                    _FilterChip(
                      label: state.selectedLocation!,
                      onRemove: () => ref
                          .read(propertiesProvider.notifier)
                          .filterByLocation(null),
                    ),
                  if (state.minPrice != null || state.maxPrice != null)
                    _FilterChip(
                      label: _formatPriceRange(state.minPrice, state.maxPrice),
                      onRemove: () => ref
                          .read(propertiesProvider.notifier)
                          .filterByPrice(null, null),
                    ),
                ],
              ),
            ),

          // Properties list
          Expanded(
            child: _buildContent(state),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(PropertiesState state) {
    if (state.isLoading && state.properties.isEmpty) {
      return const PropertyShimmerGrid();
    }

    if (state.error != null && state.properties.isEmpty) {
      return _ErrorView(
        message: state.error!,
        onRetry: () => ref.read(propertiesProvider.notifier).refresh(),
      );
    }

    if (state.properties.isEmpty) {
      return _EmptyView(
        hasFilters: state.hasActiveFilters,
        onClearFilters: () =>
            ref.read(propertiesProvider.notifier).clearFilters(),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(propertiesProvider.notifier).refresh(),
      child: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: state.properties.length + (state.isLoadingMore ? 1 : 0),
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (context, index) {
          if (index >= state.properties.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.md),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final property = state.properties[index];
          return PropertyCard(
            property: property,
            onTap: () => context.push('/properties/${property.id}'),
          );
        },
      ),
    );
  }

  String _formatPriceRange(double? min, double? max) {
    if (min != null && max != null) {
      return 'RWF ${_formatNumber(min)} - ${_formatNumber(max)}';
    } else if (min != null) {
      return 'Min: RWF ${_formatNumber(min)}';
    } else if (max != null) {
      return 'Max: RWF ${_formatNumber(max)}';
    }
    return '';
  }

  String _formatNumber(double number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(0)}K';
    }
    return number.toStringAsFixed(0);
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.onRemove,
  });

  final String label;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.sm),
      child: Chip(
        label: Text(label),
        deleteIcon: const Icon(Icons.close, size: 18),
        onDeleted: onRemove,
        visualDensity: VisualDensity.compact,
      ),
    );
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

class _EmptyView extends StatelessWidget {
  const _EmptyView({
    required this.hasFilters,
    required this.onClearFilters,
  });

  final bool hasFilters;
  final VoidCallback onClearFilters;

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
              hasFilters
                  ? 'No properties match your filters'
                  : 'No properties available',
              style: AppTypography.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (hasFilters) ...[
              const SizedBox(height: AppSpacing.md),
              FilledButton.tonal(
                onPressed: onClearFilters,
                child: const Text('Clear Filters'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
