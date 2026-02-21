import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/theme.dart';
import '../providers/news_search_provider.dart';
import '../widgets/news_card.dart';

/// Screen for searching news articles.
class NewsSearchScreen extends ConsumerStatefulWidget {
  const NewsSearchScreen({super.key});

  @override
  ConsumerState<NewsSearchScreen> createState() => _NewsSearchScreenState();
}

class _NewsSearchScreenState extends ConsumerState<NewsSearchScreen> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Auto-focus the search field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    ref.read(newsSearchProvider.notifier).search(query);
  }

  void _clearSearch() {
    _searchController.clear();
    ref.read(newsSearchProvider.notifier).clear();
    _focusNode.requestFocus();
  }

  void _addToRecentSearches(String query) {
    if (query.isEmpty) return;

    final recentSearches = ref.read(recentSearchesProvider);
    final updated = [
      query,
      ...recentSearches.where((s) => s != query),
    ].take(10).toList();

    ref.read(recentSearchesProvider.notifier).state = updated;
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(newsSearchProvider);
    final recentSearches = ref.watch(recentSearchesProvider);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: TextField(
          controller: _searchController,
          focusNode: _focusNode,
          onChanged: _onSearchChanged,
          onSubmitted: _addToRecentSearches,
          decoration: InputDecoration(
            hintText: 'Search news...',
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: _clearSearch,
                  )
                : null,
          ),
          style: AppTypography.bodyLarge,
          textInputAction: TextInputAction.search,
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
      body: _buildBody(searchState, recentSearches),
    );
  }

  Widget _buildBody(NewsSearchState searchState, List<String> recentSearches) {
    // Show recent searches if no query
    if (searchState.query.isEmpty) {
      return _buildRecentSearches(recentSearches);
    }

    // Loading state
    if (searchState.isLoading && searchState.results.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // Error state
    if (searchState.error != null && searchState.results.isEmpty) {
      return _buildErrorState(searchState.error!);
    }

    // Empty results
    if (searchState.hasSearched && searchState.results.isEmpty) {
      return _buildEmptyState(searchState.query);
    }

    // Results
    return _buildSearchResults(searchState);
  }

  Widget _buildRecentSearches(List<String> recentSearches) {
    if (recentSearches.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 64,
              color: AppColors.secondaryText,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Search for news',
              style: AppTypography.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Find articles by title, topic, or keyword',
              style: AppTypography.bodyMediumSecondary,
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: AppSpacing.screenPadding,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Searches',
              style: AppTypography.titleMedium,
            ),
            TextButton(
              onPressed: () {
                ref.read(recentSearchesProvider.notifier).state = [];
              },
              child: const Text('Clear'),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ...recentSearches.map((query) => ListTile(
              leading: const Icon(Icons.history),
              title: Text(query),
              contentPadding: EdgeInsets.zero,
              onTap: () {
                _searchController.text = query;
                _onSearchChanged(query);
              },
              trailing: IconButton(
                icon: const Icon(Icons.north_west, size: 18),
                onPressed: () {
                  _searchController.text = query;
                  _searchController.selection = TextSelection.fromPosition(
                    TextPosition(offset: query.length),
                  );
                },
              ),
            )),
      ],
    );
  }

  Widget _buildSearchResults(NewsSearchState searchState) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.extentAfter < 200 &&
            searchState.hasMore &&
            !searchState.isLoading) {
          ref.read(newsSearchProvider.notifier).loadMore();
        }
        return false;
      },
      child: ListView.builder(
        padding: AppSpacing.screenPadding,
        itemCount: searchState.results.length + (searchState.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == searchState.results.length) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          final news = searchState.results[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: NewsCard(
              news: news,
              onTap: () {
                _addToRecentSearches(searchState.query);
                context.push(
                  AppRoutes.newsDetail.replaceFirst(':id', news.id),
                  extra: news,
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(String query) {
    return Center(
      child: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: AppColors.secondaryText,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'No results found',
              style: AppTypography.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'No news matching "$query"',
              style: AppTypography.bodyMediumSecondary,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Try different keywords or check your spelling',
              style: AppTypography.bodySmallSecondary,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.danger,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Search failed',
              style: AppTypography.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              error,
              style: AppTypography.bodyMediumSecondary,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            ElevatedButton.icon(
              onPressed: () {
                ref.read(newsSearchProvider.notifier).search(_searchController.text);
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
