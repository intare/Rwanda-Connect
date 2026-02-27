import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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

                  // Content
                  if (news.content != null) ...[
                    _HtmlContent(content: news.content),
                  ] else ...[
                    Text(
                      news.summary,
                      style: AppTypography.bodyMedium.copyWith(
                        height: 1.7,
                      ),
                    ),
                  ],

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

/// Widget to render HTML content with links, images, and tweets.
class _HtmlContent extends StatelessWidget {
  const _HtmlContent({required this.content});

  final dynamic content;

  @override
  Widget build(BuildContext context) {
    final htmlContent = _getHtmlString();

    if (htmlContent.isEmpty) {
      return const SizedBox.shrink();
    }

    return Html(
      data: htmlContent,
      style: {
        'body': Style(
          fontSize: FontSize(16),
          lineHeight: const LineHeight(1.7),
          color: AppColors.primaryText,
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
        ),
        'p': Style(
          margin: Margins.only(bottom: 16),
        ),
        'a': Style(
          color: AppColors.accent,
          textDecoration: TextDecoration.underline,
        ),
        'img': Style(
          margin: Margins.symmetric(vertical: 12),
        ),
        'h1': Style(
          fontSize: FontSize(24),
          fontWeight: FontWeight.bold,
          margin: Margins.only(bottom: 12, top: 16),
        ),
        'h2': Style(
          fontSize: FontSize(20),
          fontWeight: FontWeight.bold,
          margin: Margins.only(bottom: 10, top: 14),
        ),
        'h3': Style(
          fontSize: FontSize(18),
          fontWeight: FontWeight.bold,
          margin: Margins.only(bottom: 8, top: 12),
        ),
        'blockquote': Style(
          margin: Margins.symmetric(vertical: 12),
          padding: HtmlPaddings.only(left: 16),
          border: const Border(
            left: BorderSide(
              color: AppColors.accent,
              width: 4,
            ),
          ),
          fontStyle: FontStyle.italic,
          color: AppColors.secondaryText,
        ),
        'figure': Style(
          margin: Margins.symmetric(vertical: 12),
        ),
        'figcaption': Style(
          fontSize: FontSize(14),
          color: AppColors.secondaryText,
          fontStyle: FontStyle.italic,
          textAlign: TextAlign.center,
          margin: Margins.only(top: 8),
        ),
        // Twitter embed styling
        '.twitter-tweet': Style(
          backgroundColor: AppColors.surface,
          padding: HtmlPaddings.all(16),
          margin: Margins.symmetric(vertical: 12),
          border: Border.all(color: AppColors.border),
        ),
      },
      onLinkTap: (url, _, __) async {
        if (url != null) {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        }
      },
      extensions: [
        // Handle iframes (for embedded content)
        TagExtension(
          tagsToExtend: {'iframe'},
          builder: (extensionContext) {
            final src = extensionContext.attributes['src'] ?? '';
            if (src.contains('twitter.com') || src.contains('x.com')) {
              return _EmbedPlaceholder(
                icon: Icons.alternate_email,
                label: 'View Tweet',
                url: src,
              );
            }
            if (src.contains('youtube.com') || src.contains('youtu.be')) {
              return _EmbedPlaceholder(
                icon: Icons.play_circle_outline,
                label: 'Watch Video',
                url: src,
              );
            }
            return _EmbedPlaceholder(
              icon: Icons.open_in_new,
              label: 'View Embed',
              url: src,
            );
          },
        ),
      ],
    );
  }

  String _getHtmlString() {
    if (content == null) return '';

    if (content is String) {
      return content as String;
    }

    // Handle Lexical JSON format
    if (content is Map<String, dynamic>) {
      return _extractTextFromLexical(content);
    }

    return content.toString();
  }

  String _extractTextFromLexical(Map<String, dynamic> content) {
    final buffer = StringBuffer();

    try {
      final root = content['root'];
      if (root is Map<String, dynamic>) {
        final children = root['children'] as List<dynamic>?;
        if (children != null) {
          for (final child in children) {
            buffer.write(_nodeToHtml(child));
          }
        }
      }
    } catch (e) {
      return content.toString();
    }

    return buffer.toString();
  }

  String _nodeToHtml(dynamic node) {
    if (node == null) return '';
    if (node is String) return node;

    if (node is Map<String, dynamic>) {
      final type = node['type'] as String?;
      final text = node['text'] as String?;

      if (text != null) return text;

      final children = node['children'] as List<dynamic>?;
      final childHtml = children?.map(_nodeToHtml).join('') ?? '';

      switch (type) {
        case 'heading':
          final tag = node['tag'] as String? ?? 'h2';
          return '<$tag>$childHtml</$tag>';
        case 'paragraph':
          return '<p>$childHtml</p>';
        case 'link':
          final url = node['url'] as String? ?? '';
          return '<a href="$url">$childHtml</a>';
        default:
          return childHtml;
      }
    }

    return '';
  }
}

/// Placeholder widget for embedded content.
class _EmbedPlaceholder extends StatelessWidget {
  const _EmbedPlaceholder({
    required this.icon,
    required this.label,
    required this.url,
  });

  final IconData icon;
  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: OutlinedButton.icon(
        onPressed: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        icon: Icon(icon),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
    );
  }
}
