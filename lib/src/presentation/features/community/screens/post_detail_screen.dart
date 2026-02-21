import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../domain/entities/comment.dart';
import '../../../../domain/entities/post.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/post_provider.dart';

/// Screen showing a single post with its comments.
class PostDetailScreen extends ConsumerStatefulWidget {
  const PostDetailScreen({
    super.key,
    required this.postId,
    this.initialPost,
  });

  final String postId;
  final Post? initialPost;

  @override
  ConsumerState<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
  final _commentController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _commentController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _submitComment() async {
    final content = _commentController.text.trim();
    if (content.isEmpty) return;

    final success = await ref
        .read(commentsProvider(widget.postId).notifier)
        .addComment(content);

    if (success && mounted) {
      _commentController.clear();
      _focusNode.unfocus();
      // Update comment count in posts list
      ref.read(postsProvider.notifier).updateCommentCount(widget.postId, 1);
    }
  }

  void _showPostOptions(Post post) {
    final currentUser = ref.read(currentUserProvider);
    final isOwner = currentUser?.id == post.authorId;

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isOwner) ...[
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit Post'),
                onTap: () {
                  Navigator.pop(context);
                  _showEditDialog(post);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: AppColors.danger),
                title: const Text('Delete Post',
                    style: TextStyle(color: AppColors.danger)),
                onTap: () {
                  Navigator.pop(context);
                  _confirmDeletePost(post);
                },
              ),
            ],
            ListTile(
              leading: const Icon(Icons.flag_outlined),
              title: const Text('Report Post'),
              onTap: () {
                Navigator.pop(context);
                _showReportDialog();
              },
            ),
            ListTile(
              leading: const Icon(Icons.close),
              title: const Text('Cancel'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(Post post) {
    final editController = TextEditingController(text: post.content);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edit Post'),
        content: TextField(
          controller: editController,
          maxLines: 5,
          decoration: const InputDecoration(
            hintText: 'Edit your post...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final content = editController.text.trim();
              if (content.isEmpty) return;

              Navigator.pop(dialogContext);
              final success = await ref
                  .read(postsProvider.notifier)
                  .updatePost(post.id, content);

              if (mounted) {
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content: Text(
                      success ? 'Post updated' : 'Failed to update post',
                    ),
                    backgroundColor:
                        success ? AppColors.success : AppColors.danger,
                  ),
                );
                if (success) {
                  ref.invalidate(postDetailProvider(widget.postId));
                }
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _confirmDeletePost(Post post) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Post'),
        content: const Text(
          'Are you sure you want to delete this post? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              final success =
                  await ref.read(postsProvider.notifier).deletePost(post.id);

              if (mounted) {
                if (success) {
                  navigator.pop(); // Go back to community screen
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text('Post deleted'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                } else {
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text('Failed to delete post'),
                      backgroundColor: AppColors.danger,
                    ),
                  );
                }
              }
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showReportDialog() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Report feature coming soon'),
      ),
    );
  }

  void _confirmDeleteComment(Comment comment) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Comment'),
        content: const Text('Are you sure you want to delete this comment?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              final success = await ref
                  .read(commentsProvider(widget.postId).notifier)
                  .deleteComment(comment.id);

              if (mounted) {
                if (success) {
                  ref
                      .read(postsProvider.notifier)
                      .updateCommentCount(widget.postId, -1);
                }
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content: Text(
                      success ? 'Comment deleted' : 'Failed to delete comment',
                    ),
                    backgroundColor:
                        success ? AppColors.success : AppColors.danger,
                  ),
                );
              }
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final postAsync = ref.watch(postDetailProvider(widget.postId));
    final commentsState = ref.watch(commentsProvider(widget.postId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
        actions: [
          if (widget.initialPost != null || postAsync.value != null)
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => _showPostOptions(
                postAsync.value ?? widget.initialPost!,
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: postAsync.when(
              data: (post) {
                final displayPost = post ?? widget.initialPost;
                if (displayPost == null) {
                  return const _NotFoundState();
                }
                return _PostContent(
                  post: displayPost,
                  commentsState: commentsState,
                  onDeleteComment: _confirmDeleteComment,
                  onLoadMore: () => ref
                      .read(commentsProvider(widget.postId).notifier)
                      .loadMore(),
                );
              },
              loading: () {
                if (widget.initialPost != null) {
                  return _PostContent(
                    post: widget.initialPost!,
                    commentsState: commentsState,
                    onDeleteComment: _confirmDeleteComment,
                    onLoadMore: () => ref
                        .read(commentsProvider(widget.postId).notifier)
                        .loadMore(),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
              error: (error, _) => _ErrorState(
                message: error.toString(),
                onRetry: () =>
                    ref.refresh(postDetailProvider(widget.postId)),
              ),
            ),
          ),
          // Comment input
          _CommentInput(
            controller: _commentController,
            focusNode: _focusNode,
            isSubmitting: commentsState.isSubmitting,
            onSubmit: _submitComment,
          ),
        ],
      ),
    );
  }
}

class _PostContent extends StatelessWidget {
  const _PostContent({
    required this.post,
    required this.commentsState,
    required this.onDeleteComment,
    required this.onLoadMore,
  });

  final Post post;
  final CommentsState commentsState;
  final Function(Comment) onDeleteComment;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.extentAfter < 200 &&
            commentsState.hasMore &&
            !commentsState.isLoadingMore) {
          onLoadMore();
        }
        return false;
      },
      child: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          // Post content
          _PostCard(post: post),
          const SizedBox(height: AppSpacing.lg),

          // Comments header
          Row(
            children: [
              Text(
                'Comments',
                style: AppTypography.titleMedium,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                '(${post.commentCount})',
                style: AppTypography.bodyMediumSecondary,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Comments list
          if (commentsState.isLoading && commentsState.comments.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.xxl),
                child: CircularProgressIndicator(),
              ),
            )
          else if (commentsState.comments.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
              child: Center(
                child: Text(
                  'No comments yet. Be the first to comment!',
                  style: AppTypography.bodyMediumSecondary,
                ),
              ),
            )
          else
            ...commentsState.comments.map(
              (comment) => _CommentCard(
                comment: comment,
                onDelete: () => onDeleteComment(comment),
              ),
            ),

          // Load more indicator
          if (commentsState.isLoadingMore)
            const Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Center(child: CircularProgressIndicator()),
            ),

          const SizedBox(height: AppSpacing.xxxl),
        ],
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({required this.post});

  final Post post;

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
                CircleAvatar(
                  radius: 24,
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.authorName,
                        style: AppTypography.titleSmall,
                      ),
                      Text(
                        post.timeAgo,
                        style: AppTypography.bodySmallSecondary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Content
            Text(
              post.content,
              style: AppTypography.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.lg),

            // Stats row
            Row(
              children: [
                Icon(
                  Icons.favorite,
                  size: AppSizes.iconSm,
                  color: AppColors.danger.withValues(alpha: 0.7),
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  '${post.likeCount} likes',
                  style: AppTypography.bodySmallSecondary,
                ),
                const SizedBox(width: AppSpacing.lg),
                const Icon(
                  Icons.chat_bubble_outline,
                  size: AppSizes.iconSm,
                  color: AppColors.secondaryText,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  '${post.commentCount} comments',
                  style: AppTypography.bodySmallSecondary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CommentCard extends ConsumerWidget {
  const _CommentCard({
    required this.comment,
    required this.onDelete,
  });

  final Comment comment;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final isOwner = currentUser?.id == comment.authorId;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.accent.withValues(alpha: 0.1),
            backgroundImage: comment.authorAvatarUrl != null
                ? NetworkImage(comment.authorAvatarUrl!)
                : null,
            child: comment.authorAvatarUrl == null
                ? Text(
                    comment.authorName.isNotEmpty
                        ? comment.authorName[0].toUpperCase()
                        : '?',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.accent,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: AppRadius.cardRadius,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            comment.authorName,
                            style: AppTypography.labelMedium,
                          ),
                          const Spacer(),
                          Text(
                            comment.timeAgo,
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.secondaryText,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        comment.content,
                        style: AppTypography.bodyMedium,
                      ),
                    ],
                  ),
                ),
                if (isOwner)
                  Padding(
                    padding: const EdgeInsets.only(left: AppSpacing.sm),
                    child: TextButton(
                      onPressed: onDelete,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 32),
                        foregroundColor: AppColors.danger,
                      ),
                      child: const Text('Delete'),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentInput extends StatelessWidget {
  const _CommentInput({
    required this.controller,
    required this.focusNode,
    required this.isSubmitting,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isSubmitting;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.border),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                decoration: InputDecoration(
                  hintText: 'Write a comment...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.sm,
                  ),
                  isDense: true,
                ),
                maxLines: 3,
                minLines: 1,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            IconButton(
              onPressed: isSubmitting ? null : onSubmit,
              icon: isSubmitting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send),
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}

class _NotFoundState extends StatelessWidget {
  const _NotFoundState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.screenPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.article_outlined,
            size: 64,
            color: AppColors.secondaryText,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Post Not Found',
            style: AppTypography.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'This post may have been deleted.',
            style: AppTypography.bodyMediumSecondary,
            textAlign: TextAlign.center,
          ),
        ],
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
