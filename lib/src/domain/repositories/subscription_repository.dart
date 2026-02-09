import '../entities/subscription.dart';
import '../entities/subscription_entitlements.dart';

/// Result type for subscription operations.
sealed class SubscriptionResult<T> {
  const SubscriptionResult();
}

class SubscriptionSuccess<T> extends SubscriptionResult<T> {
  const SubscriptionSuccess(this.data);
  final T data;
}

class SubscriptionFailure<T> extends SubscriptionResult<T> {
  const SubscriptionFailure(this.message);
  final String message;
}

/// Repository interface for subscription operations.
abstract class SubscriptionRepository {
  /// Get current subscription status.
  Future<SubscriptionResult<Subscription>> getSubscription();

  /// Activate a trial subscription.
  Future<SubscriptionResult<Subscription>> activateTrial();

  /// Get subscription entitlements.
  Future<SubscriptionResult<SubscriptionEntitlements>> getEntitlements();

  /// Get billing portal URL for managing subscription.
  Future<SubscriptionResult<String>> getBillingPortalUrl();
}
