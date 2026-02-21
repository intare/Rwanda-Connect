import '../entities/bid.dart';
import '../entities/property.dart';

/// Result type for property operations.
sealed class PropertyResult<T> {
  const PropertyResult();
}

class PropertySuccess<T> extends PropertyResult<T> {
  const PropertySuccess(this.data, {this.hasMore = false, this.isFromCache = false});
  final T data;
  final bool hasMore;
  final bool isFromCache;
}

class PropertyFailure<T> extends PropertyResult<T> {
  const PropertyFailure(this.message);
  final String message;
}

/// Parameters for fetching properties.
class GetPropertiesParams {
  const GetPropertiesParams({
    this.page = 1,
    this.limit = 20,
    this.search,
    this.type,
    this.location,
    this.minPrice,
    this.maxPrice,
    this.sort = 'createdAt:desc',
  });

  final int page;
  final int limit;
  final String? search;
  final PropertyType? type;
  final String? location;
  final double? minPrice;
  final double? maxPrice;
  final String sort;

  GetPropertiesParams copyWith({
    int? page,
    int? limit,
    String? search,
    PropertyType? type,
    String? location,
    double? minPrice,
    double? maxPrice,
    String? sort,
    bool clearType = false,
    bool clearSearch = false,
    bool clearLocation = false,
    bool clearPrice = false,
  }) {
    return GetPropertiesParams(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      search: clearSearch ? null : (search ?? this.search),
      type: clearType ? null : (type ?? this.type),
      location: clearLocation ? null : (location ?? this.location),
      minPrice: clearPrice ? null : (minPrice ?? this.minPrice),
      maxPrice: clearPrice ? null : (maxPrice ?? this.maxPrice),
      sort: sort ?? this.sort,
    );
  }

  Map<String, dynamic> toQueryParams() {
    return {
      'page': page,
      'limit': limit,
      if (search != null && search!.isNotEmpty) 'search': search,
      if (type != null) 'type': type!.value,
      if (location != null && location!.isNotEmpty) 'location': location,
      if (minPrice != null) 'minPrice': minPrice,
      if (maxPrice != null) 'maxPrice': maxPrice,
      'sort': sort,
    };
  }

  /// Check if any filters are active.
  bool get hasActiveFilters =>
      type != null ||
      (search != null && search!.isNotEmpty) ||
      (location != null && location!.isNotEmpty) ||
      minPrice != null ||
      maxPrice != null;
}

/// Repository interface for property operations.
abstract class PropertyRepository {
  /// Get paginated list of properties.
  Future<PropertyResult<List<Property>>> getProperties(GetPropertiesParams params);

  /// Get a single property by ID.
  Future<PropertyResult<Property>> getPropertyById(String id);

  /// Get featured properties.
  Future<PropertyResult<List<Property>>> getFeaturedProperties({int limit = 5});

  /// Place a bid on a property.
  Future<PropertyResult<Bid>> placeBid(String propertyId, double amount, {String? message});

  /// Get bids for a property.
  Future<PropertyResult<List<Bid>>> getPropertyBids(String propertyId);

  /// Get user's bids.
  Future<PropertyResult<List<Bid>>> getUserBids({int page = 1, int limit = 20});

  /// Withdraw a bid.
  Future<PropertyResult<void>> withdrawBid(String bidId);
}
