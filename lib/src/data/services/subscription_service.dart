import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../models/subscription/subscription_dto.dart';
import '../models/subscription/subscription_entitlements_dto.dart';

/// Service for making subscription-related API calls using Payload CMS.
class SubscriptionService {
  SubscriptionService(this._dio, this._secureStorage);

  final Dio _dio;
  final FlutterSecureStorage _secureStorage;

  static const _tokenKey = 'auth_token';
  static const _userIdKey = 'user_id';

  /// Get current user's subscription status.
  Future<SubscriptionDto?> getSubscription() async {
    final token = await _secureStorage.read(key: _tokenKey);
    final userId = await _secureStorage.read(key: _userIdKey);

    if (token == null || userId == null) {
      return null;
    }

    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.subscriptions,
        queryParameters: {
          'where[user][equals]': userId,
          'limit': 1,
        },
        options: Options(
          headers: {'Authorization': 'JWT $token'},
        ),
      );

      final docs = response.data?['docs'] as List<dynamic>?;
      if (docs != null && docs.isNotEmpty) {
        return SubscriptionDto.fromJson(docs.first as Map<String, dynamic>);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Get subscription entitlements based on current plan.
  Future<SubscriptionEntitlementsDto> getEntitlements() async {
    final subscription = await getSubscription();

    // Return entitlements based on plan
    if (subscription == null) {
      return _getFreeEntitlements();
    }

    switch (subscription.plan) {
      case 'trial':
        return _getTrialEntitlements(subscription.trialEndsAtDateTime);
      case 'monthly':
      case 'yearly':
        return _getPaidEntitlements();
      default:
        return _getFreeEntitlements();
    }
  }

  /// Activate a trial subscription.
  Future<SubscriptionDto> activateTrial() async {
    final token = await _secureStorage.read(key: _tokenKey);
    final userId = await _secureStorage.read(key: _userIdKey);

    if (token == null || userId == null) {
      throw Exception('Not authenticated');
    }

    // Check if user already has a subscription
    final existing = await getSubscription();

    final trialEndsAt = DateTime.now().add(const Duration(days: 14));

    if (existing != null) {
      // Update existing subscription to trial
      final response = await _dio.patch<Map<String, dynamic>>(
        ApiEndpoints.subscriptionDetail(existing.id),
        data: {
          'plan': 'trial',
          'status': 'active',
          'trialEndsAt': trialEndsAt.toIso8601String(),
          'endDate': trialEndsAt.toIso8601String(),
        },
        options: Options(
          headers: {'Authorization': 'JWT $token'},
        ),
      );

      return SubscriptionDto.fromJson(response.data!);
    } else {
      // Create new trial subscription
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.subscriptions,
        data: {
          'user': userId,
          'plan': 'trial',
          'status': 'active',
          'trialEndsAt': trialEndsAt.toIso8601String(),
          'endDate': trialEndsAt.toIso8601String(),
        },
        options: Options(
          headers: {'Authorization': 'JWT $token'},
        ),
      );

      return SubscriptionDto.fromJson(response.data!);
    }
  }

  /// Free plan entitlements.
  SubscriptionEntitlementsDto _getFreeEntitlements() {
    return const SubscriptionEntitlementsDto(
      canApply: false,
      canBookmark: false,
      canAccessMentorship: false,
      canCreatePosts: true,
      canRsvpEvents: true,
      maxBookmarks: 0,
      isTrialAvailable: true,
    );
  }

  /// Trial plan entitlements.
  SubscriptionEntitlementsDto _getTrialEntitlements(DateTime? trialEndsAt) {
    final daysRemaining = trialEndsAt != null
        ? trialEndsAt.difference(DateTime.now()).inDays
        : 0;

    return SubscriptionEntitlementsDto(
      canApply: daysRemaining > 0,
      canBookmark: daysRemaining > 0,
      canAccessMentorship: daysRemaining > 0,
      canCreatePosts: true,
      canRsvpEvents: true,
      maxBookmarks: 50,
      isTrialAvailable: false,
      trialDaysRemaining: daysRemaining > 0 ? daysRemaining : null,
    );
  }

  /// Paid plan entitlements.
  SubscriptionEntitlementsDto _getPaidEntitlements() {
    return const SubscriptionEntitlementsDto(
      canApply: true,
      canBookmark: true,
      canAccessMentorship: true,
      canCreatePosts: true,
      canRsvpEvents: true,
      maxBookmarks: -1, // Unlimited
      isTrialAvailable: false,
    );
  }
}

/// Provider for SubscriptionService.
final subscriptionServiceProvider = Provider<SubscriptionService>((ref) {
  final dio = ref.watch(dioProvider);
  final secureStorage = ref.watch(secureStorageProvider);
  return SubscriptionService(dio, secureStorage);
});
