import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/theme.dart';
import '../../../../domain/entities/news.dart';

/// Screen displaying full news article content.
class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({
    required this.news,
    super.key,
  });

  final News news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar with image
          SliverAppBar(
            expandedHeight: news.imageUrl != null ? 250 : 0,
            pinned: true,
            flexibleSpace: news.imageUrl != null
                ? FlexibleSpaceBar(
                    background: Image.network(
                      news.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppColors.surface,
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 64,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ),
                  )
                : null,
            actions: [
              IconButton(
                icon: const Icon(Icons.open_in_new),
                tooltip: 'Open in browser',
                onPressed: () => _openInBrowser(context),
              ),
              IconButton(
                icon: const Icon(Icons.share),
                tooltip: 'Share',
                onPressed: () {
                  // TODO: Implement share
                },
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: AppSpacing.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.lg),

                  // Category and source
                  Row(
                    children: [
                      _CategoryChip(category: news.category),
                      const Spacer(),
                      Text(
                        news.source,
                        style: AppTypography.bodySmallSecondary,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Title
                  Text(
                    news.title,
                    style: AppTypography.headlineMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Publish date
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: AppColors.secondaryText,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        _formatDate(news.publishDate),
                        style: AppTypography.bodySmallSecondary,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // Summary
                  Container(
                    padding: AppSpacing.paddingLg,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: AppRadius.cardRadius,
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(
                      news.summary,
                      style: AppTypography.bodyMedium.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // Content
                  if (news.content != null) ...[
                    _RichTextContent(content: news.content),
                  ] else ...[
                    Text(
                      'Full article content is not available.',
                      style: AppTypography.bodyMediumSecondary,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    OutlinedButton.icon(
                      onPressed: () => _openInBrowser(context),
                      icon: const Icon(Icons.open_in_new),
                      label: const Text('Read full article'),
                    ),
                  ],

                  const SizedBox(height: AppSpacing.xxxl),

                  // Source link
                  Center(
                    child: TextButton.icon(
                      onPressed: () => _openInBrowser(context),
                      icon: const Icon(Icons.link),
                      label: const Text('View original source'),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xxxl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  Future<void> _openInBrowser(BuildContext context) async {
    final uri = Uri.parse(news.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open article'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.category});

  final String category;

  Color _getCategoryColor() {
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

  @override
  Widget build(BuildContext context) {
    final color = _getCategoryColor();
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: AppRadius.pillRadius,
      ),
      child: Text(
        category,
        style: AppTypography.labelSmall.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// Widget to render Lexical rich text content.
class _RichTextContent extends StatelessWidget {
  const _RichTextContent({required this.content});

  final dynamic content;

  @override
  Widget build(BuildContext context) {
    // Extract text from Lexical JSON format
    final textContent = _extractTextFromLexical(content);

    if (textContent.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: textContent.map((paragraph) {
        if (paragraph.startsWith('# ')) {
          // Heading
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.lg),
            child: Text(
              paragraph.substring(2),
              style: AppTypography.titleLarge,
            ),
          );
        } else if (paragraph.startsWith('## ')) {
          // Subheading
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Text(
              paragraph.substring(3),
              style: AppTypography.titleMedium,
            ),
          );
        } else {
          // Regular paragraph
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Text(
              paragraph,
              style: AppTypography.bodyMedium.copyWith(
                height: 1.7,
              ),
            ),
          );
        }
      }).toList(),
    );
  }

  /// Extract plain text from Lexical JSON format.
  List<String> _extractTextFromLexical(dynamic content) {
    final paragraphs = <String>[];

    if (content == null) return paragraphs;

    try {
      if (content is Map<String, dynamic>) {
        final root = content['root'];
        if (root is Map<String, dynamic>) {
          final children = root['children'] as List<dynamic>?;
          if (children != null) {
            for (final child in children) {
              final text = _extractTextFromNode(child);
              if (text.isNotEmpty) {
                paragraphs.add(text);
              }
            }
          }
        }
      }
    } catch (e) {
      // If parsing fails, try to convert to string
      paragraphs.add(content.toString());
    }

    return paragraphs;
  }

  /// Recursively extract text from a Lexical node.
  String _extractTextFromNode(dynamic node) {
    if (node == null) return '';

    if (node is String) return node;

    if (node is Map<String, dynamic>) {
      final type = node['type'] as String?;
      final text = node['text'] as String?;

      if (text != null) return text;

      // Handle heading nodes
      if (type == 'heading') {
        final tag = node['tag'] as String?;
        final childText = _extractChildrenText(node['children']);
        if (tag == 'h1') return '# $childText';
        if (tag == 'h2') return '## $childText';
        return childText;
      }

      // Handle paragraph and other nodes
      return _extractChildrenText(node['children']);
    }

    return '';
  }

  /// Extract text from children array.
  String _extractChildrenText(dynamic children) {
    if (children == null) return '';

    if (children is List) {
      return children.map(_extractTextFromNode).join('');
    }

    return '';
  }
}
