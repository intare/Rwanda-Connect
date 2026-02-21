// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationPreferencesImpl _$$NotificationPreferencesImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationPreferencesImpl(
  pushEnabled: json['pushEnabled'] as bool? ?? true,
  emailEnabled: json['emailEnabled'] as bool? ?? true,
  opportunityAlerts: json['opportunityAlerts'] as bool? ?? true,
  eventReminders: json['eventReminders'] as bool? ?? true,
  communityUpdates: json['communityUpdates'] as bool? ?? true,
  subscriptionAlerts: json['subscriptionAlerts'] as bool? ?? true,
);

Map<String, dynamic> _$$NotificationPreferencesImplToJson(
  _$NotificationPreferencesImpl instance,
) => <String, dynamic>{
  'pushEnabled': instance.pushEnabled,
  'emailEnabled': instance.emailEnabled,
  'opportunityAlerts': instance.opportunityAlerts,
  'eventReminders': instance.eventReminders,
  'communityUpdates': instance.communityUpdates,
  'subscriptionAlerts': instance.subscriptionAlerts,
};
