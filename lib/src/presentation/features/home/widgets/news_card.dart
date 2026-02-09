import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/theme.dart';
import '../../../../domain/entities/news.dart';

/// Card widget displaying a news article.
class NewsCard extends StatelessWidget {
  const NewsCard({
    required this.news,
    this.onTap,
    super.key,
  });

  final News news;
  final VoidCallback? onTap;

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'economy':
        return AppColors.accent;
      case 'investment':
        return AppColors.success;
      case 'events':
        return const Color(0xFF9333EA); // Purple
      case 'business':
        return AppColors.warning;
      case 'policy':
        return const Color(0xFF0891B2); // Cyan
      default:
        return AppColors.accent;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM d, y').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryColor = _getCategoryColor(news.category);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: AppSpacing.paddingLg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row with category and source
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: categoryColor.withValues(alpha: 0.1),
                      borderRadius: AppRadius.pillRadius,
                    ),
                    child: Text(
                      news.category,
                      style: AppTypography.labelSmall.copyWith(
                        color: categoryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    news.source,
                    style: AppTypography.bodySmallSecondary,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // Title
              Text(
                news.title,
                style: AppTypography.titleMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.sm),

              // Summary
              Text(
                news.summary,
                style: AppTypography.bodyMediumSecondary,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.md),

              // Footer with date and read more
              Row(
                children: [
                  Icon(
                    Icons.schedule,
                    size: AppSizes.iconSm,
                    color: AppColors.secondaryText,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    _formatDate(news.publishDate),
                    style: AppTypography.bodySmallSecondary,
                  ),
                  const Spacer(),
                  Text(
                    'Read more',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.accent,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Icon(
                    Icons.arrow_forward,
                    size: AppSizes.iconSm,
                    color: AppColors.accent,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
