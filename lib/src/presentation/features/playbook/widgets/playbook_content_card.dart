import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';
import '../../../../domain/entities/playbook.dart';

/// Card widget for displaying playbook content in a list.
class PlaybookContentCard extends StatelessWidget {
  const PlaybookContentCard({
    super.key,
    required this.content,
    required this.onTap,
  });

  final PlaybookContent content;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            SizedBox(
              width: 120,
              height: 100,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  content.coverImage != null
                      ? Image.network(
                          content.coverImage!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _buildPlaceholder(),
                        )
                      : _buildPlaceholder(),
                  // Type badge
                  Positioned(
                    top: AppSpacing.xs,
                    left: AppSpacing.xs,
                    child: _TypeBadge(type: content.type),
                  ),
                  // Premium badge
                  if (content.isPremium)
                    Positioned(
                      top: AppSpacing.xs,
                      right: AppSpacing.xs,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.warning,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.workspace_premium,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  // Duration overlay for videos
                  if (content.type == PlaybookContentType.video &&
                      content.durationMinutes != null)
                    Positioned(
                      bottom: AppSpacing.xs,
                      right: AppSpacing.xs,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          content.formattedDuration,
                          style: AppTypography.labelSmall.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      content.title,
                      style: AppTypography.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Category and difficulty
                    Row(
                      children: [
                        Text(
                          content.category.name,
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        _DifficultyChip(difficulty: content.difficulty),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Meta row
                    Row(
                      children: [
                        if (content.readingTimeMinutes != null) ...[
                          Icon(
                            Icons.schedule,
                            size: 12,
                            color: AppColors.secondaryText,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            content.formattedDuration,
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.secondaryText,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                        ],
                        Icon(
                          Icons.visibility_outlined,
                          size: 12,
                          color: AppColors.secondaryText,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          content.formattedViewCount,
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.surface,
      child: Center(
        child: Icon(
          _getTypeIcon(content.type),
          size: 32,
          color: AppColors.secondaryText,
        ),
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

/// Featured content card with larger image.
class FeaturedPlaybookCard extends StatelessWidget {
  const FeaturedPlaybookCard({
    super.key,
    required this.content,
    required this.onTap,
  });

  final PlaybookContent content;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  content.coverImage != null
                      ? Image.network(
                          content.coverImage!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _buildPlaceholder(),
                        )
                      : _buildPlaceholder(),
                  // Gradient overlay
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.7),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Type badge
                  Positioned(
                    top: AppSpacing.sm,
                    left: AppSpacing.sm,
                    child: _TypeBadge(type: content.type),
                  ),
                  // Premium badge
                  if (content.isPremium)
                    Positioned(
                      top: AppSpacing.sm,
                      right: AppSpacing.sm,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.warning,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.workspace_premium,
                              size: 14,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Premium',
                              style: AppTypography.labelSmall.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  // Title overlay
                  Positioned(
                    bottom: AppSpacing.md,
                    left: AppSpacing.md,
                    right: AppSpacing.md,
                    child: Text(
                      content.title,
                      style: AppTypography.titleMedium.copyWith(
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            // Meta
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  if (content.author != null) ...[
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: content.author!.avatar != null
                          ? NetworkImage(content.author!.avatar!)
                          : null,
                      child: content.author!.avatar == null
                          ? Text(
                              content.author!.name[0].toUpperCase(),
                              style: AppTypography.labelSmall,
                            )
                          : null,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        content.author!.name,
                        style: AppTypography.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ] else
                    const Spacer(),
                  _DifficultyChip(difficulty: content.difficulty),
                  const SizedBox(width: AppSpacing.sm),
                  if (content.formattedDuration.isNotEmpty)
                    Text(
                      content.formattedDuration,
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.surface,
      child: const Center(
        child: Icon(
          Icons.menu_book_outlined,
          size: 48,
          color: AppColors.secondaryText,
        ),
      ),
    );
  }
}

class _TypeBadge extends StatelessWidget {
  const _TypeBadge({required this.type});

  final PlaybookContentType type;

  IconData get _icon {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icon, size: 12, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            type.label,
            style: AppTypography.labelSmall.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _DifficultyChip extends StatelessWidget {
  const _DifficultyChip({required this.difficulty});

  final PlaybookDifficulty difficulty;

  Color get _color {
    switch (difficulty) {
      case PlaybookDifficulty.beginner:
        return AppColors.success;
      case PlaybookDifficulty.intermediate:
        return AppColors.warning;
      case PlaybookDifficulty.advanced:
        return AppColors.danger;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        difficulty.label,
        style: AppTypography.labelSmall.copyWith(
          color: _color,
        ),
      ),
    );
  }
}
