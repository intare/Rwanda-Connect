import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_interceptors.dart';
import '../../core/network/connectivity_service.dart';
import '../../domain/entities/opportunity.dart';
import '../../domain/repositories/opportunity_repository.dart';
import '../cache/cache_service.dart';
import '../mappers/opportunity_mapper.dart';
import '../services/opportunity_service.dart';

/// Implementation of OpportunityRepository with offline caching.
class OpportunityRepositoryImpl implements OpportunityRepository {
  OpportunityRepositoryImpl(
    this._opportunityService,
    this._cacheService,
    this._connectivityService,
  );

  final OpportunityService _opportunityService;
  final CacheService _cacheService;
  final ConnectivityService _connectivityService;

  @override
  Future<OpportunityResult<List<Opportunity>>> getOpportunities(
    GetOpportunitiesParams params,
  ) async {
    if (_connectivityService.isOnline) {
      try {
        final response = await _opportunityService.getOpportunities(
          page: params.page,
          limit: params.limit,
          type: params.type?.value,
          location: params.location,
          search: params.search,
          sort: _mapSort(params.sort),
        );

        // Cache the response
        await _cacheService.cacheOpportunities(
          response.opportunities.map((o) => o.toJson()).toList(),
          type: params.type?.value,
          location: params.location,
          search: params.search,
          page: params.page,
        );

        final opportunities = response.opportunities.toEntities();
        return OpportunitySuccess(opportunities, hasMore: response.hasNext);
      } on DioException catch (e) {
        return _getOpportunitiesFromCache(params, e);
      } catch (e) {
        return OpportunityFailure('An unexpected error occurred: $e');
      }
    } else {
      return _getOpportunitiesFromCache(params, null);
    }
  }

  Future<OpportunityResult<List<Opportunity>>> _getOpportunitiesFromCache(
    GetOpportunitiesParams params,
    DioException? networkError,
  ) async {
    final cached = await _cacheService.getOpportunities(
      type: params.type?.value,
      location: params.location,
      search: params.search,
      page: params.page,
    );

    if (cached != null && cached.isNotEmpty) {
      final opportunities =
          cached.map((json) => OpportunityDtoMapper.fromJson(json)).toList();
      return OpportunitySuccess(
        opportunities.toEntities(),
        hasMore: false,
        isFromCache: true,
      );
    }

    if (networkError != null) {
      return OpportunityFailure(_handleDioError(networkError));
    }
    return const OpportunityFailure(
      'No internet connection and no cached data available.',
    );
  }

  @override
  Future<OpportunityResult<Opportunity>> getOpportunityById(String id) async {
    if (_connectivityService.isOnline) {
      try {
        final response = await _opportunityService.getOpportunityById(id);

        // Cache the detail
        await _cacheService.cacheOpportunityDetail(id, response.toJson());

        return OpportunitySuccess(response.toEntity());
      } on DioException catch (e) {
        return _getOpportunityDetailFromCache(id, e);
      } catch (e) {
        return OpportunityFailure('An unexpected error occurred: $e');
      }
    } else {
      return _getOpportunityDetailFromCache(id, null);
    }
  }

  Future<OpportunityResult<Opportunity>> _getOpportunityDetailFromCache(
    String id,
    DioException? networkError,
  ) async {
    final cached = await _cacheService.getOpportunityById(id);

    if (cached != null) {
      final dto = OpportunityDtoMapper.fromJson(cached);
      return OpportunitySuccess(dto.toEntity(), isFromCache: true);
    }

    if (networkError != null) {
      return OpportunityFailure(_handleDioError(networkError));
    }
    return const OpportunityFailure(
      'No internet connection and opportunity not cached.',
    );
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
          return 'Opportunity not found.';
        }
        return 'Server error: $statusCode';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}

/// Provider for OpportunityRepository.
final opportunityRepositoryProvider = Provider<OpportunityRepository>((ref) {
  final opportunityService = ref.watch(opportunityServiceProvider);
  final cacheService = ref.watch(cacheServiceProvider);
  final connectivityService = ref.watch(connectivityServiceProvider);
  return OpportunityRepositoryImpl(
    opportunityService,
    cacheService,
    connectivityService,
  );
});
