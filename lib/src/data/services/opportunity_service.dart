import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../models/opportunities/opportunity_dto.dart';

/// Response from opportunities list API.
class OpportunityListResponse {
  const OpportunityListResponse({
    required this.opportunities,
    required this.hasNext,
    required this.total,
    required this.page,
    required this.totalPages,
  });

  final List<OpportunityDto> opportunities;
  final bool hasNext;
  final int total;
  final int page;
  final int totalPages;
}

/// Service for making opportunity-related API calls using Payload CMS.
class OpportunityService {
  OpportunityService(this._dio);

  final Dio _dio;

  /// Get paginated list of opportunities.
  Future<OpportunityListResponse> getOpportunities({
    int page = 1,
    int limit = 10,
    String? type,
    String? location,
    String? search,
    String sort = '-datePosted',
    bool? verified,
    bool? isFeatured,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'limit': limit,
      'sort': sort,
      'depth': 1,
    };

    // Add filters using Payload's where syntax
    if (type != null && type.isNotEmpty) {
      queryParams['where[type][equals]'] = type;
    }

    if (location != null && location.isNotEmpty) {
      queryParams['where[location][contains]'] = location;
    }

    if (verified != null) {
      queryParams['where[verified][equals]'] = verified;
    }

    if (isFeatured != null) {
      queryParams['where[isFeatured][equals]'] = isFeatured;
    }

    if (search != null && search.isNotEmpty) {
      queryParams['where[or][0][title][contains]'] = search;
      queryParams['where[or][1][company][contains]'] = search;
      queryParams['where[or][2][location][contains]'] = search;
    }

    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.opportunities,
      queryParameters: queryParams,
    );

    final data = response.data!;
    final docs = data['docs'] as List<dynamic>;

    return OpportunityListResponse(
      opportunities: docs
          .map((item) => OpportunityDto.fromJson(item as Map<String, dynamic>))
          .toList(),
      hasNext: data['hasNextPage'] as bool? ?? false,
      total: data['totalDocs'] as int? ?? 0,
      page: data['page'] as int? ?? 1,
      totalPages: data['totalPages'] as int? ?? 1,
    );
  }

  /// Get featured opportunities.
  Future<OpportunityListResponse> getFeaturedOpportunities({int limit = 5}) async {
    return getOpportunities(
      page: 1,
      limit: limit,
      isFeatured: true,
      sort: '-datePosted',
    );
  }

  /// Get opportunities by type.
  Future<OpportunityListResponse> getOpportunitiesByType(
    String type, {
    int page = 1,
    int limit = 10,
  }) async {
    return getOpportunities(
      page: page,
      limit: limit,
      type: type,
    );
  }

  /// Get a single opportunity by ID.
  Future<OpportunityDto> getOpportunityById(String id) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.opportunityDetail(id),
    );

    return OpportunityDto.fromJson(response.data!);
  }

  /// Search opportunities.
  Future<OpportunityListResponse> searchOpportunities(
    String query, {
    int page = 1,
    int limit = 10,
  }) async {
    return getOpportunities(
      page: page,
      limit: limit,
      search: query,
    );
  }
}

/// Provider for OpportunityService.
final opportunityServiceProvider = Provider<OpportunityService>((ref) {
  final dio = ref.watch(dioProvider);
  return OpportunityService(dio);
});
