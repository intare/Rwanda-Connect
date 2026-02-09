import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/repositories/subscription_repository_impl.dart';
import '../../../../domain/entities/subscription.dart';
import '../../../../domain/entities/subscription_entitlements.dart';
import '../../../../domain/repositories/subscription_repository.dart';

/// State for subscription management.
class SubscriptionState {
  const SubscriptionState({
    this.subscription,
    this.entitlements,
    this.isLoading = false,
    this.isActivatingTrial = false,
    this.error,
  });

  final Subscription? subscription;
  final SubscriptionEntitlements? entitlements;
  final bool isLoading;
  final bool isActivatingTrial;
  final String? error;

  SubscriptionState copyWith({
    Subscription? subscription,
    SubscriptionEntitlements? entitlements,
    bool? isLoading,
    bool? isActivatingTrial,
    String? error,
    bool clearSubscription = false,
    bool clearEntitlements = false,
  }) {
    return SubscriptionState(
      subscription: clearSubscription ? null : (subscription ?? this.subscription),
      entitlements: clearEntitlements ? null : (entitlements ?? this.entitlements),
      isLoading: isLoading ?? this.isLoading,
      isActivatingTrial: isActivatingTrial ?? this.isActivatingTrial,
      error: error,
    );
  }

  /// Check if user can apply to opportunities.
  bool get canApply => entitlements?.canApply ?? subscription?.canApply ?? false;

  /// Check if user can bookmark items.
  bool get canBookmark =>
      entitlements?.canBookmark ?? subscription?.canBookmark ?? false;

  /// Check if user has a free plan.
  bool get isFree =>
      entitlements?.plan == SubscriptionPlan.free ||
      subscription?.plan == SubscriptionPlan.free;

  /// Check if user is on trial.
  bool get isTrial =>
      entitlements?.plan == SubscriptionPlan.trial ||
      subscription?.plan == SubscriptionPlan.trial;

  /// Check if user has a paid subscription.
  bool get isPaid =>
      entitlements?.plan == SubscriptionPlan.monthly ||
      entitlements?.plan == SubscriptionPlan.yearly ||
      subscription?.plan == SubscriptionPlan.monthly ||
      subscription?.plan == SubscriptionPlan.yearly;
}

/// Notifier for managing subscription state.
class SubscriptionNotifier extends StateNotifier<SubscriptionState> {
  SubscriptionNotifier(this._repository) : super(const SubscriptionState()) {
    loadSubscription();
  }

  final SubscriptionRepository _repository;

  /// Load current subscription status.
  Future<void> loadSubscription() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getSubscription();
    final entitlementsResult = await _repository.getEntitlements();

    SubscriptionEntitlements? entitlements = state.entitlements;
    switch (result) {
      case SubscriptionSuccess(:final data):
        state = state.copyWith(
          subscription: data,
          isLoading: false,
        );
      case SubscriptionFailure(:final message):
        state = state.copyWith(
          isLoading: false,
          error: message,
        );
    }

    switch (entitlementsResult) {
      case SubscriptionSuccess(:final data):
        entitlements = data;
      case SubscriptionFailure():
        break;
    }

    state = state.copyWith(
      entitlements: entitlements,
      isLoading: false,
    );
  }

  /// Activate a free trial.
  Future<bool> activateTrial() async {
    if (state.isActivatingTrial) return false;

    state = state.copyWith(isActivatingTrial: true, error: null);

    final result = await _repository.activateTrial();
    final entitlementsResult = await _repository.getEntitlements();

    Subscription? subscription = state.subscription;
    String? error;
    var success = false;

    switch (result) {
      case SubscriptionSuccess(:final data):
        subscription = data;
        success = true;
      case SubscriptionFailure(:final message):
        error = message;
    }

    SubscriptionEntitlements? entitlements = state.entitlements;
    switch (entitlementsResult) {
      case SubscriptionSuccess(:final data):
        entitlements = data;
      case SubscriptionFailure():
        break;
    }

    state = state.copyWith(
      subscription: subscription,
      entitlements: entitlements,
      isActivatingTrial: false,
      error: error,
    );

    return success;
  }

  /// Get billing portal URL.
  Future<String?> getBillingPortalUrl() async {
    final result = await _repository.getBillingPortalUrl();

    return switch (result) {
      SubscriptionSuccess(:final data) => data,
      SubscriptionFailure() => null,
    };
  }

  /// Refresh subscription status.
  Future<void> refresh() async {
    await loadSubscription();
  }

  /// Clear error state.
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Provider for SubscriptionNotifier.
final subscriptionProvider =
    StateNotifierProvider<SubscriptionNotifier, SubscriptionState>((ref) {
  final repository = ref.watch(subscriptionRepositoryProvider);
  return SubscriptionNotifier(repository);
});

/// Provider to check if user can apply to opportunities.
final canApplyProvider = Provider<bool>((ref) {
  final state = ref.watch(subscriptionProvider);
  return state.canApply;
});

/// Provider to check if user can bookmark items.
final canBookmarkProvider = Provider<bool>((ref) {
  final state = ref.watch(subscriptionProvider);
  return state.canBookmark;
});
