import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../models/directory/business_dto.dart';

/// Service for making business directory API calls.
class DirectoryService {
  DirectoryService(this._dio);

  final Dio _dio;

  /// Get paginated list of businesses.
  Future<BusinessesListResponse> getBusinesses({
    int page = 1,
    int limit = 20,
    String? category,
    String? city,
    String? search,
    String? sort,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'limit': limit,
      'depth': 1,
    };

    if (category != null) queryParams['where[category][equals]'] = category;
    if (city != null) queryParams['where[city][contains]'] = city;
    if (search != null) queryParams['where[name][contains]'] = search;
    if (sort != null) queryParams['sort'] = sort;

    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.businessDirectory,
      queryParameters: queryParams,
    );

    return BusinessesListResponse.fromJson(response.data!);
  }

  /// Get a single business by ID.
  Future<BusinessDto> getBusinessById(String id) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.businessDetail(id),
      queryParameters: {'depth': 2},
    );
    return BusinessDto.fromJson(response.data!);
  }

  /// Get featured businesses.
  Future<BusinessesListResponse> getFeaturedBusinesses({int limit = 5}) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.businessDirectory,
      queryParameters: {
        'where[isFeatured][equals]': true,
        'limit': limit,
        'depth': 1,
      },
    );
    return BusinessesListResponse.fromJson(response.data!);
  }

  /// Get list of unique cities from businesses.
  Future<List<String>> getCities() async {
    // Fetch a larger set of businesses to extract unique cities
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.businessDirectory,
      queryParameters: {
        'limit': 100,
        'depth': 0,
      },
    );

    final businessesResponse = BusinessesListResponse.fromJson(response.data!);
    final cities = businessesResponse.docs
        .where((b) => b.city != null)
        .map((b) {
          final city = b.city;
          if (city is String) return city;
          if (city is Map) return city['name']?.toString() ?? '';
          return city?.toString() ?? '';
        })
        .where((c) => c.isNotEmpty)
        .toSet()
        .toList();
    cities.sort();
    return cities;
  }
}

/// Provider for DirectoryService.
final directoryServiceProvider = Provider<DirectoryService>((ref) {
  final dio = ref.watch(dioProvider);
  return DirectoryService(dio);
});
