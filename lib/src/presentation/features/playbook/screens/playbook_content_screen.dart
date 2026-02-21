import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/theme/theme.dart';
import '../../../../data/repositories/playbook_repository_impl.dart';
import '../../../../domain/entities/playbook.dart';
import '../../../../domain/repositories/playbook_repository.dart';
import '../../../widgets/offline_indicator.dart';
import '../providers/playbook_provider.dart';

/// Screen displaying detailed playbook content.
class PlaybookContentScreen extends ConsumerStatefulWidget {
  const PlaybookContentScreen({
    super.key,
    required this.contentId,
  });

  final String contentId;

  @override
  ConsumerState<PlaybookContentScreen> createState() =>
      _PlaybookContentScreenState();
}

class _PlaybookContentScreenState extends ConsumerState<PlaybookContentScreen> {
  bool _isLiked = false;
  bool _isLikeLoading = false;

  @override
  void initState() {
    super.initState();
    _recordView();
    _checkLikeStatus();
  }

  void _recordView() {
    ref.read(playbookRepositoryProvider).recordView(widget.contentId);
  }

  Future<void> _checkLikeStatus() async {
    final result =
        await ref.read(playbookRepositoryProvider).isContentLiked(widget.contentId);
    if (result is PlaybookSuccess<bool> && mounted) {
      setState(() => _isLiked = result.data);
    }
  }

  Future<void> _toggleLike() async {
    if (_isLikeLoading) return;

    setState(() => _isLikeLoading = true);

    final repository = ref.read(playbookRepositoryProvider);
    final result = _isLiked
        ? await repository.unlikeContent(widget.contentId)
        : await repository.likeContent(widget.contentId);

    if (mounted) {
      setState(() {
        _isLikeLoading = false;
        if (result is PlaybookSuccess) {
          _isLiked = !_isLiked;
        }
      });

      if (result is PlaybookFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.message),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    }
  }

  void _share(PlaybookContent content) {
    Share.share(
      '${content.title}\n\nCheck out this career resource on Rwanda Connect!',
      subject: content.title,
    );
  }

  @override
  Widget build(BuildContext context) {
    final contentAsync = ref.watch(playbookContentProvider(widget.contentId));

    return Scaffold(
      body: contentAsync.when(
        data: (content) {
          if (content == null) {
            return const _NotFoundView();
          }
          return _ContentView(
            content: content,
            isLiked: _isLiked,
            isLikeLoading: _isLikeLoading,
            onLikeTap: _toggleLike,
            onShareTap: () => _share(content),
          );
        },
        loading: () => const _LoadingView(),
        error: (error, _) => _ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(playbookContentProvider(widget.contentId)),
        ),
      ),
    );
  }
}

class _ContentView extends StatelessWidget {
  const _ContentView({
    required this.content,
    required this.isLiked,
    required this.isLikeLoading,
    required this.onLikeTap,
    required this.onShareTap,
  });

  final PlaybookContent content;
  final bool isLiked;
  final bool isLikeLoading;
  final VoidCallback onLikeTap;
  final VoidCallback onShareTap;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // App bar with cover image
        SliverAppBar(
          expandedHeight: 250,
          pinned: true,
          actions: [
            IconButton(
              icon: isLikeLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? AppColors.danger : null,
                    ),
              onPressed: onLikeTap,
            ),
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: onShareTap,
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                if (content.coverImage != null)
                  Image.network(
                    content.coverImage!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _buildPlaceholder(),
                  )
                else
                  _buildPlaceholder(),
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
                // Type and premium badges
                Positioned(
                  top: MediaQuery.of(context).padding.top + 56,
                  left: AppSpacing.md,
                  child: Row(
                    children: [
                      _TypeBadge(type: content.type),
                      if (content.isPremium) ...[
                        const SizedBox(width: AppSpacing.sm),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.warning,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.workspace_premium,
                                size: 14,
                                color: Colors.white,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Premium',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Offline indicator
        const SliverToBoxAdapter(
          child: OfflineBanner(),
        ),

        // Content
        SliverPadding(
          padding: const EdgeInsets.all(AppSpacing.md),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Title
              Text(
                content.title,
                style: AppTypography.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.md),

              // Meta row
              Wrap(
                spacing: AppSpacing.md,
                runSpacing: AppSpacing.sm,
                children: [
                  _MetaChip(
                    icon: Icons.category_outlined,
                    label: content.category.name,
                  ),
                  _DifficultyChip(difficulty: content.difficulty),
                  if (content.formattedDuration.isNotEmpty)
                    _MetaChip(
                      icon: Icons.schedule,
                      label: content.formattedDuration,
                    ),
                  _MetaChip(
                    icon: Icons.visibility_outlined,
                    label: content.formattedViewCount,
                  ),
                  _MetaChip(
                    icon: Icons.favorite,
                    label: content.formattedLikeCount,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // Author info
              if (content.author != null) ...[
                _AuthorSection(author: content.author!),
                const SizedBox(height: AppSpacing.lg),
              ],

              // Summary
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.1),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Summary',
                      style: AppTypography.titleSmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      content.summary,
                      style: AppTypography.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Video player placeholder
              if (content.type == PlaybookContentType.video &&
                  content.videoUrl != null) ...[
                _VideoPlaceholder(videoUrl: content.videoUrl!),
                const SizedBox(height: AppSpacing.lg),
              ],

              // Content body
              Text(
                'Content',
                style: AppTypography.titleMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                content.content,
                style: AppTypography.bodyMedium.copyWith(height: 1.6),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Tags
              if (content.tags.isNotEmpty) ...[
                Text(
                  'Tags',
                  style: AppTypography.titleSmall,
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: content.tags
                      .map((tag) => Chip(
                            label: Text(tag),
                            visualDensity: VisualDensity.compact,
                          ))
                      .toList(),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],

              // Date info
              Text(
                'Published ${content.timeAgo}',
                style: AppTypography.bodySmallSecondary,
              ),

              const SizedBox(height: AppSpacing.xl),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.surface,
      child: const Center(
        child: Icon(
          Icons.menu_book_outlined,
          size: 64,
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
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icon, size: 14, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            type.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.secondaryText),
        const SizedBox(width: 4),
        Text(
          label,
          style: AppTypography.bodySmallSecondary,
        ),
      ],
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
        horizontal: 8,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        difficulty.label,
        style: AppTypography.labelSmall.copyWith(color: _color),
      ),
    );
  }
}

class _AuthorSection extends StatelessWidget {
  const _AuthorSection({required this.author});

  final PlaybookAuthor author;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage:
              author.avatar != null ? NetworkImage(author.avatar!) : null,
          child: author.avatar == null
              ? Text(
                  author.name[0].toUpperCase(),
                  style: AppTypography.titleMedium,
                )
              : null,
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                author.name,
                style: AppTypography.titleSmall,
              ),
              if (author.title != null || author.company != null)
                Text(
                  [author.title, author.company]
                      .where((e) => e != null)
                      .join(' at '),
                  style: AppTypography.bodySmallSecondary,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _VideoPlaceholder extends StatelessWidget {
  const _VideoPlaceholder({required this.videoUrl});

  final String videoUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.play_circle_outline,
                size: 64,
                color: AppColors.primary,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Video Player',
                style: AppTypography.bodyMediumSecondary,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Video playback coming soon',
                style: AppTypography.bodySmallSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
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

class _NotFoundView extends StatelessWidget {
  const _NotFoundView();

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
              'Content not found',
              style: AppTypography.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'This content may have been removed or is no longer available.',
              style: AppTypography.bodyMediumSecondary,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            FilledButton.tonal(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
