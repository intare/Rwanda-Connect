import '../config/env_config.dart';

/// API endpoint constants for Rwanda Connect.
/// Configured for Payload CMS backend.
abstract final class ApiEndpoints {
  // Base URL configured in EnvConfig.
  static String get baseUrl => EnvConfig.apiBaseUrl;

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
  static const String forgotPassword = '/users/forgot-password';
  static const String resetPassword = '/users/reset-password';
  static String verifyEmail(String token) => '/users/verify/$token';
  static const String resendVerification = '/users/resend-verification';
  static const String googleAuth = '/users/oauth/google';
  static const String appleAuth = '/users/oauth/apple';

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

  // Comments endpoints
  static const String comments = '/post-comments';
  static String commentDetail(String id) => '/post-comments/$id';

  // Profiles endpoints
  static const String profiles = '/profiles';
  static String profileDetail(String id) => '/profiles/$id';

  // Subscription endpoints
  static const String subscriptions = '/subscriptions';
  static String subscriptionDetail(String id) => '/subscriptions/$id';

  // Bookmarks endpoints
  static const String bookmarks = '/bookmarks';
  static String bookmarkDetail(String id) => '/bookmarks/$id';

  // Properties endpoints
  static const String properties = '/properties';
  static String propertyDetail(String id) => '/properties/$id';
  static String propertyBids(String id) => '/properties/$id/bids';

  // Bids endpoints
  static const String bids = '/bids';
  static String bidDetail(String id) => '/bids/$id';
  static const String userBids = '/bids/me';

  // Media endpoints
  static const String media = '/media';
  static String mediaDetail(String id) => '/media/$id';

  // Playbook endpoints
  static const String playbookContent = '/playbook-content';
  static String playbookContentDetail(String id) => '/playbook-content/$id';
  static const String playbookCategories = '/playbook-categories';
  static String playbookCategoryDetail(String id) => '/playbook-categories/$id';
  static const String playbookLikes = '/playbook-likes';
  static String playbookLikeDetail(String id) => '/playbook-likes/$id';
  static const String playbookViews = '/playbook-views';

  // Business Directory endpoints
  static const String businessDirectory = '/business-directory';
  static String businessDetail(String id) => '/business-directory/$id';

  // Mentorship endpoints
  static const String mentors = '/mentors';
  static String mentorDetail(String id) => '/mentors/$id';
  static const String myMentorProfile = '/mentors/me';
  static const String mentorshipRequests = '/mentorship-requests';
  static String mentorshipRequestDetail(String id) =>
      '/mentorship-requests/$id';
  static String mentorshipRequestAction(String id, String action) =>
      '/mentorship-requests/$id/$action';
  static const String mentorshipConnections = '/mentorship-connections';
  static String mentorshipConnectionDetail(String id) =>
      '/mentorship-connections/$id';
  static const String mentorshipQuota = '/mentorship/quota';
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
