import '../entities/opportunity.dart';

/// Result type for opportunity operations.
sealed class OpportunityResult<T> {
  const OpportunityResult();
}

class OpportunitySuccess<T> extends OpportunityResult<T> {
  const OpportunitySuccess(this.data, {this.hasMore = false, this.isFromCache = false});
  final T data;
  final bool hasMore;
  final bool isFromCache;
}

class OpportunityFailure<T> extends OpportunityResult<T> {
  const OpportunityFailure(this.message);
  final String message;
}

/// Parameters for fetching opportunities.
class GetOpportunitiesParams {
  const GetOpportunitiesParams({
    this.page = 1,
    this.limit = 20,
    this.search,
    this.type,
    this.location,
    this.sort = 'deadline:asc',
  });

  final int page;
  final int limit;
  final String? search;
  final OpportunityType? type;
  final String? location;
  final String sort;

  GetOpportunitiesParams copyWith({
    int? page,
    int? limit,
    String? search,
    OpportunityType? type,
    String? location,
    String? sort,
    bool clearType = false,
    bool clearSearch = false,
    bool clearLocation = false,
  }) {
    return GetOpportunitiesParams(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      search: clearSearch ? null : (search ?? this.search),
      type: clearType ? null : (type ?? this.type),
      location: clearLocation ? null : (location ?? this.location),
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
      'sort': sort,
    };
  }

  /// Check if any filters are active.
  bool get hasActiveFilters =>
      type != null ||
      (search != null && search!.isNotEmpty) ||
      (location != null && location!.isNotEmpty);
}

/// Repository interface for opportunity operations.
abstract class OpportunityRepository {
  /// Get paginated list of opportunities.
  Future<OpportunityResult<List<Opportunity>>> getOpportunities(
    GetOpportunitiesParams params,
  );

  /// Get a single opportunity by ID.
  Future<OpportunityResult<Opportunity>> getOpportunityById(String id);
}
