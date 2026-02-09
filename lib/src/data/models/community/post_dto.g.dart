// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDto _$PostDtoFromJson(Map<String, dynamic> json) => PostDto(
  id: json['id'],
  content: json['content'] as String,
  author: json['author'],
  isPinned: json['isPinned'] as bool?,
  likesCount: (json['likesCount'] as num?)?.toInt(),
  commentsCount: (json['commentsCount'] as num?)?.toInt(),
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$PostDtoToJson(PostDto instance) => <String, dynamic>{
  'id': instance.id,
  'content': instance.content,
  'author': instance.author,
  'isPinned': instance.isPinned,
  'likesCount': instance.likesCount,
  'commentsCount': instance.commentsCount,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};

CreatePostRequest _$CreatePostRequestFromJson(Map<String, dynamic> json) =>
    CreatePostRequest(content: json['content'] as String);

Map<String, dynamic> _$CreatePostRequestToJson(CreatePostRequest instance) =>
    <String, dynamic>{'content': instance.content};
