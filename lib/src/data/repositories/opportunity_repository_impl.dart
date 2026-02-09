import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_interceptors.dart';
import '../../domain/entities/opportunity.dart';
import '../../domain/repositories/opportunity_repository.dart';
import '../mappers/opportunity_mapper.dart';
import '../services/opportunity_service.dart';

/// Implementation of OpportunityRepository.
class OpportunityRepositoryImpl implements OpportunityRepository {
  OpportunityRepositoryImpl(this._opportunityService);

  final OpportunityService _opportunityService;

  @override
  Future<OpportunityResult<List<Opportunity>>> getOpportunities(
    GetOpportunitiesParams params,
  ) async {
    try {
      final response = await _opportunityService.getOpportunities(
        page: params.page,
        limit: params.limit,
        type: params.type?.value,
        location: params.location,
        search: params.search,
        sort: _mapSort(params.sort),
      );
      final opportunities = response.opportunities.toEntities();
      return OpportunitySuccess(opportunities, hasMore: response.hasNext);
    } on DioException catch (e) {
      return OpportunityFailure(_handleDioError(e));
    } catch (e) {
      return OpportunityFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<OpportunityResult<Opportunity>> getOpportunityById(String id) async {
    try {
      final response = await _opportunityService.getOpportunityById(id);
      return OpportunitySuccess(response.toEntity());
    } on DioException catch (e) {
      return OpportunityFailure(_handleDioError(e));
    } catch (e) {
      return OpportunityFailure('An unexpected error occurred: $e');
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
  return OpportunityRepositoryImpl(opportunityService);
});
