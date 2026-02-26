import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/theme.dart';
import '../../auth/providers/auth_provider.dart';
import '../../notifications/providers/notification_provider.dart';
import '../../notifications/screens/notifications_screen.dart';
import '../providers/news_provider.dart';
import '../widgets/featured_news_carousel.dart';
import '../widgets/news_card.dart';
import '../widgets/news_shimmer.dart';

/// Home screen showing news feed and featured opportunities.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final newsState = ref.watch(newsFeedProvider);
    final categories = ref.watch(newsCategoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                AppAssets.logo,
                height: 32,
                width: 32,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            const Text('Rwanda Connect'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.grid_view_rounded),
            tooltip: 'All Services',
            onPressed: () => context.push(AppRoutes.dashboard),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push(AppRoutes.newsSearch),
          ),
          _NotificationButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const NotificationsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.wait([
            ref.read(newsFeedProvider.notifier).refresh(),
            ref.read(featuredNewsProvider.notifier).refresh(),
          ]);
        },
        child: CustomScrollView(
          slivers: [
            // Welcome header
            SliverToBoxAdapter(
              child: Padding(
                padding: AppSpacing.screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Welcome${user?.name != null ? ', ${user!.name.split(' ').first}' : ''}!',
                      style: AppTypography.headlineMedium,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Stay updated with the latest news',
                      style: AppTypography.bodyMediumSecondary,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withValues(alpha: 0.1),
                        borderRadius: AppRadius.cardRadius,
                        border: Border.all(
                          color: AppColors.warning.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        'Rwanda Connect is an independent private platform and does not represent any government entity. Verify official information directly from source websites.',
                        style: AppTypography.bodySmall.copyWith(height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Featured news carousel
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: AppSpacing.xl),
                child: FeaturedNewsCarousel(),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.xl),
            ),

            // Category filter chips
            SliverToBoxAdapter(
              child: SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: AppSpacing.horizontalLg,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = category == 'All'
                        ? newsState.selectedCategory == null
                        : newsState.selectedCategory == category;

                    return FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (_) {
                        ref.read(newsFeedProvider.notifier).filterByCategory(
                              category == 'All' ? null : category,
                            );
                      },
                    );
                  },
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.lg),
            ),

            // Section header
            SliverToBoxAdapter(
              child: Padding(
                padding: AppSpacing.screenPadding,
                child: Text(
                  'Latest News',
                  style: AppTypography.titleLarge,
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.md),
            ),

            // News content
            if (newsState.isLoading && newsState.news.isEmpty)
              // Loading state
              const SliverToBoxAdapter(
                child: NewsShimmerList(),
              )
            else if (newsState.error != null && newsState.news.isEmpty)
              // Error state
              SliverToBoxAdapter(
                child: _ErrorState(
                  message: newsState.error!,
                  onRetry: () =>
                      ref.read(newsFeedProvider.notifier).loadNews(),
                ),
              )
            else if (newsState.news.isEmpty)
              // Empty state
              const SliverToBoxAdapter(
                child: _EmptyState(),
              )
            else
              // News list
              SliverPadding(
                padding: AppSpacing.horizontalLg,
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == newsState.news.length) {
                        // Load more indicator
                        if (newsState.hasMore) {
                          // Trigger load more when reaching the end
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ref.read(newsFeedProvider.notifier).loadMore();
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

                      final news = newsState.news[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: NewsCard(
                          news: news,
                          onTap: () => context.push(
                            AppRoutes.newsDetail.replaceFirst(':id', news.id),
                            extra: news,
                          ),
                        ),
                      );
                    },
                    childCount:
                        newsState.news.length + (newsState.hasMore ? 1 : 0),
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
            Icons.article_outlined,
            size: 64,
            color: AppColors.secondaryText,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'No news available',
            style: AppTypography.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Check back later for the latest updates',
            style: AppTypography.bodyMediumSecondary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _NotificationButton extends ConsumerWidget {
  const _NotificationButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadCount = ref.watch(unreadNotificationCountProvider);

    return IconButton(
      icon: Badge(
        isLabelVisible: unreadCount > 0,
        label: Text(
          unreadCount > 9 ? '9+' : unreadCount.toString(),
          style: const TextStyle(fontSize: 10),
        ),
        child: const Icon(Icons.notifications_outlined),
      ),
      onPressed: onPressed,
    );
  }
}
