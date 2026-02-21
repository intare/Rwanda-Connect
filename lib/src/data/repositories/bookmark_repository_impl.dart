import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_interceptors.dart';
import '../../domain/entities/bookmark.dart';
import '../../domain/repositories/bookmark_repository.dart';
import '../mappers/bookmark_mapper.dart';
import '../services/bookmark_service.dart';

/// Implementation of BookmarkRepository.
class BookmarkRepositoryImpl implements BookmarkRepository {
  BookmarkRepositoryImpl(this._bookmarkService);

  final BookmarkService _bookmarkService;

  @override
  Future<BookmarkResult<List<Bookmark>>> getBookmarks(
    GetBookmarksParams params,
  ) async {
    try {
      final response = await _bookmarkService.getBookmarks(
        page: params.page,
        limit: params.limit,
        type: params.type?.value,
      );
      final bookmarks = response.bookmarks.toEntities();
      return BookmarkSuccess(bookmarks, hasMore: response.hasNext);
    } on DioException catch (e) {
      return BookmarkFailure(_handleDioError(e));
    } catch (e) {
      return BookmarkFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<BookmarkResult<Bookmark?>> getBookmarkByItemId(
    String itemId,
    BookmarkType type,
  ) async {
    try {
      final bookmark = await _bookmarkService.getBookmarkByItemId(
        itemId,
        type.value,
      );
      return BookmarkSuccess(bookmark?.toEntity());
    } on DioException catch (e) {
      return BookmarkFailure(_handleDioError(e));
    } catch (e) {
      return BookmarkFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<bool> isBookmarked(String itemId, BookmarkType type) async {
    try {
      final bookmark = await _bookmarkService.getBookmarkByItemId(
        itemId,
        type.value,
      );
      return bookmark != null;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<BookmarkResult<Bookmark>> addBookmark(
    String itemId,
    BookmarkType type,
  ) async {
    try {
      final bookmark = await _bookmarkService.createBookmark(
        type: type.value,
        itemId: itemId,
      );
      return BookmarkSuccess(bookmark.toEntity());
    } on DioException catch (e) {
      return BookmarkFailure(_handleDioError(e));
    } catch (e) {
      return BookmarkFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<BookmarkResult<void>> removeBookmark(String bookmarkId) async {
    try {
      await _bookmarkService.deleteBookmark(bookmarkId);
      return const BookmarkSuccess(null);
    } on DioException catch (e) {
      return BookmarkFailure(_handleDioError(e));
    } catch (e) {
      return BookmarkFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<BookmarkResult<Bookmark?>> toggleBookmark(
    String itemId,
    BookmarkType type,
  ) async {
    try {
      final bookmark = await _bookmarkService.toggleBookmark(
        itemId: itemId,
        type: type.value,
      );
      return BookmarkSuccess(bookmark?.toEntity());
    } on DioException catch (e) {
      return BookmarkFailure(_handleDioError(e));
    } catch (e) {
      return BookmarkFailure('An unexpected error occurred: $e');
    }
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
          return 'Bookmark not found.';
        }
        if (statusCode == 401) {
          return 'Please log in to access bookmarks.';
        }
        if (statusCode == 403) {
          return 'Upgrade your subscription to use bookmarks.';
        }
        return 'Server error: $statusCode';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}

/// Provider for BookmarkRepository.
final bookmarkRepositoryProvider = Provider<BookmarkRepository>((ref) {
  final bookmarkService = ref.watch(bookmarkServiceProvider);
  return BookmarkRepositoryImpl(bookmarkService);
});
