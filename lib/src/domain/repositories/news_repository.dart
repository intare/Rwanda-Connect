import '../entities/news.dart';

/// Result type for news operations.
sealed class NewsResult<T> {
  const NewsResult();
}

class NewsSuccess<T> extends NewsResult<T> {
  const NewsSuccess(this.data, {this.hasMore = false, this.isFromCache = false});
  final T data;
  final bool hasMore;
  final bool isFromCache;
}

class NewsFailure<T> extends NewsResult<T> {
  const NewsFailure(this.message);
  final String message;
}

/// Parameters for fetching news.
class GetNewsParams {
  const GetNewsParams({
    this.page = 1,
    this.limit = 20,
    this.search,
    this.category,
    this.sort = 'publishDate:desc',
  });

  final int page;
  final int limit;
  final String? search;
  final String? category;
  final String sort;

  GetNewsParams copyWith({
    int? page,
    int? limit,
    String? search,
    String? category,
    String? sort,
  }) {
    return GetNewsParams(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      search: search ?? this.search,
      category: category ?? this.category,
      sort: sort ?? this.sort,
    );
  }

  Map<String, dynamic> toQueryParams() {
    return {
      'page': page,
      'limit': limit,
      if (search != null && search!.isNotEmpty) 'search': search,
      if (category != null && category!.isNotEmpty) 'category': category,
      'sort': sort,
    };
  }
}

/// Repository interface for news operations.
abstract class NewsRepository {
  /// Get paginated list of news articles.
  Future<NewsResult<List<News>>> getNews(GetNewsParams params);

  /// Get a single news article by ID.
  Future<NewsResult<News>> getNewsById(String id);

  /// Get featured news articles.
  Future<NewsResult<List<News>>> getFeaturedNews({int limit = 5});
}
