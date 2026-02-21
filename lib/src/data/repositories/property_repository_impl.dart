import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_interceptors.dart';
import '../../core/network/connectivity_service.dart';
import '../../domain/entities/bid.dart';
import '../../domain/entities/property.dart';
import '../../domain/repositories/property_repository.dart';
import '../cache/cache_service.dart';
import '../mappers/bid_mapper.dart';
import '../mappers/property_mapper.dart';
import '../services/property_service.dart';

/// Implementation of PropertyRepository with offline caching.
class PropertyRepositoryImpl implements PropertyRepository {
  PropertyRepositoryImpl(
    this._propertyService,
    this._cacheService,
    this._connectivityService,
  );

  final PropertyService _propertyService;
  // ignore: unused_field - reserved for future offline caching
  final CacheService _cacheService;
  final ConnectivityService _connectivityService;

  @override
  Future<PropertyResult<List<Property>>> getProperties(
    GetPropertiesParams params,
  ) async {
    if (_connectivityService.isOnline) {
      try {
        final response = await _propertyService.getProperties(
          page: params.page,
          limit: params.limit,
          type: params.type?.value,
          location: params.location,
          search: params.search,
          minPrice: params.minPrice,
          maxPrice: params.maxPrice,
          sort: _mapSort(params.sort),
        );

        final properties = response.docs.toEntities();
        return PropertySuccess(properties, hasMore: response.hasNextPage);
      } on DioException catch (e) {
        return PropertyFailure(_handleDioError(e));
      } catch (e) {
        return PropertyFailure('An unexpected error occurred: $e');
      }
    } else {
      return const PropertyFailure(
        'No internet connection. Properties require online access.',
      );
    }
  }

  @override
  Future<PropertyResult<Property>> getPropertyById(String id) async {
    if (_connectivityService.isOnline) {
      try {
        final response = await _propertyService.getPropertyById(id);
        return PropertySuccess(response.toEntity());
      } on DioException catch (e) {
        return PropertyFailure(_handleDioError(e));
      } catch (e) {
        return PropertyFailure('An unexpected error occurred: $e');
      }
    } else {
      return const PropertyFailure(
        'No internet connection. Property details require online access.',
      );
    }
  }

  @override
  Future<PropertyResult<List<Property>>> getFeaturedProperties({
    int limit = 5,
  }) async {
    if (_connectivityService.isOnline) {
      try {
        final response = await _propertyService.getFeaturedProperties(
          limit: limit,
        );
        final properties = response.docs.toEntities();
        return PropertySuccess(properties);
      } on DioException catch (e) {
        return PropertyFailure(_handleDioError(e));
      } catch (e) {
        return PropertyFailure('An unexpected error occurred: $e');
      }
    } else {
      return const PropertyFailure('No internet connection.');
    }
  }

  @override
  Future<PropertyResult<Bid>> placeBid(
    String propertyId,
    double amount, {
    String? message,
  }) async {
    if (!_connectivityService.isOnline) {
      return const PropertyFailure(
        'No internet connection. Cannot place bid offline.',
      );
    }

    try {
      final response = await _propertyService.placeBid(
        propertyId,
        amount,
        message: message,
      );
      return PropertySuccess(response.toEntity());
    } on DioException catch (e) {
      return PropertyFailure(_handleDioError(e));
    } catch (e) {
      return PropertyFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<PropertyResult<List<Bid>>> getPropertyBids(String propertyId) async {
    if (!_connectivityService.isOnline) {
      return const PropertyFailure('No internet connection.');
    }

    try {
      final response = await _propertyService.getPropertyBids(propertyId);
      final bids = response.docs.toEntities();
      return PropertySuccess(bids);
    } on DioException catch (e) {
      return PropertyFailure(_handleDioError(e));
    } catch (e) {
      return PropertyFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<PropertyResult<List<Bid>>> getUserBids({
    int page = 1,
    int limit = 20,
  }) async {
    if (!_connectivityService.isOnline) {
      return const PropertyFailure('No internet connection.');
    }

    try {
      final response = await _propertyService.getUserBids(
        page: page,
        limit: limit,
      );
      final bids = response.docs.toEntities();
      return PropertySuccess(bids, hasMore: response.hasNextPage);
    } on DioException catch (e) {
      return PropertyFailure(_handleDioError(e));
    } catch (e) {
      return PropertyFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<PropertyResult<void>> withdrawBid(String bidId) async {
    if (!_connectivityService.isOnline) {
      return const PropertyFailure(
        'No internet connection. Cannot withdraw bid offline.',
      );
    }

    try {
      await _propertyService.withdrawBid(bidId);
      return const PropertySuccess(null);
    } on DioException catch (e) {
      return PropertyFailure(_handleDioError(e));
    } catch (e) {
      return PropertyFailure('An unexpected error occurred: $e');
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
          return 'Property not found.';
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

/// Provider for PropertyRepository.
final propertyRepositoryProvider = Provider<PropertyRepository>((ref) {
  final propertyService = ref.watch(propertyServiceProvider);
  final cacheService = ref.watch(cacheServiceProvider);
  final connectivityService = ref.watch(connectivityServiceProvider);
  return PropertyRepositoryImpl(
    propertyService,
    cacheService,
    connectivityService,
  );
});
