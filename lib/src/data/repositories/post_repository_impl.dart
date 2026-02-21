import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_interceptors.dart';
import '../../domain/entities/comment.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../mappers/comment_mapper.dart';
import '../mappers/post_mapper.dart';
import '../services/post_service.dart';

/// Implementation of PostRepository using Payload CMS.
class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl(this._postService);

  final PostService _postService;

  @override
  Future<PostResult<List<Post>>> getPosts(GetPostsParams params) async {
    try {
      final response = await _postService.getPosts(
        page: params.page,
        limit: params.limit,
        search: params.search,
        sort: _mapSort(params.sort),
      );
      final posts = response.posts.toEntities();
      return PostSuccess(posts, hasMore: response.hasNext);
    } on DioException catch (e) {
      return PostFailure(_handleDioError(e));
    } catch (e) {
      return PostFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<PostResult<Post>> getPostById(String id) async {
    try {
      final response = await _postService.getPostById(id);
      return PostSuccess(response.toEntity());
    } on DioException catch (e) {
      return PostFailure(_handleDioError(e));
    } catch (e) {
      return PostFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<PostResult<Post>> createPost(String content) async {
    try {
      final response = await _postService.createPost(content);
      return PostSuccess(response.toEntity());
    } on DioException catch (e) {
      return PostFailure(_handleDioError(e));
    } catch (e) {
      return PostFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<PostResult<Post>> updatePost(String postId, String content) async {
    try {
      final response = await _postService.updatePost(postId, content);
      return PostSuccess(response.toEntity());
    } on DioException catch (e) {
      return PostFailure(_handleDioError(e));
    } catch (e) {
      return PostFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<PostResult<void>> deletePost(String postId) async {
    try {
      await _postService.deletePost(postId);
      return const PostSuccess(null);
    } on DioException catch (e) {
      return PostFailure(_handleDioError(e));
    } catch (e) {
      return PostFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<PostResult<bool>> likePost(String postId) async {
    // TODO: Implement likes in Payload CMS
    return const PostSuccess(true);
  }

  @override
  Future<PostResult<bool>> unlikePost(String postId) async {
    // TODO: Implement likes in Payload CMS
    return const PostSuccess(true);
  }

  @override
  Future<PostResult<List<Comment>>> getComments(GetCommentsParams params) async {
    try {
      final response = await _postService.getComments(
        postId: params.postId,
        page: params.page,
        limit: params.limit,
      );
      final comments = response.comments.toEntities();
      return PostSuccess(comments, hasMore: response.hasNext);
    } on DioException catch (e) {
      return PostFailure(_handleDioError(e));
    } catch (e) {
      return PostFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<PostResult<Comment>> createComment(String postId, String content) async {
    try {
      final response = await _postService.createComment(
        postId: postId,
        content: content,
      );
      return PostSuccess(response.toEntity());
    } on DioException catch (e) {
      return PostFailure(_handleDioError(e));
    } catch (e) {
      return PostFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<PostResult<void>> deleteComment(String commentId) async {
    try {
      await _postService.deleteComment(commentId);
      return const PostSuccess(null);
    } on DioException catch (e) {
      return PostFailure(_handleDioError(e));
    } catch (e) {
      return PostFailure('An unexpected error occurred: $e');
    }
  }

  /// Map legacy sort format to Payload format.
  String _mapSort(String sort) {
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
          return 'Post not found.';
        }
        return 'Server error: $statusCode';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}

/// Provider for PostRepository.
final postRepositoryProvider = Provider<PostRepository>((ref) {
  final postService = ref.watch(postServiceProvider);
  return PostRepositoryImpl(postService);
});
