import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/connectivity_service.dart';
import '../../domain/entities/news.dart';
import '../../domain/repositories/news_repository.dart';
import '../cache/cache_service.dart';
import '../mappers/news_mapper.dart';
import '../services/rss_news_service.dart';

/// Implementation of NewsRepository using direct RSS feeds with offline caching.
class NewsRepositoryImpl implements NewsRepository {
  NewsRepositoryImpl(
    this._rssNewsService,
    this._cacheService,
    this._connectivityService,
  );

  final RssNewsService _rssNewsService;
  final CacheService _cacheService;
  final ConnectivityService _connectivityService;

  @override
  Future<NewsResult<List<News>>> getNews(GetNewsParams params) async {
    // Try network first if online
    if (_connectivityService.isOnline) {
      try {
        final response = await _rssNewsService.getNews(
          page: params.page,
          limit: params.limit,
          category: params.category,
          search: params.search,
        );

        // Cache the response
        await _cacheService.cacheNewsList(
          response.news.map((n) => n.toJson()).toList(),
          category: params.category,
          search: params.search,
          page: params.page,
        );

        final news = response.news.toEntities();
        return NewsSuccess(news, hasMore: response.hasNext);
      } catch (e) {
        // Try cache on network error
        return _getNewsFromCache(params, e.toString());
      }
    } else {
      // Offline - try cache
      return _getNewsFromCache(params, null);
    }
  }

  Future<NewsResult<List<News>>> _getNewsFromCache(
    GetNewsParams params,
    String? networkError,
  ) async {
    final cached = await _cacheService.getNewsList(
      category: params.category,
      search: params.search,
      page: params.page,
    );

    if (cached != null && cached.isNotEmpty) {
      final news = cached.map((json) => NewsDtoMapper.fromJson(json)).toList();
      return NewsSuccess(
        news.toEntities(),
        hasMore: false, // Can't know if more exists when offline
        isFromCache: true,
      );
    }

    // No cache available
    if (networkError != null) {
      return NewsFailure('Failed to fetch news: $networkError');
    }
    return const NewsFailure(
        'No internet connection and no cached data available.');
  }

  @override
  Future<NewsResult<News>> getNewsById(String id) async {
    // For RSS, we don't have individual article fetching
    // Try to find it in the cache
    final cached = await _cacheService.getNewsById(id);

    if (cached != null) {
      final newsDto = NewsDtoMapper.fromJson(cached);
      return NewsSuccess(newsDto.toEntity(), isFromCache: true);
    }

    // If not in cache, try to find it in the current feed
    if (_connectivityService.isOnline) {
      try {
        final response = await _rssNewsService.getNews(page: 1, limit: 100);
        final article = response.news.where((n) => n.id.toString() == id).firstOrNull;

        if (article != null) {
          await _cacheService.cacheNewsDetail(id, article.toJson());
          return NewsSuccess(article.toEntity());
        }
      } catch (_) {
        // Fall through to error
      }
    }

    return const NewsFailure('Article not found.');
  }

  @override
  Future<NewsResult<List<News>>> getFeaturedNews({int limit = 5}) async {
    if (_connectivityService.isOnline) {
      try {
        final response = await _rssNewsService.getFeaturedNews(limit: limit);

        // Cache featured news
        await _cacheService.cacheFeaturedNews(
          response.news.map((n) => n.toJson()).toList(),
        );

        final news = response.news.toEntities();
        return NewsSuccess(news);
      } catch (e) {
        return _getFeaturedFromCache(e.toString());
      }
    } else {
      return _getFeaturedFromCache(null);
    }
  }

  Future<NewsResult<List<News>>> _getFeaturedFromCache(
    String? networkError,
  ) async {
    final cached = await _cacheService.getFeaturedNews();

    if (cached != null && cached.isNotEmpty) {
      final news = cached.map((json) => NewsDtoMapper.fromJson(json)).toList();
      return NewsSuccess(news.toEntities(), isFromCache: true);
    }

    if (networkError != null) {
      return NewsFailure('Failed to fetch featured news: $networkError');
    }
    return const NewsFailure(
        'No internet connection and no cached data available.');
  }
}

/// Provider for NewsRepository.
final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  final rssNewsService = ref.watch(rssNewsServiceProvider);
  final cacheService = ref.watch(cacheServiceProvider);
  final connectivityService = ref.watch(connectivityServiceProvider);
  return NewsRepositoryImpl(rssNewsService, cacheService, connectivityService);
});
