import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../models/news/news_dto.dart';

/// Response from news list API.
class NewsListResponse {
  const NewsListResponse({
    required this.news,
    required this.hasNext,
    required this.total,
    required this.page,
    required this.totalPages,
  });

  final List<NewsDto> news;
  final bool hasNext;
  final int total;
  final int page;
  final int totalPages;
}

/// Service for making news-related API calls using Payload CMS.
class NewsService {
  NewsService(this._dio);

  final Dio _dio;

  /// Get paginated list of news articles.
  Future<NewsListResponse> getNews({
    int page = 1,
    int limit = 10,
    String? category,
    String? search,
    String sort = '-publishDate',
    bool? isFeatured,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'limit': limit,
      'sort': sort,
      'depth': 1,
    };

    // Add filters using Payload's where syntax
    if (category != null && category.isNotEmpty) {
      queryParams['where[category][equals]'] = category;
    }

    if (isFeatured != null) {
      queryParams['where[isFeatured][equals]'] = isFeatured;
    }

    if (search != null && search.isNotEmpty) {
      queryParams['where[or][0][title][contains]'] = search;
      queryParams['where[or][1][summary][contains]'] = search;
    }

    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.news,
      queryParameters: queryParams,
    );

    final data = response.data!;
    final docs = data['docs'] as List<dynamic>;

    return NewsListResponse(
      news: docs.map((item) => NewsDto.fromJson(item as Map<String, dynamic>)).toList(),
      hasNext: data['hasNextPage'] as bool? ?? false,
      total: data['totalDocs'] as int? ?? 0,
      page: data['page'] as int? ?? 1,
      totalPages: data['totalPages'] as int? ?? 1,
    );
  }

  /// Get featured news articles.
  Future<NewsListResponse> getFeaturedNews({int limit = 5}) async {
    return getNews(
      page: 1,
      limit: limit,
      isFeatured: true,
      sort: '-publishDate',
    );
  }

  /// Get a single news article by ID.
  Future<NewsDto> getNewsById(String id) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.newsDetail(id),
    );

    return NewsDto.fromJson(response.data!);
  }

  /// Get news by category.
  Future<NewsListResponse> getNewsByCategory(
    String category, {
    int page = 1,
    int limit = 10,
  }) async {
    return getNews(
      page: page,
      limit: limit,
      category: category,
    );
  }
}

/// Provider for NewsService.
final newsServiceProvider = Provider<NewsService>((ref) {
  final dio = ref.watch(dioProvider);
  return NewsService(dio);
});
