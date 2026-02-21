// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bid_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BidDtoImpl _$$BidDtoImplFromJson(Map<String, dynamic> json) => _$BidDtoImpl(
  id: json['id'],
  propertyId: json['propertyId'] as String,
  userId: json['userId'] as String,
  amount: (json['amount'] as num).toDouble(),
  status: json['status'] as String? ?? 'pending',
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String?,
  propertyTitle: json['propertyTitle'] as String?,
  propertyImage: json['propertyImage'] as String?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$$BidDtoImplToJson(_$BidDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'propertyId': instance.propertyId,
      'userId': instance.userId,
      'amount': instance.amount,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'propertyTitle': instance.propertyTitle,
      'propertyImage': instance.propertyImage,
      'message': instance.message,
    };

_$BidsListResponseImpl _$$BidsListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$BidsListResponseImpl(
  docs: (json['docs'] as List<dynamic>)
      .map((e) => BidDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalDocs: (json['totalDocs'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  hasNextPage: json['hasNextPage'] as bool,
  hasPrevPage: json['hasPrevPage'] as bool,
);

Map<String, dynamic> _$$BidsListResponseImplToJson(
  _$BidsListResponseImpl instance,
) => <String, dynamic>{
  'docs': instance.docs,
  'totalDocs': instance.totalDocs,
  'limit': instance.limit,
  'page': instance.page,
  'totalPages': instance.totalPages,
  'hasNextPage': instance.hasNextPage,
  'hasPrevPage': instance.hasPrevPage,
};

_$PlaceBidRequestImpl _$$PlaceBidRequestImplFromJson(
  Map<String, dynamic> json,
) => _$PlaceBidRequestImpl(
  amount: (json['amount'] as num).toDouble(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$$PlaceBidRequestImplToJson(
  _$PlaceBidRequestImpl instance,
) => <String, dynamic>{'amount': instance.amount, 'message': instance.message};
