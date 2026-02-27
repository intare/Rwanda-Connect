import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

import '../models/news/news_dto.dart';
import 'news_service.dart';

/// RSS feed sources from The New Times.
class _RssFeed {
  const _RssFeed(this.url, this.feedCategory);
  final String url;
  final String feedCategory;
}

const _rssFeeds = [
  _RssFeed('https://www.newtimes.co.rw/rssFeed/14', 'News'),
  _RssFeed('https://www.newtimes.co.rw/rssFeed/17', 'Lifestyle'),
  _RssFeed('https://www.newtimes.co.rw/rssFeed/33', 'Entertainment'),
];

const _sourceName = 'The New Times';

/// Service for fetching news directly from RSS feeds.
class RssNewsService {
  RssNewsService(this._httpClient);

  final http.Client _httpClient;

  // Cache to avoid hitting RSS feeds on every request
  List<NewsDto>? _cachedNews;
  DateTime? _cacheTimestamp;
  static const _cacheDuration = Duration(minutes: 5);

  /// Get paginated list of news articles from RSS feeds.
  Future<NewsListResponse> getNews({
    int page = 1,
    int limit = 10,
    String? category,
    String? search,
  }) async {
    // Check cache
    final now = DateTime.now();
    if (_cachedNews == null ||
        _cacheTimestamp == null ||
        now.difference(_cacheTimestamp!) > _cacheDuration) {
      _cachedNews = await _fetchAllFeeds();
      _cacheTimestamp = now;
    }

    var articles = List<NewsDto>.from(_cachedNews!);

    // Filter by category
    if (category != null && category.isNotEmpty) {
      articles = articles.where((a) => a.category == category).toList();
    }

    // Filter by search
    if (search != null && search.isNotEmpty) {
      final searchLower = search.toLowerCase();
      articles = articles.where((a) {
        final titleMatch = a.title.toLowerCase().contains(searchLower);
        final summaryMatch = a.summary.toLowerCase().contains(searchLower);
        return titleMatch || summaryMatch;
      }).toList();
    }

    // Pagination
    final startIndex = (page - 1) * limit;
    final endIndex = startIndex + limit;
    final paginatedArticles = articles.length > startIndex
        ? articles.sublist(
            startIndex,
            endIndex > articles.length ? articles.length : endIndex,
          )
        : <NewsDto>[];

    return NewsListResponse(
      news: paginatedArticles,
      hasNext: endIndex < articles.length,
      total: articles.length,
      page: page,
      totalPages: (articles.length / limit).ceil(),
    );
  }

  /// Get featured news (top articles).
  Future<NewsListResponse> getFeaturedNews({int limit = 5}) async {
    return getNews(page: 1, limit: limit);
  }

  /// Fetch and combine all RSS feeds.
  Future<List<NewsDto>> _fetchAllFeeds() async {
    final results = await Future.wait(
      _rssFeeds.map((feed) => _fetchSingleFeed(feed.url, feed.feedCategory)),
    );

    // Combine and sort by publish date (newest first)
    final allArticles = results.expand((list) => list).toList();
    allArticles.sort((a, b) {
      final dateA = DateTime.tryParse(a.publishDate ?? '') ?? DateTime.now();
      final dateB = DateTime.tryParse(b.publishDate ?? '') ?? DateTime.now();
      return dateB.compareTo(dateA);
    });

    // Remove duplicates by URL
    final seen = <String>{};
    return allArticles.where((article) {
      if (seen.contains(article.url)) return false;
      seen.add(article.url);
      return true;
    }).toList();
  }

