import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../models/community/post_dto.dart';
import '../models/community/comment_dto.dart';

/// Response from posts list API.
class PostListResponse {
  const PostListResponse({
    required this.posts,
    required this.hasNext,
    required this.total,
    required this.page,
    required this.totalPages,
  });

  final List<PostDto> posts;
  final bool hasNext;
  final int total;
  final int page;
  final int totalPages;
}

/// Service for making post-related API calls using Payload CMS.
class PostService {
  PostService(this._dio, this._secureStorage);

  final Dio _dio;
  final FlutterSecureStorage _secureStorage;

  static const _tokenKey = 'auth_token';

  /// Get paginated list of posts.
  Future<PostListResponse> getPosts({
    int page = 1,
    int limit = 10,
    String? search,
    String sort = '-createdAt',
    bool? isPinned,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'limit': limit,
      'sort': sort,
      'depth': 1, // Populate author relationship
    };

    // Add filters using Payload's where syntax
    if (isPinned != null) {
      queryParams['where[isPinned][equals]'] = isPinned;
    }

    if (search != null && search.isNotEmpty) {
      queryParams['where[content][contains]'] = search;
    }

    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.posts,
      queryParameters: queryParams,
    );

    final data = response.data!;
    final docs = data['docs'] as List<dynamic>;

    return PostListResponse(
      posts: docs
          .map((item) => PostDto.fromJson(item as Map<String, dynamic>))
          .toList(),
      hasNext: data['hasNextPage'] as bool? ?? false,
      total: data['totalDocs'] as int? ?? 0,
      page: data['page'] as int? ?? 1,
      totalPages: data['totalPages'] as int? ?? 1,
    );
  }

  /// Get pinned posts.
  Future<PostListResponse> getPinnedPosts({int limit = 5}) async {
    return getPosts(
      page: 1,
      limit: limit,
      isPinned: true,
      sort: '-createdAt',
    );
  }

  /// Get a single post by ID.
  Future<PostDto> getPostById(String id) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.postDetail(id),
      queryParameters: {'depth': 1},
    );

    return PostDto.fromJson(response.data!);
  }

  /// Create a new post.
  Future<PostDto> createPost(String content) async {
    final token = await _secureStorage.read(key: _tokenKey);
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final response = await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.posts,
      data: {
        'content': content,
      },
      options: Options(
        headers: {'Authorization': 'JWT $token'},
      ),
    );

    return PostDto.fromJson(response.data!);
  }

  /// Update a post.
  Future<PostDto> updatePost(String postId, String content) async {
    final token = await _secureStorage.read(key: _tokenKey);
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final response = await _dio.patch<Map<String, dynamic>>(
      ApiEndpoints.postDetail(postId),
      data: {
        'content': content,
      },
      options: Options(
        headers: {'Authorization': 'JWT $token'},
      ),
    );

    return PostDto.fromJson(response.data!);
  }

  /// Delete a post.
  Future<void> deletePost(String postId) async {
    final token = await _secureStorage.read(key: _tokenKey);
    if (token == null) {
      throw Exception('Not authenticated');
    }

    await _dio.delete(
      ApiEndpoints.postDetail(postId),
      options: Options(
        headers: {'Authorization': 'JWT $token'},
      ),
    );
  }

  /// Get comments for a post.
  Future<CommentListResponse> getComments({
    required String postId,
    int page = 1,
    int limit = 20,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'limit': limit,
      'sort': 'createdAt',
      'depth': 1, // Populate author relationship
      'where[post][equals]': postId,
    };

    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.comments,
      queryParameters: queryParams,
    );

    final data = response.data!;
    final docs = data['docs'] as List<dynamic>;

    return CommentListResponse(
      comments: docs
          .map((item) => CommentDto.fromJson(item as Map<String, dynamic>))
          .toList(),
      hasNext: data['hasNextPage'] as bool? ?? false,
      total: data['totalDocs'] as int? ?? 0,
      page: data['page'] as int? ?? 1,
      totalPages: data['totalPages'] as int? ?? 1,
    );
  }

  /// Create a new comment.
  Future<CommentDto> createComment({
    required String postId,
    required String content,
  }) async {
    final token = await _secureStorage.read(key: _tokenKey);
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final response = await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.comments,
      data: {
        'post': postId,
        'content': content,
      },
      options: Options(
        headers: {'Authorization': 'JWT $token'},
      ),
    );

    final doc = response.data!['doc'] ?? response.data!;
    return CommentDto.fromJson(doc as Map<String, dynamic>);
  }

  /// Delete a comment.
  Future<void> deleteComment(String commentId) async {
    final token = await _secureStorage.read(key: _tokenKey);
    if (token == null) {
      throw Exception('Not authenticated');
    }

    await _dio.delete(
      ApiEndpoints.commentDetail(commentId),
      options: Options(
        headers: {'Authorization': 'JWT $token'},
      ),
    );
  }
}

/// Response from comments list API.
class CommentListResponse {
  const CommentListResponse({
    required this.comments,
    required this.hasNext,
    required this.total,
    required this.page,
    required this.totalPages,
  });

  final List<CommentDto> comments;
  final bool hasNext;
  final int total;
  final int page;
  final int totalPages;
}

/// Provider for PostService.
final postServiceProvider = Provider<PostService>((ref) {
  final dio = ref.watch(dioProvider);
  final secureStorage = ref.watch(secureStorageProvider);
  return PostService(dio, secureStorage);
});
