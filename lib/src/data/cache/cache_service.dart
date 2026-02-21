import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Cache entry with metadata.
class CacheEntry {
  CacheEntry({
    required this.data,
    required this.cachedAt,
    required this.expiresAt,
  });

  factory CacheEntry.fromJson(Map<String, dynamic> json) {
    return CacheEntry(
      data: json['data'],
      cachedAt: DateTime.parse(json['cachedAt'] as String),
      expiresAt: DateTime.parse(json['expiresAt'] as String),
    );
  }

  final dynamic data;
  final DateTime cachedAt;
  final DateTime expiresAt;

  bool get isExpired => DateTime.now().isAfter(expiresAt);
  bool get isValid => !isExpired;

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'cachedAt': cachedAt.toIso8601String(),
      'expiresAt': expiresAt.toIso8601String(),
    };
  }
}

/// Cache durations for different data types.
class CacheDuration {
  static const news = Duration(hours: 4);
  static const featuredNews = Duration(hours: 2);
  static const opportunities = Duration(hours: 6);
  static const events = Duration(hours: 4);
  static const posts = Duration(hours: 1);
  static const userRsvps = Duration(minutes: 15);
  static const bookmarks = Duration(minutes: 30);
}

/// Service for managing local cache using Hive.
class CacheService {
  static const _newsBox = 'news_cache';
  static const _opportunitiesBox = 'opportunities_cache';
  static const _eventsBox = 'events_cache';
  static const _postsBox = 'posts_cache';
  static const _metadataBox = 'cache_metadata';

  bool _isInitialized = false;

  /// Initialize Hive and open boxes.
  Future<void> initialize() async {
    if (_isInitialized) return;

    await Hive.initFlutter();

    await Future.wait([
      Hive.openBox<String>(_newsBox),
      Hive.openBox<String>(_opportunitiesBox),
      Hive.openBox<String>(_eventsBox),
      Hive.openBox<String>(_postsBox),
      Hive.openBox<String>(_metadataBox),
    ]);

    _isInitialized = true;
  }

  // ==================== Generic Cache Operations ====================

  /// Get cached data by key.
  Future<CacheEntry?> get(String boxName, String key) async {
    final box = Hive.box<String>(boxName);
    final json = box.get(key);
    if (json == null) return null;

    try {
      final map = jsonDecode(json) as Map<String, dynamic>;
      final entry = CacheEntry.fromJson(map);

      // Return null if expired
      if (entry.isExpired) {
        await box.delete(key);
        return null;
      }

      return entry;
    } catch (_) {
      await box.delete(key);
      return null;
    }
  }

  /// Save data to cache.
  Future<void> put(
    String boxName,
    String key,
    dynamic data,
    Duration ttl,
  ) async {
    final box = Hive.box<String>(boxName);
    final now = DateTime.now();
    final entry = CacheEntry(
      data: data,
      cachedAt: now,
      expiresAt: now.add(ttl),
    );
    await box.put(key, jsonEncode(entry.toJson()));
  }

  /// Delete cached data.
  Future<void> delete(String boxName, String key) async {
    final box = Hive.box<String>(boxName);
    await box.delete(key);
  }

  /// Clear all data in a box.
  Future<void> clearBox(String boxName) async {
    final box = Hive.box<String>(boxName);
    await box.clear();
  }

  /// Clear all cache.
  Future<void> clearAll() async {
    await Future.wait([
      clearBox(_newsBox),
      clearBox(_opportunitiesBox),
      clearBox(_eventsBox),
      clearBox(_postsBox),
      clearBox(_metadataBox),
    ]);
  }

  // ==================== News Cache ====================

  /// Cache key for news list.
  String _newsListKey(String? category, String? search, int page) {
    return 'news_${category ?? 'all'}_${search ?? ''}_$page';
  }

  /// Get cached news list.
  Future<List<Map<String, dynamic>>?> getNewsList({
    String? category,
    String? search,
    int page = 1,
  }) async {
    final entry = await get(_newsBox, _newsListKey(category, search, page));
    if (entry == null) return null;

    return (entry.data as List).cast<Map<String, dynamic>>();
  }

  /// Cache news list.
  Future<void> cacheNewsList(
    List<Map<String, dynamic>> news, {
    String? category,
    String? search,
    int page = 1,
  }) async {
    await put(
      _newsBox,
      _newsListKey(category, search, page),
      news,
      CacheDuration.news,
    );
  }

  /// Get cached featured news.
  Future<List<Map<String, dynamic>>?> getFeaturedNews() async {
    final entry = await get(_newsBox, 'featured');
    if (entry == null) return null;

    return (entry.data as List).cast<Map<String, dynamic>>();
  }

  /// Cache featured news.
  Future<void> cacheFeaturedNews(List<Map<String, dynamic>> news) async {
    await put(_newsBox, 'featured', news, CacheDuration.featuredNews);
  }

