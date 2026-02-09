import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription.freezed.dart';

/// Domain entity representing a user's subscription.
@freezed
class Subscription with _$Subscription {
  const Subscription._();

  const factory Subscription({
    required SubscriptionPlan plan,
    required SubscriptionStatus status,
    DateTime? startDate,
    DateTime? endDate,
  }) = _Subscription;

  /// Check if subscription allows applying to opportunities.
  bool get canApply =>
      status == SubscriptionStatus.active &&
      plan != SubscriptionPlan.free;

  /// Check if subscription allows bookmarking.
  bool get canBookmark =>
      status == SubscriptionStatus.active &&
      plan != SubscriptionPlan.free;

  /// Check if subscription allows mentorship access.
  bool get canAccessMentorship =>
      status == SubscriptionStatus.active &&
      plan != SubscriptionPlan.free;

  /// Check if subscription has premium analytics.
  bool get hasPremiumAnalytics =>
      status == SubscriptionStatus.active &&
      (plan == SubscriptionPlan.monthly || plan == SubscriptionPlan.yearly);

  /// Check if subscription has priority support.
  bool get hasPrioritySupport =>
      status == SubscriptionStatus.active &&
      (plan == SubscriptionPlan.monthly || plan == SubscriptionPlan.yearly);

  /// Check if trial is expired.
  bool get isTrialExpired {
    if (plan != SubscriptionPlan.trial) return false;
    if (endDate == null) return false;
    return DateTime.now().isAfter(endDate!);
  }

  /// Get days remaining in trial.
  int? get trialDaysRemaining {
    if (plan != SubscriptionPlan.trial) return null;
    if (endDate == null) return null;
    final remaining = endDate!.difference(DateTime.now()).inDays;
    return remaining > 0 ? remaining : 0;
  }

  /// Get display name for the plan.
  String get planDisplayName {
    return switch (plan) {
      SubscriptionPlan.free => 'Free',
      SubscriptionPlan.trial => 'Trial',
      SubscriptionPlan.monthly => 'Monthly',
      SubscriptionPlan.yearly => 'Yearly',
    };
  }
}

/// Subscription plan types.
enum SubscriptionPlan {
  free('free'),
  trial('trial'),
  monthly('monthly'),
  yearly('yearly');

  const SubscriptionPlan(this.value);

  final String value;

  static SubscriptionPlan fromString(String value) {
    return SubscriptionPlan.values.firstWhere(
      (e) => e.value.toLowerCase() == value.toLowerCase(),
      orElse: () => SubscriptionPlan.free,
    );
  }
}

/// Subscription status.
enum SubscriptionStatus {
  active('active'),
  expired('expired'),
  canceled('canceled'),
  gracePeriod('grace_period');

  const SubscriptionStatus(this.value);

  final String value;

  static SubscriptionStatus fromString(String value) {
    return SubscriptionStatus.values.firstWhere(
      (e) => e.value.toLowerCase() == value.toLowerCase(),
      orElse: () => SubscriptionStatus.expired,
    );
  }
}
