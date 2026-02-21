import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../models/properties/bid_dto.dart';
import '../models/properties/property_dto.dart';

/// Service for making property-related API calls.
class PropertyService {
  PropertyService(this._dio);

  final Dio _dio;

  /// Get paginated list of properties.
  Future<PropertiesListResponse> getProperties({
    int page = 1,
    int limit = 20,
    String? type,
    String? location,
    String? search,
    double? minPrice,
    double? maxPrice,
    String? sort,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'limit': limit,
      'depth': 1,
    };

    if (type != null) queryParams['where[type][equals]'] = type;
    if (location != null) queryParams['where[location][contains]'] = location;
    if (search != null) queryParams['where[title][contains]'] = search;
    if (minPrice != null) queryParams['where[price][greater_than_equal]'] = minPrice;
    if (maxPrice != null) queryParams['where[price][less_than_equal]'] = maxPrice;
    if (sort != null) queryParams['sort'] = sort;

    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.properties,
      queryParameters: queryParams,
    );

    return PropertiesListResponse.fromJson(response.data!);
  }

  /// Get a single property by ID.
  Future<PropertyDto> getPropertyById(String id) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.propertyDetail(id),
      queryParameters: {'depth': 2},
    );
    return PropertyDto.fromJson(response.data!);
  }

  /// Get featured properties.
  Future<PropertiesListResponse> getFeaturedProperties({int limit = 5}) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.properties,
      queryParameters: {
        'where[isFeatured][equals]': true,
        'limit': limit,
        'depth': 1,
      },
    );
    return PropertiesListResponse.fromJson(response.data!);
  }

  /// Place a bid on a property.
  Future<BidDto> placeBid(String propertyId, double amount, {String? message}) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.bids,
      data: {
        'property': propertyId,
        'amount': amount,
        if (message != null) 'message': message,
      },
    );
    return BidDto.fromJson(response.data!['doc'] ?? response.data!);
  }

  /// Get bids for a property.
  Future<BidsListResponse> getPropertyBids(String propertyId) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.bids,
      queryParameters: {
        'where[property][equals]': propertyId,
        'sort': '-amount',
        'depth': 1,
      },
    );
    return BidsListResponse.fromJson(response.data!);
  }

  /// Get user's bids.
  Future<BidsListResponse> getUserBids({int page = 1, int limit = 20}) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.bids,
      queryParameters: {
        'page': page,
        'limit': limit,
        'sort': '-createdAt',
        'depth': 2,
      },
    );
    return BidsListResponse.fromJson(response.data!);
  }

  /// Withdraw a bid.
  Future<void> withdrawBid(String bidId) async {
    await _dio.patch<Map<String, dynamic>>(
      ApiEndpoints.bidDetail(bidId),
      data: {'status': 'withdrawn'},
    );
  }
}

/// Provider for PropertyService.
final propertyServiceProvider = Provider<PropertyService>((ref) {
  final dio = ref.watch(dioProvider);
  return PropertyService(dio);
});
