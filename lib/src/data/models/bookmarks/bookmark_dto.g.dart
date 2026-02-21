// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookmarkDto _$BookmarkDtoFromJson(Map<String, dynamic> json) => BookmarkDto(
  id: json['id'],
  user: json['user'],
  type: json['entityType'] as String,
  itemId: json['entityId'] as String,
  opportunity: json['opportunity'] == null
      ? null
      : OpportunityDto.fromJson(json['opportunity'] as Map<String, dynamic>),
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$BookmarkDtoToJson(BookmarkDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'entityType': instance.type,
      'entityId': instance.itemId,
      'opportunity': instance.opportunity,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

Map<String, dynamic> _$CreateBookmarkRequestToJson(
  CreateBookmarkRequest instance,
) => <String, dynamic>{
  'entityType': instance.type,
  'entityId': instance.itemId,
};
