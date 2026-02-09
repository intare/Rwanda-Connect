import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_interceptors.dart';
import '../../domain/entities/news.dart';
import '../../domain/repositories/news_repository.dart';
import '../mappers/news_mapper.dart';
import '../services/news_service.dart';

/// Implementation of NewsRepository using Payload CMS.
class NewsRepositoryImpl implements NewsRepository {
  NewsRepositoryImpl(this._newsService);

  final NewsService _newsService;

  @override
  Future<NewsResult<List<News>>> getNews(GetNewsParams params) async {
    try {
      final response = await _newsService.getNews(
        page: params.page,
        limit: params.limit,
        category: params.category,
        search: params.search,
        sort: _mapSort(params.sort),
      );
      final news = response.news.toEntities();
      return NewsSuccess(news, hasMore: response.hasNext);
    } on DioException catch (e) {
      return NewsFailure(_handleDioError(e));
    } catch (e) {
      return NewsFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<NewsResult<News>> getNewsById(String id) async {
    try {
      final response = await _newsService.getNewsById(id);
      return NewsSuccess(response.toEntity());
    } on DioException catch (e) {
      return NewsFailure(_handleDioError(e));
    } catch (e) {
      return NewsFailure('An unexpected error occurred: $e');
    }
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
  return NewsRepositoryImpl(newsService);
});