  /// Fetch a single RSS feed.
  Future<List<NewsDto>> _fetchSingleFeed(
    String feedUrl,
    String feedCategory,
  ) async {
    try {
      final response = await _httpClient.get(Uri.parse(feedUrl));
      if (response.statusCode != 200) {
        return [];
      }

      final document = XmlDocument.parse(response.body);
      final items = document.findAllElements('item');

      return items.map((item) {
        final title = _getElementText(item, 'title') ?? 'Untitled';
        final link = _getElementText(item, 'link') ?? '';
        final guid = _getElementText(item, 'guid') ?? '';
        final url = link.isNotEmpty ? link : guid;
        final description = _getElementText(item, 'description') ?? '';
        final contentEncoded = _getElementText(item, 'content:encoded') ?? '';
        final pubDateStr = _getElementText(item, 'pubDate');

        final rawContent = contentEncoded.isNotEmpty ? contentEncoded : description;
        final strippedContent = _stripHtml(rawContent);
        final summary = strippedContent.length > 500
            ? strippedContent.substring(0, 500)
            : strippedContent;

        DateTime? pubDate;
        if (pubDateStr != null) {
          pubDate = _parseRssDate(pubDateStr);
        }

        return NewsDto(
          id: 'rss-${url.hashCode}',
          title: title,
          source: _sourceName,
          category: _mapCategory(feedCategory, url),
          summary: summary,
          url: url,
          publishDate: pubDate?.toIso8601String(),
          image: _extractImageUrl(rawContent),
          isFeatured: false,
          content: rawContent, // Keep raw HTML for rendering
        );
      }).toList();
    } catch (e) {
      // Return empty list on error, don't crash the whole feed
      return [];
    }
  }

  /// Get text content of an XML element by tag name.
  String? _getElementText(XmlElement parent, String tagName) {
    try {
      final elements = parent.findElements(tagName);
      if (elements.isEmpty) {
        // Try with namespace prefix stripped
        final allElements = parent.children.whereType<XmlElement>();
        for (final element in allElements) {
          if (element.name.local == tagName.split(':').last) {
            return element.innerText;
          }
        }
        return null;
      }
      return elements.first.innerText;
    } catch (e) {
      return null;
    }
  }

  /// Parse RSS date format (RFC 822).
  DateTime? _parseRssDate(String dateStr) {
    try {
      // RSS uses RFC 822 format: "Tue, 25 Feb 2025 10:30:00 +0200"
      return DateTime.parse(dateStr);
    } catch (_) {
      try {
        // Try parsing common RSS date formats
        final months = {
          'Jan': 1, 'Feb': 2, 'Mar': 3, 'Apr': 4, 'May': 5, 'Jun': 6,
          'Jul': 7, 'Aug': 8, 'Sep': 9, 'Oct': 10, 'Nov': 11, 'Dec': 12,
        };

        // Format: "Tue, 25 Feb 2025 10:30:00 +0200"
        final parts = dateStr.split(' ');
        if (parts.length >= 5) {
          final day = int.parse(parts[1]);
          final month = months[parts[2]] ?? 1;
          final year = int.parse(parts[3]);
          final timeParts = parts[4].split(':');
          final hour = int.parse(timeParts[0]);
          final minute = int.parse(timeParts[1]);
          final second = timeParts.length > 2 ? int.parse(timeParts[2]) : 0;

          return DateTime(year, month, day, hour, minute, second);
        }
      } catch (_) {
        // Ignore parsing errors
      }
      return null;
    }
  }

  /// Map feed category to app categories.
  String _mapCategory(String feedCategory, String url) {
    final path = url.toLowerCase();

    if (path.contains('economy') ||
        path.contains('finance') ||
        path.contains('money') ||
        path.contains('business')) {
      return 'Economy';
    }
    if (path.contains('invest')) {
      return 'Investment';
    }
    if (path.contains('entertainment') ||
        path.contains('sports') ||
        path.contains('culture') ||
        path.contains('lifestyle')) {
      return 'Events';
    }
    if (path.contains('politics') ||
        path.contains('policy') ||
        path.contains('government') ||
        path.contains('law')) {
      return 'Policy';
    }

    if (feedCategory == 'Entertainment' || feedCategory == 'Lifestyle') {
      return 'Events';
    }

    return 'Business';
  }

  /// Strip HTML tags from content.
  String _stripHtml(String html) {
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  /// Extract first image URL from HTML content.
  Map<String, dynamic>? _extractImageUrl(String content) {
    final match = RegExp(r'<img[^>]+src="([^"]+)"').firstMatch(content);
    if (match != null && match.group(1) != null) {
      return {'url': match.group(1)};
    }
    return null;
  }

  /// Clear the cache (useful for pull-to-refresh).
  void clearCache() {
    _cachedNews = null;
    _cacheTimestamp = null;
  }
}

/// HTTP client provider.
final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

/// Provider for RssNewsService.
final rssNewsServiceProvider = Provider<RssNewsService>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return RssNewsService(httpClient);
});
