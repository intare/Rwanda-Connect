import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/theme.dart';
import '../../../../domain/entities/bookmark.dart';
import '../../opportunities/widgets/opportunity_card.dart';
import '../providers/bookmark_provider.dart';

/// Screen for displaying user's saved bookmarks.
class BookmarksScreen extends ConsumerWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarksState = ref.watch(bookmarksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Items'),
      ),
      body: Column(
        children: [
          // Type filter chips
          _TypeFilterChips(
            selectedType: bookmarksState.selectedType,
            onTypeSelected: (type) {
              ref.read(bookmarksProvider.notifier).filterByType(type);
            },
          ),
          // Content
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => ref.read(bookmarksProvider.notifier).refresh(),
              child: _buildContent(context, ref, bookmarksState),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    BookmarksState bookmarksState,
  ) {
    if (bookmarksState.isLoading && bookmarksState.bookmarks.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (bookmarksState.error != null && bookmarksState.bookmarks.isEmpty) {
      return _ErrorState(
        message: bookmarksState.error!,
        onRetry: () => ref.read(bookmarksProvider.notifier).loadBookmarks(),
      );
    }

    if (bookmarksState.bookmarks.isEmpty) {
      return const _EmptyState();
    }

    return _BookmarksList(
      bookmarks: bookmarksState.bookmarks,
      hasMore: bookmarksState.hasMore,
      isLoadingMore: bookmarksState.isLoadingMore,
      onLoadMore: () => ref.read(bookmarksProvider.notifier).loadMore(),
      onRemove: (bookmarkId) {
        ref.read(bookmarksProvider.notifier).removeFromList(bookmarkId);
      },
    );
  }
}

class _TypeFilterChips extends StatelessWidget {
  const _TypeFilterChips({
    required this.selectedType,
    required this.onTypeSelected,
  });

  final BookmarkType? selectedType;
  final ValueChanged<BookmarkType?> onTypeSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: SizedBox(
        height: 40,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: AppSpacing.horizontalLg,
          children: [
            _FilterChip(
              label: 'All',
              isSelected: selectedType == null,
              onTap: () => onTypeSelected(null),
            ),
            const SizedBox(width: AppSpacing.sm),
            ...BookmarkType.values.map((type) => Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: _FilterChip(
                label: type.label,
                isSelected: selectedType == type,
                onTap: () => onTypeSelected(type),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap(),
    );
  }
}

class _BookmarksList extends StatelessWidget {
  const _BookmarksList({
    required this.bookmarks,
    required this.hasMore,
    required this.isLoadingMore,
    required this.onLoadMore,
    required this.onRemove,
  });

  final List<Bookmark> bookmarks;
  final bool hasMore;
  final bool isLoadingMore;
  final VoidCallback onLoadMore;
  final ValueChanged<String> onRemove;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.extentAfter < 200 &&
            hasMore &&
            !isLoadingMore) {
          onLoadMore();
        }
        return false;
      },
      child: ListView.builder(
        padding: AppSpacing.screenPadding,
        itemCount: bookmarks.length + (hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == bookmarks.length) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final bookmark = bookmarks[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: _BookmarkItem(
              bookmark: bookmark,
              onRemove: () => onRemove(bookmark.id),
            ),
          );
        },
      ),
    );
  }
}

class _BookmarkItem extends ConsumerWidget {
  const _BookmarkItem({
    required this.bookmark,
    required this.onRemove,
  });

  final Bookmark bookmark;
  final VoidCallback onRemove;

  void _handleRemove(BuildContext context, WidgetRef ref) async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Bookmark'),
        content: const Text('Are you sure you want to remove this bookmark?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: const Text('Remove'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      // Toggle bookmark to remove it
      final notifier = ref.read(
        opportunityBookmarkStatusProvider(bookmark.itemId).notifier,
      );
      await notifier.toggle();
      onRemove();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // For now, only handle opportunity bookmarks
    if (bookmark.type == BookmarkType.opportunity && bookmark.opportunity != null) {
      return Dismissible(
        key: Key(bookmark.id),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: AppSpacing.lg),
          color: AppColors.danger,
          child: const Icon(
            Icons.delete_outline,
            color: AppColors.white,
          ),
        ),
        confirmDismiss: (_) async {
          return await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Remove Bookmark'),
              content: const Text('Are you sure you want to remove this bookmark?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: TextButton.styleFrom(foregroundColor: AppColors.danger),
                  child: const Text('Remove'),
                ),
              ],
            ),
          );
        },
        onDismissed: (_) {
          final notifier = ref.read(
            opportunityBookmarkStatusProvider(bookmark.itemId).notifier,
          );
          notifier.toggle();
          onRemove();
        },
        child: OpportunityCard(
          opportunity: bookmark.opportunity!,
          onTap: () => context.push(
            AppRoutes.opportunityDetail.replaceFirst(':id', bookmark.itemId),
          ),
        ),
      );
    }

    // Fallback for other bookmark types
    return Card(
      child: ListTile(
        leading: Icon(_getTypeIcon(bookmark.type)),
        title: Text('${bookmark.type.label} - ${bookmark.itemId}'),
        subtitle: Text('Saved on ${_formatDate(bookmark.createdAt)}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: AppColors.danger),
          onPressed: () => _handleRemove(context, ref),
        ),
      ),
    );
  }

  IconData _getTypeIcon(BookmarkType type) {
    switch (type) {
      case BookmarkType.opportunity:
        return Icons.work_outline;
      case BookmarkType.event:
        return Icons.event_outlined;
      case BookmarkType.news:
        return Icons.article_outlined;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
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
            const Icon(
              Icons.bookmark_outline,
              size: 64,
              color: AppColors.secondaryText,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'No saved items',
              style: AppTypography.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Items you bookmark will appear here',
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
