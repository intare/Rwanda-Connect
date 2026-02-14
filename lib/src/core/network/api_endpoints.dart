import 'package:flutter/foundation.dart' show kIsWeb;

/// API endpoint constants for Rwanda Connect.
/// Configured for Payload CMS backend.
abstract final class ApiEndpoints {
  // Base URL - override with --dart-define=RWANDA_CONNECT_API_BASE_URL=...
  // For Android emulator use 10.0.2.2, for iOS simulator/web use localhost
  static const String _envBaseUrl = String.fromEnvironment(
    'RWANDA_CONNECT_API_BASE_URL',
    defaultValue: '',
  );

  // Use localhost for web, 10.0.2.2 for Android emulator
  static String get baseUrl {
    if (_envBaseUrl.isNotEmpty) return _envBaseUrl;
    return kIsWeb ? 'http://localhost:3000/api' : 'http://10.0.2.2:3000/api';
  }

  /// Server URL without /api suffix - used for media URLs
  static String get serverUrl {
    final base = baseUrl;
    if (base.endsWith('/api')) {
      return base.substring(0, base.length - 4);
    }
    return base;
  }

  // Auth endpoints (Payload CMS)
  static const String login = '/users/login';
  static const String logout = '/users/logout';
  static const String register = '/users';
  static const String me = '/users/me';
  static const String refreshToken = '/users/refresh-token';

  // News endpoints
  static const String news = '/news';
  static String newsDetail(String id) => '/news/$id';

  // Opportunities endpoints
  static const String opportunities = '/opportunities';
  static String opportunityDetail(String id) => '/opportunities/$id';

  // Events endpoints
  static const String events = '/events';
  static String eventDetail(String id) => '/events/$id';

  // Event RSVPs
  static const String eventRsvps = '/event-rsvps';
  static String eventRsvpDetail(String id) => '/event-rsvps/$id';

  // Community endpoints
  static const String posts = '/community-posts';
  static String postDetail(String id) => '/community-posts/$id';

  // Profiles endpoints
  static const String profiles = '/profiles';
  static String profileDetail(String id) => '/profiles/$id';

  // Subscription endpoints
  static const String subscriptions = '/subscriptions';
  static String subscriptionDetail(String id) => '/subscriptions/$id';

  // Bookmarks endpoints
  static const String bookmarks = '/bookmarks';
  static String bookmarkDetail(String id) => '/bookmarks/$id';

  // Media endpoints
  static const String media = '/media';
  static String mediaDetail(String id) => '/media/$id';
}

/// Query parameter keys for pagination and filtering.
/// Follows Payload CMS query syntax.
abstract final class ApiQueryParams {
  // Pagination (Payload uses 'page' and 'limit')
  static const String page = 'page';
  static const String limit = 'limit';
  static const String sort = 'sort';

  // Payload where query syntax
  // Example: where[field][operator]=value
  // Operators: equals, not_equals, greater_than, less_than, contains, like, in, etc.
  static String where(String field, String operator, String value) =>
      'where[$field][$operator]=$value';

  // Common filter fields
  static const String type = 'type';
  static const String category = 'category';
  static const String isFeatured = 'isFeatured';
  static const String verified = 'verified';

  // Depth for populating relationships
  static const String depth = 'depth';
}
