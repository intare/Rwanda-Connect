import 'subscription.dart';

/// Domain entity representing subscription entitlements and limits.
class SubscriptionEntitlements {
  const SubscriptionEntitlements({
    required this.plan,
    required this.status,
    required this.features,
    required this.limits,
    this.trialEndsAt,
    this.endDate,
  });

  final SubscriptionPlan plan;
  final SubscriptionStatus status;
  final DateTime? trialEndsAt;
  final DateTime? endDate;
  final Map<String, bool> features;
  final Map<String, int?> limits;

  bool get canApply => features['apply_opportunities'] ?? false;
  bool get canBookmark => features['save_bookmarks'] ?? false;
  bool get canAccessMentorship => features['mentorship_access'] ?? false;
  bool get hasPremiumAnalytics => features['premium_analytics'] ?? false;
  bool get hasPrioritySupport => features['priority_support'] ?? false;
}
