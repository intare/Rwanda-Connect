import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_interceptors.dart';
import '../../core/network/connectivity_service.dart';
import '../../domain/entities/business.dart';
import '../../domain/repositories/directory_repository.dart';
import '../mappers/business_mapper.dart';
import '../services/directory_service.dart';

/// Implementation of DirectoryRepository.
class DirectoryRepositoryImpl implements DirectoryRepository {
  DirectoryRepositoryImpl(
    this._directoryService,
    this._connectivityService,
  );

  final DirectoryService _directoryService;
  final ConnectivityService _connectivityService;

  @override
  Future<DirectoryResult<List<Business>>> getBusinesses(
    GetBusinessesParams params,
  ) async {
    if (_connectivityService.isOnline) {
      try {
        final response = await _directoryService.getBusinesses(
          page: params.page,
          limit: params.limit,
          category: params.category?.value,
          city: params.city,
          search: params.search,
          sort: _mapSort(params.sort),
        );

        final businesses = response.docs.toEntities();
        return DirectorySuccess(businesses, hasMore: response.hasNextPage);
      } on DioException catch (e) {
        return DirectoryFailure(_handleDioError(e));
      } catch (e) {
        return DirectoryFailure('An unexpected error occurred: $e');
      }
    } else {
      return const DirectoryFailure(
        'No internet connection. Business directory requires online access.',
      );
    }
  }

  @override
  Future<DirectoryResult<Business>> getBusinessById(String id) async {
    if (_connectivityService.isOnline) {
      try {
        final response = await _directoryService.getBusinessById(id);
        return DirectorySuccess(response.toEntity());
      } on DioException catch (e) {
        return DirectoryFailure(_handleDioError(e));
      } catch (e) {
        return DirectoryFailure('An unexpected error occurred: $e');
      }
    } else {
      return const DirectoryFailure(
        'No internet connection. Business details require online access.',
      );
    }
  }

  @override
  Future<DirectoryResult<List<Business>>> getFeaturedBusinesses({
    int limit = 5,
  }) async {
    if (_connectivityService.isOnline) {
      try {
        final response = await _directoryService.getFeaturedBusinesses(
          limit: limit,
        );
        final businesses = response.docs.toEntities();
        return DirectorySuccess(businesses);
      } on DioException catch (e) {
        return DirectoryFailure(_handleDioError(e));
      } catch (e) {
        return DirectoryFailure('An unexpected error occurred: $e');
      }
    } else {
      return const DirectoryFailure('No internet connection.');
    }
  }

  @override
  Future<DirectoryResult<List<String>>> getCities() async {
    if (_connectivityService.isOnline) {
      try {
        final cities = await _directoryService.getCities();
        return DirectorySuccess(cities);
      } on DioException catch (e) {
        return DirectoryFailure(_handleDioError(e));
      } catch (e) {
        return DirectoryFailure('An unexpected error occurred: $e');
      }
    } else {
      return const DirectoryFailure('No internet connection.');
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
          return 'Business not found.';
        }
        if (statusCode == 403) {
          return 'You don\'t have permission to perform this action.';
        }
        return 'Server error: $statusCode';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}

/// Provider for DirectoryRepository.
final directoryRepositoryProvider = Provider<DirectoryRepository>((ref) {
  final directoryService = ref.watch(directoryServiceProvider);
  final connectivityService = ref.watch(connectivityServiceProvider);
  return DirectoryRepositoryImpl(
    directoryService,
    connectivityService,
  );
});
