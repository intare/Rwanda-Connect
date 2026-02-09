import 'package:json_annotation/json_annotation.dart';

part 'subscription_dto.g.dart';

/// Data transfer object for Subscription from Payload CMS API.
@JsonSerializable()
class SubscriptionDto {
  const SubscriptionDto({
    required this.id,
    required this.plan,
    required this.status,
    this.user,
    this.billingProvider,
    this.externalSubscriptionId,
    this.startDate,
    this.endDate,
    this.trialEndsAt,
    this.createdAt,
    this.updatedAt,
  });

  final dynamic id; // Can be int or String from Payload
  final String plan;
  final String status;
  final dynamic user; // Can be object or ID
  final String? billingProvider;
  final String? externalSubscriptionId;
  final String? startDate;
  final String? endDate;
  final String? trialEndsAt;
  final String? createdAt;
  final String? updatedAt;

  String get idString => id.toString();

  DateTime? get trialEndsAtDateTime {
    if (trialEndsAt == null) return null;
    return DateTime.tryParse(trialEndsAt!);
  }

  DateTime? get endDateTime {
    if (endDate == null) return null;
    return DateTime.tryParse(endDate!);
  }

  bool get isActive => status == 'active';
  bool get isTrial => plan == 'trial';
  bool get isPaid => plan == 'monthly' || plan == 'yearly';

  factory SubscriptionDto.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionDtoToJson(this);
}

/// Response from billing portal API.
@JsonSerializable()
class BillingPortalResponse {
  const BillingPortalResponse({required this.url});

  final String url;

  factory BillingPortalResponse.fromJson(Map<String, dynamic> json) =>
      _$BillingPortalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BillingPortalResponseToJson(this);
}
