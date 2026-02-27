// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PropertyDtoImpl _$$PropertyDtoImplFromJson(Map<String, dynamic> json) =>
    _$PropertyDtoImpl(
      id: json['id'],
      title: json['title'] as String,
      type: json['category'] as String? ?? 'house',
      status: json['listingType'] as String? ?? 'sale',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      currency: json['currency'] as String? ?? 'RWF',
      location: json['location'] as String? ?? '',
      description: json['description'] as String? ?? '',
      agentPhone: json['contactPhone'] as String?,
      agentEmail: json['contactEmail'] as String?,
      images: json['images'] as List<dynamic>? ?? const [],
      size: (json['areaSqm'] as num?)?.toDouble(),
      bedrooms: (json['bedrooms'] as num?)?.toInt(),
      bathrooms: (json['bathrooms'] as num?)?.toInt(),
      isFeatured: json['isFeatured'] as bool? ?? false,
      isAvailable: json['isAvailable'] as bool? ?? true,
      createdAt: json['datePosted'] as String?,
    );

Map<String, dynamic> _$$PropertyDtoImplToJson(_$PropertyDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': instance.type,
      'listingType': instance.status,
      'price': instance.price,
      'currency': instance.currency,
      'location': instance.location,
      'description': instance.description,
      'contactPhone': instance.agentPhone,
      'contactEmail': instance.agentEmail,
      'images': instance.images,
      'areaSqm': instance.size,
      'bedrooms': instance.bedrooms,
      'bathrooms': instance.bathrooms,
      'isFeatured': instance.isFeatured,
      'isAvailable': instance.isAvailable,
      'datePosted': instance.createdAt,
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
