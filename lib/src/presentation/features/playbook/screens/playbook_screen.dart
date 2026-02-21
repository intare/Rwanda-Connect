import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../../../../domain/entities/playbook.dart';
import '../../../widgets/offline_indicator.dart';
import '../providers/playbook_provider.dart';
import '../widgets/playbook_category_card.dart';
import '../widgets/playbook_content_card.dart';
import '../widgets/playbook_shimmer.dart';

/// Main screen for the Career Playbook feature.
class PlaybookScreen extends ConsumerStatefulWidget {
  const PlaybookScreen({super.key});

  @override
  ConsumerState<PlaybookScreen> createState() => _PlaybookScreenState();
}

class _PlaybookScreenState extends ConsumerState<PlaybookScreen> {
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
      ref.read(playbookProvider.notifier).loadMore();
    }
  }

  void _onSearch() {
    ref.read(playbookProvider.notifier).search(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(playbookProvider);
    final categoriesAsync = ref.watch(playbookCategoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Career Playbook'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            tooltip: 'Liked Content',
            onPressed: () => context.push('/playbook/liked'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Offline indicator
          const OfflineBanner(),

          // Search bar
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search guides, videos, stories...',
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

          // Category chips
          categoriesAsync.when(
            data: (categories) => PlaybookCategoryChips(
              categories: categories,
              selectedCategory: state.selectedCategory,
              onCategorySelected: (category) {
                ref.read(playbookProvider.notifier).filterByCategory(category);
              },
            ),
            loading: () => const CategoryChipsShimmer(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          const SizedBox(height: AppSpacing.sm),

          // Content type filter
          _ContentTypeFilter(
            selectedType: state.selectedType,
            onTypeSelected: (type) {
              ref.read(playbookProvider.notifier).filterByType(type);
            },
          ),

          const SizedBox(height: AppSpacing.sm),

          // Content list
          Expanded(
            child: _buildContent(state),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(PlaybookState state) {
    if (state.isLoading && state.content.isEmpty) {
      return const PlaybookShimmerList();
    }

    if (state.error != null && state.content.isEmpty) {
      return _ErrorView(
        message: state.error!,
        onRetry: () => ref.read(playbookProvider.notifier).refresh(),
      );
    }

    if (state.content.isEmpty) {
      return _EmptyView(
        hasFilters: state.hasActiveFilters,
        onClearFilters: () => ref.read(playbookProvider.notifier).clearFilters(),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(playbookProvider.notifier).refresh(),
      child: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: state.content.length + (state.isLoadingMore ? 1 : 0),
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, index) {
          if (index >= state.content.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.md),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final content = state.content[index];
          return PlaybookContentCard(
            content: content,
            onTap: () => context.push('/playbook/${content.id}'),
          );
        },
      ),
    );
  }
}

class _ContentTypeFilter extends StatelessWidget {
  const _ContentTypeFilter({
    this.selectedType,
    required this.onTypeSelected,
  });

  final PlaybookContentType? selectedType;
  final ValueChanged<PlaybookContentType?> onTypeSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        children: [
          _TypeChip(
            label: 'All',
            icon: Icons.apps,
            isSelected: selectedType == null,
            onTap: () => onTypeSelected(null),
          ),
          ...PlaybookContentType.values.map(
            (type) => _TypeChip(
              label: type.label,
              icon: _getTypeIcon(type),
              isSelected: selectedType == type,
              onTap: () => onTypeSelected(
                selectedType == type ? null : type,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getTypeIcon(PlaybookContentType type) {
    switch (type) {
      case PlaybookContentType.guide:
        return Icons.menu_book_outlined;
      case PlaybookContentType.video:
        return Icons.play_circle_outline;
      case PlaybookContentType.story:
        return Icons.auto_stories_outlined;
      case PlaybookContentType.course:
        return Icons.school_outlined;
      case PlaybookContentType.report:
        return Icons.description_outlined;
    }
  }
}

class _TypeChip extends StatelessWidget {
  const _TypeChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.sm),
      child: ActionChip(
        avatar: Icon(
          icon,
          size: 16,
          color: isSelected ? Colors.white : AppColors.secondaryText,
        ),
        label: Text(label),
        backgroundColor: isSelected ? AppColors.primary : null,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : null,
        ),
        onPressed: onTap,
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
              Icons.menu_book_outlined,
              size: 64,
              color: AppColors.secondaryText,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              hasFilters
                  ? 'No content matches your filters'
                  : 'No content available',
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
