// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewsDtoImpl _$$NewsDtoImplFromJson(Map<String, dynamic> json) =>
    _$NewsDtoImpl(
      id: json['id'],
      title: json['title'] as String,
      source: json['source'] as String,
      category: json['category'] as String,
      summary: json['summary'] as String,
      url: json['url'] as String,
      publishDate: json['publishDate'] as String?,
      image: json['image'],
      tags: json['tags'] as List<dynamic>?,
      isFeatured: json['isFeatured'] as bool?,
      content: json['content'],
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$$NewsDtoImplToJson(_$NewsDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'source': instance.source,
      'category': instance.category,
      'summary': instance.summary,
      'url': instance.url,
      'publishDate': instance.publishDate,
      'image': instance.image,
      'tags': instance.tags,
      'isFeatured': instance.isFeatured,
      'content': instance.content,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
