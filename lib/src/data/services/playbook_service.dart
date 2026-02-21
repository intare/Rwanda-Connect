import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../models/playbook/playbook_dto.dart';

/// Service for making playbook-related API calls.
class PlaybookService {
  PlaybookService(this._dio);

  final Dio _dio;

  /// Get paginated list of playbook content.
  Future<PlaybookListResponse> getContent({
    int page = 1,
    int limit = 20,
    String? categoryId,
    String? type,
    String? difficulty,
    String? search,
    bool? isFeatured,
    bool? isPremium,
    String? sort,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'limit': limit,
      'depth': 2,
    };

    if (categoryId != null) queryParams['where[category][equals]'] = categoryId;
    if (type != null) queryParams['where[type][equals]'] = type;
    if (difficulty != null) queryParams['where[difficulty][equals]'] = difficulty;
    if (search != null) queryParams['where[title][contains]'] = search;
    if (isFeatured != null) queryParams['where[isFeatured][equals]'] = isFeatured;
    if (isPremium != null) queryParams['where[isPremium][equals]'] = isPremium;
    if (sort != null) queryParams['sort'] = sort;

    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.playbookContent,
      queryParameters: queryParams,
    );

    return PlaybookListResponse.fromJson(response.data!);
  }

  /// Get a single content item by ID.
  Future<PlaybookContentDto> getContentById(String id) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.playbookContentDetail(id),
      queryParameters: {'depth': 2},
    );
    return PlaybookContentDto.fromJson(response.data!);
  }

  /// Get featured content.
  Future<PlaybookListResponse> getFeaturedContent({int limit = 5}) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.playbookContent,
      queryParameters: {
        'where[isFeatured][equals]': true,
        'limit': limit,
        'depth': 2,
      },
    );
    return PlaybookListResponse.fromJson(response.data!);
  }

  /// Get all categories.
  Future<PlaybookCategoriesResponse> getCategories() async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.playbookCategories,
      queryParameters: {
        'limit': 100,
        'sort': 'name',
      },
    );
    return PlaybookCategoriesResponse.fromJson(response.data!);
  }

  /// Like a content item.
  Future<void> likeContent(String contentId) async {
    await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.playbookLikes,
      data: {'content': contentId},
    );
  }

  /// Unlike a content item.
  Future<void> unlikeContent(String contentId) async {
    // First find the like record
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.playbookLikes,
      queryParameters: {
        'where[content][equals]': contentId,
        'limit': 1,
      },
    );

    final docs = response.data!['docs'] as List;
    if (docs.isNotEmpty) {
      final likeId = docs[0]['id'].toString();
      await _dio.delete<Map<String, dynamic>>(
        ApiEndpoints.playbookLikeDetail(likeId),
      );
    }
  }

  /// Check if content is liked by current user.
  Future<bool> isContentLiked(String contentId) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.playbookLikes,
      queryParameters: {
        'where[content][equals]': contentId,
        'limit': 1,
      },
    );

    final docs = response.data!['docs'] as List;
    return docs.isNotEmpty;
  }

  /// Get user's liked content.
  Future<PlaybookListResponse> getLikedContent({
    int page = 1,
    int limit = 20,
  }) async {
    // Get user's likes
    final likesResponse = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.playbookLikes,
      queryParameters: {
        'page': page,
        'limit': limit,
        'depth': 2,
        'sort': '-createdAt',
      },
    );

    // Transform to playbook content list
    final likes = likesResponse.data!['docs'] as List;
    final contentDocs = <Map<String, dynamic>>[];

    for (final like in likes) {
      if (like['content'] is Map<String, dynamic>) {
        contentDocs.add(like['content'] as Map<String, dynamic>);
      }
    }

    return PlaybookListResponse(
      docs: contentDocs.map((e) => PlaybookContentDto.fromJson(e)).toList(),
      totalDocs: likesResponse.data!['totalDocs'] as int,
      limit: likesResponse.data!['limit'] as int,
      page: likesResponse.data!['page'] as int,
      totalPages: likesResponse.data!['totalPages'] as int,
      hasNextPage: likesResponse.data!['hasNextPage'] as bool,
      hasPrevPage: likesResponse.data!['hasPrevPage'] as bool,
    );
  }

  /// Record a view for content.
  Future<void> recordView(String contentId) async {
    await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.playbookViews,
      data: {'content': contentId},
    );
  }
}

/// Provider for PlaybookService.
final playbookServiceProvider = Provider<PlaybookService>((ref) {
  final dio = ref.watch(dioProvider);
  return PlaybookService(dio);
});
