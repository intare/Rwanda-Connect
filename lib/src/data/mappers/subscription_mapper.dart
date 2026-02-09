import '../../domain/entities/subscription.dart';
import '../../domain/entities/subscription_entitlements.dart';
import '../models/subscription/subscription_dto.dart';
import '../models/subscription/subscription_entitlements_dto.dart';

/// Extension to convert SubscriptionDto to Subscription entity.
extension SubscriptionDtoMapper on SubscriptionDto {
  Subscription toEntity() {
    return Subscription(
      plan: SubscriptionPlan.fromString(plan),
      status: SubscriptionStatus.fromString(status),
      startDate: startDate != null ? DateTime.tryParse(startDate!) : null,
      endDate: endDate != null ? DateTime.tryParse(endDate!) : null,
    );
  }
}

/// Extension to convert SubscriptionEntitlementsDto to SubscriptionEntitlements entity.
extension SubscriptionEntitlementsDtoMapper on SubscriptionEntitlementsDto {
  SubscriptionEntitlements toEntity() {
    // Map DTO booleans to the features map expected by the entity
    final features = <String, bool>{
      'apply_opportunities': canApply,
      'save_bookmarks': canBookmark,
      'mentorship_access': canAccessMentorship,
      'create_posts': canCreatePosts,
      'rsvp_events': canRsvpEvents,
      'premium_analytics': false, // Not in DTO, default to false
      'priority_support': false, // Not in DTO, default to false
    };

    final limits = <String, int?>{
      'max_bookmarks': maxBookmarks,
    };

    // Determine plan based on entitlements
    final plan = isTrialAvailable
        ? SubscriptionPlan.free
        : (trialDaysRemaining != null && trialDaysRemaining! > 0
            ? SubscriptionPlan.trial
            : (canApply ? SubscriptionPlan.monthly : SubscriptionPlan.free));

    // Determine status based on entitlements
    final status = canApply ? SubscriptionStatus.active : SubscriptionStatus.expired;

    return SubscriptionEntitlements(
      plan: plan,
      status: status,
      features: features,
      limits: limits,
      trialEndsAt: trialDaysRemaining != null
          ? DateTime.now().add(Duration(days: trialDaysRemaining!))
          : null,
    );
  }
}
