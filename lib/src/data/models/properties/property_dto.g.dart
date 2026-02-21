// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PropertyDtoImpl _$$PropertyDtoImplFromJson(Map<String, dynamic> json) =>
    _$PropertyDtoImpl(
      id: json['id'],
      title: json['title'] as String,
      type: json['type'] as String,
      status: json['status'] as String? ?? 'available',
      price: (json['price'] as num).toDouble(),
      location: json['location'] as String,
      description: json['description'] as String? ?? '',
      agentId: json['agentId'] as String?,
      agentName: json['agentName'] as String?,
      agentPhone: json['agentPhone'] as String?,
      agentEmail: json['agentEmail'] as String?,
      images: json['images'] as List<dynamic>? ?? const [],
      amenities:
          (json['amenities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      size: (json['size'] as num?)?.toDouble(),
      bedrooms: (json['bedrooms'] as num?)?.toInt(),
      bathrooms: (json['bathrooms'] as num?)?.toInt(),
      yearBuilt: (json['yearBuilt'] as num?)?.toInt(),
      isFeatured: json['isFeatured'] as bool? ?? false,
      createdAt: json['createdAt'] as String?,
      bidCount: (json['bidCount'] as num?)?.toInt(),
      highestBid: (json['highestBid'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$PropertyDtoImplToJson(_$PropertyDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': instance.type,
      'status': instance.status,
      'price': instance.price,
      'location': instance.location,
      'description': instance.description,
      'agentId': instance.agentId,
      'agentName': instance.agentName,
      'agentPhone': instance.agentPhone,
      'agentEmail': instance.agentEmail,
      'images': instance.images,
      'amenities': instance.amenities,
      'size': instance.size,
      'bedrooms': instance.bedrooms,
      'bathrooms': instance.bathrooms,
      'yearBuilt': instance.yearBuilt,
      'isFeatured': instance.isFeatured,
      'createdAt': instance.createdAt,
      'bidCount': instance.bidCount,
      'highestBid': instance.highestBid,
    };

_$PropertiesListResponseImpl _$$PropertiesListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$PropertiesListResponseImpl(
  docs: (json['docs'] as List<dynamic>)
      .map((e) => PropertyDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalDocs: (json['totalDocs'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  hasNextPage: json['hasNextPage'] as bool,
  hasPrevPage: json['hasPrevPage'] as bool,
);

Map<String, dynamic> _$$PropertiesListResponseImplToJson(
  _$PropertiesListResponseImpl instance,
) => <String, dynamic>{
  'docs': instance.docs,
  'totalDocs': instance.totalDocs,
  'limit': instance.limit,
  'page': instance.page,
  'totalPages': instance.totalPages,
  'hasNextPage': instance.hasNextPage,
  'hasPrevPage': instance.hasPrevPage,
};
