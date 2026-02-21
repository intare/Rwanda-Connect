import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_interceptors.dart';
import '../../core/network/connectivity_service.dart';
import '../../domain/entities/playbook.dart';
import '../../domain/repositories/playbook_repository.dart';
import '../mappers/playbook_mapper.dart';
import '../services/playbook_service.dart';

/// Implementation of PlaybookRepository with offline awareness.
class PlaybookRepositoryImpl implements PlaybookRepository {
  PlaybookRepositoryImpl(
    this._playbookService,
    this._connectivityService,
  );

  final PlaybookService _playbookService;
  final ConnectivityService _connectivityService;

  @override
  Future<PlaybookResult<List<PlaybookContent>>> getContent(
    GetPlaybookParams params,
  ) async {
    if (!_connectivityService.isOnline) {
      return const PlaybookFailure(
        'No internet connection. Playbook content requires online access.',
      );
    }

    try {
      final response = await _playbookService.getContent(
        page: params.page,
        limit: params.limit,
        categoryId: params.categoryId,
        type: params.type?.value,
        difficulty: params.difficulty?.value,
        search: params.search,
        isFeatured: params.isFeatured,
        isPremium: params.isPremium,
        sort: _mapSort(params.sort),
      );

      final content = response.docs.toEntities();
      return PlaybookSuccess(content, hasMore: response.hasNextPage);
    } on DioException catch (e) {
      return PlaybookFailure(_handleDioError(e));
    } catch (e) {
      return PlaybookFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<PlaybookResult<PlaybookContent>> getContentById(String id) async {
    if (!_connectivityService.isOnline) {
      return const PlaybookFailure(
        'No internet connection. Content details require online access.',
      );
    }

    try {
      final response = await _playbookService.getContentById(id);
      return PlaybookSuccess(response.toEntity());
    } on DioException catch (e) {
      return PlaybookFailure(_handleDioError(e));
    } catch (e) {
      return PlaybookFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<PlaybookResult<List<PlaybookContent>>> getFeaturedContent({
    int limit = 5,
  }) async {
    if (!_connectivityService.isOnline) {
      return const PlaybookFailure('No internet connection.');
    }

    try {
      final response = await _playbookService.getFeaturedContent(limit: limit);
      final content = response.docs.toEntities();
      return PlaybookSuccess(content);
    } on DioException catch (e) {
      return PlaybookFailure(_handleDioError(e));
    } catch (e) {
      return PlaybookFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<PlaybookResult<List<PlaybookCategory>>> getCategories() async {
    if (!_connectivityService.isOnline) {
      return const PlaybookFailure('No internet connection.');
    }

    try {
      final response = await _playbookService.getCategories();
      final categories = response.docs.toEntities();
      return PlaybookSuccess(categories);
    } on DioException catch (e) {
      return PlaybookFailure(_handleDioError(e));
    } catch (e) {
      return PlaybookFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<PlaybookResult<List<PlaybookContent>>> getContentByCategory(
    String categoryId, {
    int page = 1,
    int limit = 20,
  }) async {
    if (!_connectivityService.isOnline) {
      return const PlaybookFailure('No internet connection.');
    }

    try {
      final response = await _playbookService.getContent(
        page: page,
        limit: limit,
        categoryId: categoryId,
        sort: '-createdAt',
      );

      final content = response.docs.toEntities();
      return PlaybookSuccess(content, hasMore: response.hasNextPage);
    } on DioException catch (e) {
      return PlaybookFailure(_handleDioError(e));
    } catch (e) {
      return PlaybookFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<PlaybookResult<void>> likeContent(String contentId) async {
    if (!_connectivityService.isOnline) {
      return const PlaybookFailure('No internet connection.');
    }

    try {
      await _playbookService.likeContent(contentId);
      return const PlaybookSuccess(null);
    } on DioException catch (e) {
      return PlaybookFailure(_handleDioError(e));
    } catch (e) {
      return PlaybookFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<PlaybookResult<void>> unlikeContent(String contentId) async {
    if (!_connectivityService.isOnline) {
      return const PlaybookFailure('No internet connection.');
    }

    try {
      await _playbookService.unlikeContent(contentId);
      return const PlaybookSuccess(null);
    } on DioException catch (e) {
      return PlaybookFailure(_handleDioError(e));
    } catch (e) {
      return PlaybookFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<PlaybookResult<bool>> isContentLiked(String contentId) async {
    if (!_connectivityService.isOnline) {
      return const PlaybookFailure('No internet connection.');
    }

    try {
      final isLiked = await _playbookService.isContentLiked(contentId);
      return PlaybookSuccess(isLiked);
    } on DioException catch (e) {
      return PlaybookFailure(_handleDioError(e));
    } catch (e) {
      return PlaybookFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<PlaybookResult<List<PlaybookContent>>> getLikedContent({
    int page = 1,
    int limit = 20,
  }) async {
    if (!_connectivityService.isOnline) {
      return const PlaybookFailure('No internet connection.');
    }

    try {
      final response = await _playbookService.getLikedContent(
        page: page,
        limit: limit,
      );

      final content = response.docs.toEntities();
      return PlaybookSuccess(content, hasMore: response.hasNextPage);
    } on DioException catch (e) {
      return PlaybookFailure(_handleDioError(e));
    } catch (e) {
      return PlaybookFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<PlaybookResult<void>> recordView(String contentId) async {
    if (!_connectivityService.isOnline) {
      return const PlaybookSuccess(null); // Silently fail offline
    }

    try {
      await _playbookService.recordView(contentId);
      return const PlaybookSuccess(null);
    } catch (_) {
      // Silently fail - view recording is non-critical
      return const PlaybookSuccess(null);
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
          return 'Content not found.';
        }
        if (statusCode == 403) {
          return 'You don\'t have permission to view this content.';
        }
        return 'Server error: $statusCode';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}

/// Provider for PlaybookRepository.
final playbookRepositoryProvider = Provider<PlaybookRepository>((ref) {
  final playbookService = ref.watch(playbookServiceProvider);
  final connectivityService = ref.watch(connectivityServiceProvider);
  return PlaybookRepositoryImpl(
    playbookService,
    connectivityService,
  );
});
