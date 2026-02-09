import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';
import '../../../../domain/entities/post.dart';

/// Card widget displaying a community post.
class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
    this.onLike,
    this.onComment,
    this.onShare,
  });

  final Post post;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onShare;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Author row
            Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.accent.withValues(alpha: 0.1),
                  backgroundImage: post.authorAvatarUrl != null
                      ? NetworkImage(post.authorAvatarUrl!)
                      : null,
                  child: post.authorAvatarUrl == null
                      ? Text(
                          post.authorName.isNotEmpty
                              ? post.authorName[0].toUpperCase()
                              : '?',
                          style: AppTypography.titleMedium.copyWith(
                            color: AppColors.accent,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: AppSpacing.md),
                // Author info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.authorName,
                        style: AppTypography.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        post.timeAgo,
                        style: AppTypography.bodySmallSecondary,
                      ),
                    ],
                  ),
                ),
                // More options
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  iconSize: AppSizes.iconMd,
                  color: AppColors.secondaryText,
                  onPressed: () {
                    // TODO: Show more options
                  },
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            // Content
            Text(
              post.content,
              style: AppTypography.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.lg),

            // Divider
            const Divider(height: 1),
            const SizedBox(height: AppSpacing.sm),

            // Actions row
            Row(
              children: [
                // Like button
                _ActionButton(
                  icon: post.isLiked ? Icons.favorite : Icons.favorite_border,
                  label: post.likeCount > 0 ? '${post.likeCount}' : 'Like',
                  isActive: post.isLiked,
                  activeColor: AppColors.danger,
                  onTap: onLike,
                ),
                const SizedBox(width: AppSpacing.lg),
                // Comment button
                _ActionButton(
                  icon: Icons.chat_bubble_outline,
                  label: post.commentCount > 0
                      ? '${post.commentCount}'
                      : 'Comment',
                  onTap: onComment,
                ),
                const SizedBox(width: AppSpacing.lg),
                // Share button
                _ActionButton(
                  icon: Icons.share_outlined,
                  label: 'Share',
                  onTap: onShare,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    this.isActive = false,
    this.activeColor,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final Color? activeColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? (activeColor ?? AppColors.accent)
        : AppColors.secondaryText;

    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.cardRadius,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: AppSizes.iconMd,
              color: color,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: AppTypography.labelMedium.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