  /// Get cached news by ID.
  Future<Map<String, dynamic>?> getNewsById(String id) async {
    final entry = await get(_newsBox, 'detail_$id');
    if (entry == null) return null;

    return entry.data as Map<String, dynamic>;
  }

  /// Cache news detail.
  Future<void> cacheNewsDetail(String id, Map<String, dynamic> news) async {
    await put(_newsBox, 'detail_$id', news, CacheDuration.news);
  }

  // ==================== Opportunities Cache ====================

  /// Cache key for opportunities list.
  String _opportunitiesKey(String? type, String? location, String? search, int page) {
    return 'opps_${type ?? 'all'}_${location ?? 'all'}_${search ?? ''}_$page';
  }

  /// Get cached opportunities.
  Future<List<Map<String, dynamic>>?> getOpportunities({
    String? type,
    String? location,
    String? search,
    int page = 1,
  }) async {
    final entry = await get(
      _opportunitiesBox,
      _opportunitiesKey(type, location, search, page),
    );
    if (entry == null) return null;

    return (entry.data as List).cast<Map<String, dynamic>>();
  }

  /// Cache opportunities.
  Future<void> cacheOpportunities(
    List<Map<String, dynamic>> opportunities, {
    String? type,
    String? location,
    String? search,
    int page = 1,
  }) async {
    await put(
      _opportunitiesBox,
      _opportunitiesKey(type, location, search, page),
      opportunities,
      CacheDuration.opportunities,
    );
  }

  /// Get cached opportunity by ID.
  Future<Map<String, dynamic>?> getOpportunityById(String id) async {
    final entry = await get(_opportunitiesBox, 'detail_$id');
    if (entry == null) return null;

    return entry.data as Map<String, dynamic>;
  }

  /// Cache opportunity detail.
  Future<void> cacheOpportunityDetail(
    String id,
    Map<String, dynamic> opportunity,
  ) async {
    await put(
      _opportunitiesBox,
      'detail_$id',
      opportunity,
      CacheDuration.opportunities,
    );
  }

  // ==================== Events Cache ====================

  /// Cache key for events list.
  String _eventsKey(String? type, String? search, int page) {
    return 'events_${type ?? 'all'}_${search ?? ''}_$page';
  }

  /// Get cached events.
  Future<List<Map<String, dynamic>>?> getEvents({
    String? type,
    String? search,
    int page = 1,
  }) async {
    final entry = await get(_eventsBox, _eventsKey(type, search, page));
    if (entry == null) return null;

    return (entry.data as List).cast<Map<String, dynamic>>();
  }

  /// Cache events.
  Future<void> cacheEvents(
    List<Map<String, dynamic>> events, {
    String? type,
    String? search,
    int page = 1,
  }) async {
    await put(
      _eventsBox,
      _eventsKey(type, search, page),
      events,
      CacheDuration.events,
    );
  }

  /// Get cached event by ID.
  Future<Map<String, dynamic>?> getEventById(String id) async {
    final entry = await get(_eventsBox, 'detail_$id');
    if (entry == null) return null;

    return entry.data as Map<String, dynamic>;
  }

  /// Cache event detail.
  Future<void> cacheEventDetail(String id, Map<String, dynamic> event) async {
    await put(_eventsBox, 'detail_$id', event, CacheDuration.events);
  }

  // ==================== Posts Cache ====================

  /// Cache key for posts list.
  String _postsKey(String? search, int page) {
    return 'posts_${search ?? ''}_$page';
  }

  /// Get cached posts.
  Future<List<Map<String, dynamic>>?> getPosts({
    String? search,
    int page = 1,
  }) async {
    final entry = await get(_postsBox, _postsKey(search, page));
    if (entry == null) return null;

    return (entry.data as List).cast<Map<String, dynamic>>();
  }

  /// Cache posts.
  Future<void> cachePosts(
    List<Map<String, dynamic>> posts, {
    String? search,
    int page = 1,
  }) async {
    await put(_postsBox, _postsKey(search, page), posts, CacheDuration.posts);
  }

  // ==================== Cache Metadata ====================

  /// Get last sync time for a data type.
  Future<DateTime?> getLastSyncTime(String dataType) async {
    final entry = await get(_metadataBox, 'lastSync_$dataType');
    if (entry == null) return null;

    return DateTime.parse(entry.data as String);
  }

  /// Set last sync time.
  Future<void> setLastSyncTime(String dataType) async {
    await put(
      _metadataBox,
      'lastSync_$dataType',
      DateTime.now().toIso8601String(),
      const Duration(days: 30), // Metadata doesn't expire
    );
  }

  /// Get cache size info.
  Future<Map<String, int>> getCacheInfo() async {
    return {
      'news': Hive.box<String>(_newsBox).length,
      'opportunities': Hive.box<String>(_opportunitiesBox).length,
      'events': Hive.box<String>(_eventsBox).length,
      'posts': Hive.box<String>(_postsBox).length,
    };
  }
}

/// Provider for CacheService.
final cacheServiceProvider = Provider<CacheService>((ref) {
  return CacheService();
});
