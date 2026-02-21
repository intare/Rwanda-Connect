// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusinessDtoImpl _$$BusinessDtoImplFromJson(
  Map<String, dynamic> json,
) => _$BusinessDtoImpl(
  id: json['id'],
  name: json['name'] as String,
  slug: json['slug'] as String,
  category: json['category'] as String,
  description: json['description'] as String? ?? '',
  logo: json['logo'],
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  website: json['website'] as String?,
  address: json['address'] as String?,
  city: json['city'] as String?,
  district: json['district'] as String?,
  geo: json['geo'] == null
      ? null
      : GeoLocationDto.fromJson(json['geo'] as Map<String, dynamic>),
  socialLinks: json['socialLinks'] == null
      ? null
      : SocialLinksDto.fromJson(json['socialLinks'] as Map<String, dynamic>),
  businessHours:
      (json['businessHours'] as List<dynamic>?)
          ?.map((e) => BusinessHoursDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  services:
      (json['services'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  isFeatured: json['isFeatured'] as bool? ?? false,
  viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$$BusinessDtoImplToJson(_$BusinessDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'category': instance.category,
      'description': instance.description,
      'logo': instance.logo,
      'phone': instance.phone,
      'email': instance.email,
      'website': instance.website,
      'address': instance.address,
      'city': instance.city,
      'district': instance.district,
      'geo': instance.geo,
      'socialLinks': instance.socialLinks,
      'businessHours': instance.businessHours,
      'services': instance.services,
      'tags': instance.tags,
      'isFeatured': instance.isFeatured,
      'viewCount': instance.viewCount,
      'createdAt': instance.createdAt,
    };

_$GeoLocationDtoImpl _$$GeoLocationDtoImplFromJson(Map<String, dynamic> json) =>
    _$GeoLocationDtoImpl(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$GeoLocationDtoImplToJson(
  _$GeoLocationDtoImpl instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};

_$SocialLinksDtoImpl _$$SocialLinksDtoImplFromJson(Map<String, dynamic> json) =>
    _$SocialLinksDtoImpl(
      facebook: json['facebook'] as String?,
      twitter: json['twitter'] as String?,
      instagram: json['instagram'] as String?,
      linkedin: json['linkedin'] as String?,
    );

Map<String, dynamic> _$$SocialLinksDtoImplToJson(
  _$SocialLinksDtoImpl instance,
) => <String, dynamic>{
  'facebook': instance.facebook,
  'twitter': instance.twitter,
  'instagram': instance.instagram,
  'linkedin': instance.linkedin,
};

_$BusinessHoursDtoImpl _$$BusinessHoursDtoImplFromJson(
  Map<String, dynamic> json,
) => _$BusinessHoursDtoImpl(
  day: json['day'] as String,
  open: json['open'] as String?,
  close: json['close'] as String?,
  isClosed: json['isClosed'] as bool? ?? false,
);

Map<String, dynamic> _$$BusinessHoursDtoImplToJson(
  _$BusinessHoursDtoImpl instance,
) => <String, dynamic>{
  'day': instance.day,
  'open': instance.open,
  'close': instance.close,
  'isClosed': instance.isClosed,
};

_$BusinessesListResponseImpl _$$BusinessesListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$BusinessesListResponseImpl(
  docs: (json['docs'] as List<dynamic>)
      .map((e) => BusinessDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalDocs: (json['totalDocs'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  hasNextPage: json['hasNextPage'] as bool,
  hasPrevPage: json['hasPrevPage'] as bool,
);

Map<String, dynamic> _$$BusinessesListResponseImplToJson(
  _$BusinessesListResponseImpl instance,
) => <String, dynamic>{
  'docs': instance.docs,
  'totalDocs': instance.totalDocs,
  'limit': instance.limit,
  'page': instance.page,
  'totalPages': instance.totalPages,
  'hasNextPage': instance.hasNextPage,
  'hasPrevPage': instance.hasPrevPage,
};
