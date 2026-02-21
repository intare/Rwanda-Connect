import '../entities/business.dart';

/// Result type for directory operations.
sealed class DirectoryResult<T> {
  const DirectoryResult();
}

class DirectorySuccess<T> extends DirectoryResult<T> {
  const DirectorySuccess(this.data, {this.hasMore = false});
  final T data;
  final bool hasMore;
}

class DirectoryFailure<T> extends DirectoryResult<T> {
  const DirectoryFailure(this.message);
  final String message;
}

/// Parameters for fetching businesses.
class GetBusinessesParams {
  const GetBusinessesParams({
    this.page = 1,
    this.limit = 20,
    this.search,
    this.category,
    this.city,
    this.sort = 'name:asc',
  });

  final int page;
  final int limit;
  final String? search;
  final BusinessCategory? category;
  final String? city;
  final String sort;

  GetBusinessesParams copyWith({
    int? page,
    int? limit,
    String? search,
    BusinessCategory? category,
    String? city,
    String? sort,
    bool clearCategory = false,
    bool clearSearch = false,
    bool clearCity = false,
  }) {
    return GetBusinessesParams(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      search: clearSearch ? null : (search ?? this.search),
      category: clearCategory ? null : (category ?? this.category),
      city: clearCity ? null : (city ?? this.city),
      sort: sort ?? this.sort,
    );
  }

  /// Check if any filters are active.
  bool get hasActiveFilters =>
      category != null ||
      (search != null && search!.isNotEmpty) ||
      (city != null && city!.isNotEmpty);
}

/// Repository interface for directory operations.
abstract class DirectoryRepository {
  /// Get paginated list of businesses.
  Future<DirectoryResult<List<Business>>> getBusinesses(GetBusinessesParams params);

  /// Get a single business by ID.
  Future<DirectoryResult<Business>> getBusinessById(String id);

  /// Get featured businesses.
  Future<DirectoryResult<List<Business>>> getFeaturedBusinesses({int limit = 5});

  /// Get list of available cities for filtering.
  Future<DirectoryResult<List<String>>> getCities();
}
