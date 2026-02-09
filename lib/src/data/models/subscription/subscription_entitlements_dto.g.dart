// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_entitlements_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionEntitlementsDto _$SubscriptionEntitlementsDtoFromJson(
  Map<String, dynamic> json,
) => SubscriptionEntitlementsDto(
  canApply: json['canApply'] as bool? ?? false,
  canBookmark: json['canBookmark'] as bool? ?? false,
  canAccessMentorship: json['canAccessMentorship'] as bool? ?? false,
  canCreatePosts: json['canCreatePosts'] as bool? ?? true,
  canRsvpEvents: json['canRsvpEvents'] as bool? ?? true,
  maxBookmarks: (json['maxBookmarks'] as num?)?.toInt() ?? 0,
  isTrialAvailable: json['isTrialAvailable'] as bool? ?? true,
  trialDaysRemaining: (json['trialDaysRemaining'] as num?)?.toInt(),
);

Map<String, dynamic> _$SubscriptionEntitlementsDtoToJson(
  SubscriptionEntitlementsDto instance,
) => <String, dynamic>{
  'canApply': instance.canApply,
  'canBookmark': instance.canBookmark,
  'canAccessMentorship': instance.canAccessMentorship,
  'canCreatePosts': instance.canCreatePosts,
  'canRsvpEvents': instance.canRsvpEvents,
  'maxBookmarks': instance.maxBookmarks,
  'isTrialAvailable': instance.isTrialAvailable,
  'trialDaysRemaining': instance.trialDaysRemaining,
};
