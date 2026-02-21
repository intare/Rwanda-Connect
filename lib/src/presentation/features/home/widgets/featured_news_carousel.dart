import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/theme.dart';
import '../../../../domain/entities/news.dart';
import '../providers/news_provider.dart';

/// Featured news carousel widget displaying top stories.
class FeaturedNewsCarousel extends ConsumerStatefulWidget {
  const FeaturedNewsCarousel({super.key});

  @override
  ConsumerState<FeaturedNewsCarousel> createState() =>
      _FeaturedNewsCarouselState();
}

class _FeaturedNewsCarouselState extends ConsumerState<FeaturedNewsCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      final featuredState = ref.read(featuredNewsProvider);
      if (featuredState.news.isEmpty) return;

      final nextPage = (_currentPage + 1) % featuredState.news.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  void _pauseAutoScroll() {
    _autoScrollTimer?.cancel();
  }

  void _resumeAutoScroll() {
    _autoScrollTimer?.cancel();
    _startAutoScroll();
  }

  @override
  Widget build(BuildContext context) {
    final featuredState = ref.watch(featuredNewsProvider);

    if (featuredState.isLoading && featuredState.news.isEmpty) {
      return const _FeaturedNewsShimmer();
    }

    if (featuredState.error != null && featuredState.news.isEmpty) {
      return const SizedBox.shrink();
    }

    if (featuredState.news.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppSpacing.horizontalLg,
          child: Row(
            children: [
              Text(
                'Featured',
                style: AppTypography.titleLarge,
              ),
              const SizedBox(width: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: AppRadius.pillRadius,
                ),
                child: Text(
                  'TOP STORIES',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 220,
          child: GestureDetector(
            onPanDown: (_) => _pauseAutoScroll(),
            onPanCancel: _resumeAutoScroll,
            onPanEnd: (_) => _resumeAutoScroll(),
            child: PageView.builder(
              controller: _pageController,
              itemCount: featuredState.news.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemBuilder: (context, index) {
                return _FeaturedNewsCard(
                  news: featuredState.news[index],
                  onTap: () {
                    final news = featuredState.news[index];
                    context.push(
                      AppRoutes.newsDetail.replaceFirst(':id', news.id),
                      extra: news,
                    );
                  },
                );
              },
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        // Page indicator
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              featuredState.news.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? AppColors.primary
                      : AppColors.border,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Individual featured news card.
class _FeaturedNewsCard extends StatelessWidget {
  const _FeaturedNewsCard({
    required this.news,
    required this.onTap,
  });

  final News news;
  final VoidCallback onTap;

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'economy':
        return AppColors.accent;
      case 'investment':
        return AppColors.success;
      case 'events':
        return const Color(0xFF9333EA);
      case 'business':
        return AppColors.warning;
      case 'policy':
        return const Color(0xFF0891B2);
      default:
        return AppColors.accent;
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM d, y').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final categoryColor = _getCategoryColor(news.category);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        shadowColor: AppColors.primary.withValues(alpha: 0.2),
        child: InkWell(
          onTap: onTap,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image or gradient
              if (news.imageUrl != null)
                Image.network(
                  news.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _buildGradientBackground(),
                )
              else
                _buildGradientBackground(),

              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.black.withValues(alpha: 0.8),
                    ],
                    stops: const [0.3, 1.0],
                  ),
                ),
              ),

              // Content
              Padding(
                padding: AppSpacing.paddingLg,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: categoryColor,
                        borderRadius: AppRadius.pillRadius,
                      ),
                      child: Text(
                        news.category,
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Title
                    Text(
                      news.title,
                      style: AppTypography.titleLarge.copyWith(
                        color: AppColors.white,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    // Source and date
                    Row(
                      children: [
                        Text(
                          news.source,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.white.withValues(alpha: 0.8),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                          ),
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.white.withValues(alpha: 0.6),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Text(
                          _formatDate(news.publishDate),
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradientBackground() {
    final categoryColor = _getCategoryColor(news.category);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            categoryColor.withValues(alpha: 0.8),
            categoryColor.withValues(alpha: 0.4),
            AppColors.primary.withValues(alpha: 0.9),
          ],
        ),
      ),
    );
  }
}

/// Shimmer loading state for featured news.
class _FeaturedNewsShimmer extends StatelessWidget {
  const _FeaturedNewsShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppSpacing.horizontalLg,
          child: Shimmer.fromColors(
            baseColor: AppColors.shimmerBase,
            highlightColor: AppColors.shimmerHighlight,
            child: Container(
              width: 150,
              height: 24,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: AppRadius.cardRadius,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 220,
          child: Shimmer.fromColors(
            baseColor: AppColors.shimmerBase,
            highlightColor: AppColors.shimmerHighlight,
            child: Padding(
              padding: AppSpacing.horizontalLg,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: AppRadius.cardRadius,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Center(
          child: Shimmer.fromColors(
            baseColor: AppColors.shimmerBase,
            highlightColor: AppColors.shimmerHighlight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                3,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
