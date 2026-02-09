import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_interceptors.dart';
import '../../domain/entities/subscription.dart';
import '../../domain/entities/subscription_entitlements.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../mappers/subscription_mapper.dart';
import '../services/subscription_service.dart';

/// Implementation of SubscriptionRepository.
class SubscriptionRepositoryImpl implements SubscriptionRepository {
  SubscriptionRepositoryImpl(this._subscriptionService);

  final SubscriptionService _subscriptionService;

  @override
  Future<SubscriptionResult<Subscription>> getSubscription() async {
    try {
      final response = await _subscriptionService.getSubscription();
      if (response == null) {
        // Return a default free subscription if none exists
        return SubscriptionSuccess(
          Subscription(
            plan: SubscriptionPlan.free,
            status: SubscriptionStatus.expired,
          ),
        );
      }
      return SubscriptionSuccess(response.toEntity());
    } on DioException catch (e) {
      return SubscriptionFailure(_handleDioError(e));
    } catch (e) {
      return SubscriptionFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<SubscriptionResult<Subscription>> activateTrial() async {
    try {
      final response = await _subscriptionService.activateTrial();
      return SubscriptionSuccess(response.toEntity());
    } on DioException catch (e) {
      return SubscriptionFailure(_handleDioError(e));
    } catch (e) {
      return SubscriptionFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<SubscriptionResult<SubscriptionEntitlements>> getEntitlements() async {
    try {
      final response = await _subscriptionService.getEntitlements();
      return SubscriptionSuccess(response.toEntity());
    } on DioException catch (e) {
      return SubscriptionFailure(_handleDioError(e));
    } catch (e) {
      return SubscriptionFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<SubscriptionResult<String>> getBillingPortalUrl() async {
    // Billing portal is not yet implemented in the backend
    // This will be available when payment processing is set up
    return const SubscriptionFailure('Billing portal not yet available');
  }

  String _handleDioError(DioException e) {
    final error = e.error;
    if (error is ApiError) {
      return error.message;
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please try again.';
      case DioExceptionType.connectionError:
        return 'No internet connection.';
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        return 'Server error: $statusCode';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}

/// Provider for SubscriptionRepository.
final subscriptionRepositoryProvider = Provider<SubscriptionRepository>((ref) {
  final subscriptionService = ref.watch(subscriptionServiceProvider);
  return SubscriptionRepositoryImpl(subscriptionService);
});
