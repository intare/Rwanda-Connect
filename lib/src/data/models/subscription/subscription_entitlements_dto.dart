import 'package:json_annotation/json_annotation.dart';

part 'subscription_entitlements_dto.g.dart';

/// Data transfer object for subscription entitlements.
/// This is computed based on the subscription plan, not from API.
@JsonSerializable()
class SubscriptionEntitlementsDto {
  const SubscriptionEntitlementsDto({
    this.canApply = false,
    this.canBookmark = false,
    this.canAccessMentorship = false,
    this.canCreatePosts = true,
    this.canRsvpEvents = true,
    this.maxBookmarks = 0,
    this.isTrialAvailable = true,
    this.trialDaysRemaining,
  });

  final bool canApply;
  final bool canBookmark;
  final bool canAccessMentorship;
  final bool canCreatePosts;
  final bool canRsvpEvents;
  final int maxBookmarks;
  final bool isTrialAvailable;
  final int? trialDaysRemaining;

  bool get hasUnlimitedBookmarks => maxBookmarks < 0;

  factory SubscriptionEntitlementsDto.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionEntitlementsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionEntitlementsDtoToJson(this);
}
