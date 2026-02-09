// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionDto _$SubscriptionDtoFromJson(Map<String, dynamic> json) =>
    SubscriptionDto(
      id: json['id'],
      plan: json['plan'] as String,
      status: json['status'] as String,
      user: json['user'],
      billingProvider: json['billingProvider'] as String?,
      externalSubscriptionId: json['externalSubscriptionId'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      trialEndsAt: json['trialEndsAt'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$SubscriptionDtoToJson(SubscriptionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'plan': instance.plan,
      'status': instance.status,
      'user': instance.user,
      'billingProvider': instance.billingProvider,
      'externalSubscriptionId': instance.externalSubscriptionId,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'trialEndsAt': instance.trialEndsAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

BillingPortalResponse _$BillingPortalResponseFromJson(
  Map<String, dynamic> json,
) => BillingPortalResponse(url: json['url'] as String);

Map<String, dynamic> _$BillingPortalResponseToJson(
  BillingPortalResponse instance,
) => <String, dynamic>{'url': instance.url};
