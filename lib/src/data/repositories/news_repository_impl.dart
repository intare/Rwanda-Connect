import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_interceptors.dart';
import '../../core/network/connectivity_service.dart';
import '../../domain/entities/news.dart';
import '../../domain/repositories/news_repository.dart';
import '../cache/cache_service.dart';
import '../mappers/news_mapper.dart';
import '../services/news_service.dart';

/// Implementation of NewsRepository using Payload CMS with offline caching.
class NewsRepositoryImpl implements NewsRepository {
  NewsRepositoryImpl(this._newsService, this._cacheService, this._connectivityService);

  final NewsService _newsService;
  final CacheService _cacheService;
  final ConnectivityService _connectivityService;

  @override
  Future<NewsResult<List<News>>> getNews(GetNewsParams params) async {
    // Try network first if online
    if (_connectivityService.isOnline) {
      try {
        final response = await _newsService.getNews(
          page: params.page,
          limit: params.limit,
          category: params.category,
          search: params.search,
          sort: _mapSort(params.sort),
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
      } on DioException catch (e) {
        // Try cache on network error
        return _getNewsFromCache(params, e);
      } catch (e) {
        return NewsFailure('An unexpected error occurred: $e');
      }
    } else {
      // Offline - try cache
      return _getNewsFromCache(params, null);
    }
  }

  Future<NewsResult<List<News>>> _getNewsFromCache(
    GetNewsParams params,
    DioException? networkError,
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
      return NewsFailure(_handleDioError(networkError));
    }
    return const NewsFailure('No internet connection and no cached data available.');
  }

  @override
  Future<NewsResult<News>> getNewsById(String id) async {
    if (_connectivityService.isOnline) {
      try {
        final response = await _newsService.getNewsById(id);

        // Cache the detail
        await _cacheService.cacheNewsDetail(id, response.toJson());

        return NewsSuccess(response.toEntity());
      } on DioException catch (e) {
        return _getNewsDetailFromCache(id, e);
      } catch (e) {
        return NewsFailure('An unexpected error occurred: $e');
      }
    } else {
      return _getNewsDetailFromCache(id, null);
    }
  }

  Future<NewsResult<News>> _getNewsDetailFromCache(
    String id,
    DioException? networkError,
  ) async {
    final cached = await _cacheService.getNewsById(id);

    if (cached != null) {
      final newsDto = NewsDtoMapper.fromJson(cached);
      return NewsSuccess(newsDto.toEntity(), isFromCache: true);
    }

    if (networkError != null) {
      return NewsFailure(_handleDioError(networkError));
    }
    return const NewsFailure('No internet connection and article not cached.');
  }

  @override
  Future<NewsResult<List<News>>> getFeaturedNews({int limit = 5}) async {
    debugPrint('NewsRepository: getFeaturedNews called, isOnline=${_connectivityService.isOnline}');
    if (_connectivityService.isOnline) {
      try {
        final response = await _newsService.getFeaturedNews(limit: limit);
        debugPrint('NewsRepository: Got ${response.news.length} news items from API');

        // Cache featured news
        await _cacheService.cacheFeaturedNews(
          response.news.map((n) => n.toJson()).toList(),
        );

        debugPrint('NewsRepository: Calling toEntities()...');
        final news = response.news.toEntities();
        debugPrint('NewsRepository: toEntities done, first imageUrl=${news.isNotEmpty ? news.first.imageUrl : "empty"}');
        return NewsSuccess(news);
      } on DioException catch (e) {
        return _getFeaturedFromCache(e);
      } catch (e) {
        return NewsFailure('An unexpected error occurred: $e');
      }
    } else {
      return _getFeaturedFromCache(null);
    }
  }

  Future<NewsResult<List<News>>> _getFeaturedFromCache(
    DioException? networkError,
  ) async {
    final cached = await _cacheService.getFeaturedNews();

    if (cached != null && cached.isNotEmpty) {
      final news = cached.map((json) => NewsDtoMapper.fromJson(json)).toList();
      return NewsSuccess(news.toEntities(), isFromCache: true);
    }

    if (networkError != null) {
      return NewsFailure(_handleDioError(networkError));
    }
    return const NewsFailure('No internet connection and no cached data available.');
  }

  /// Map legacy sort format to Payload format.
  String _mapSort(String sort) {
    // Convert "publishDate:desc" to "-publishDate"
    final parts = sort.split(':');
    if (parts.length == 2) {
      final field = parts[0];
      final direction = parts[1];
      return direction == 'desc' ? '-$field' : field;
    }
    return sort;
  }

  String _handleDioError(DioException e) {
    final error = e.error;
    if (error is ApiError) {
      return error.message;
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please try again.';
      case DioExceptionType.connectionError:
        return 'No internet connection.';
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) {
          return 'News article not found.';
        }
        return 'Server error: $statusCode';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}

/// Provider for NewsRepository.
final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  final newsService = ref.watch(newsServiceProvider);
  final cacheService = ref.watch(cacheServiceProvider);
  final connectivityService = ref.watch(connectivityServiceProvider);
  return NewsRepositoryImpl(newsService, cacheService, connectivityService);
});
