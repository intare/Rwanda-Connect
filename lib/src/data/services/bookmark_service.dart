import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../models/bookmarks/bookmark_dto.dart';

/// Response from bookmarks list API.
class BookmarkListResponse {
  const BookmarkListResponse({
    required this.bookmarks,
    required this.hasNext,
    required this.total,
    required this.page,
    required this.totalPages,
  });

  final List<BookmarkDto> bookmarks;
  final bool hasNext;
  final int total;
  final int page;
  final int totalPages;
}

/// Service for making bookmark-related API calls using Payload CMS.
class BookmarkService {
  BookmarkService(this._dio);

  final Dio _dio;

  /// Get paginated list of user's bookmarks.
  Future<BookmarkListResponse> getBookmarks({
    int page = 1,
    int limit = 20,
    String? type,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'limit': limit,
      'sort': '-createdAt',
      'depth': 2, // Populate the opportunity relation
    };

    // Filter by type if specified
    if (type != null && type.isNotEmpty) {
      queryParams['where[entityType][equals]'] = type;
    }

    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.bookmarks,
      queryParameters: queryParams,
    );

    final data = response.data!;
    final docs = data['docs'] as List<dynamic>;

    return BookmarkListResponse(
      bookmarks: docs
          .map((item) => BookmarkDto.fromJson(item as Map<String, dynamic>))
          .toList(),
      hasNext: data['hasNextPage'] as bool? ?? false,
      total: data['totalDocs'] as int? ?? 0,
      page: data['page'] as int? ?? 1,
      totalPages: data['totalPages'] as int? ?? 1,
    );
  }

  /// Get bookmarks by type.
  Future<BookmarkListResponse> getBookmarksByType(
    String type, {
    int page = 1,
    int limit = 20,
  }) async {
    return getBookmarks(page: page, limit: limit, type: type);
  }

  /// Check if an item is bookmarked.
  Future<BookmarkDto?> getBookmarkByItemId(String itemId, String type) async {
    final queryParams = <String, dynamic>{
      'where[entityId][equals]': itemId,
      'where[entityType][equals]': type,
      'limit': 1,
    };

    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.bookmarks,
      queryParameters: queryParams,
    );

    final data = response.data!;
    final docs = data['docs'] as List<dynamic>;

    if (docs.isEmpty) return null;
    return BookmarkDto.fromJson(docs.first as Map<String, dynamic>);
  }

  /// Create a new bookmark.
  Future<BookmarkDto> createBookmark({
    required String type,
    required String itemId,
  }) async {
    final request = CreateBookmarkRequest(type: type, itemId: itemId);

    final response = await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.bookmarks,
      data: request.toJson(),
    );

    final data = response.data!;
    // Payload returns the created doc directly or wrapped in 'doc'
    final doc = data['doc'] ?? data;
    return BookmarkDto.fromJson(doc as Map<String, dynamic>);
  }

  /// Delete a bookmark by ID.
  Future<void> deleteBookmark(String id) async {
    await _dio.delete(ApiEndpoints.bookmarkDetail(id));
  }

  /// Toggle bookmark status for an item.
  /// Returns the bookmark if created, null if removed.
  Future<BookmarkDto?> toggleBookmark({
    required String itemId,
    required String type,
  }) async {
    // Check if already bookmarked
    final existing = await getBookmarkByItemId(itemId, type);

    if (existing != null) {
      // Remove bookmark
      await deleteBookmark(existing.idString);
      return null;
    } else {
      // Create bookmark
      return createBookmark(type: type, itemId: itemId);
    }
  }
}

/// Provider for BookmarkService.
final bookmarkServiceProvider = Provider<BookmarkService>((ref) {
  final dio = ref.watch(dioProvider);
  return BookmarkService(dio);
});
