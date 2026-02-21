// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playbook_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlaybookCategoryDtoImpl _$$PlaybookCategoryDtoImplFromJson(
  Map<String, dynamic> json,
) => _$PlaybookCategoryDtoImpl(
  id: json['id'],
  name: json['name'] as String,
  description: json['description'] as String?,
  icon: json['icon'] as String?,
  contentCount: (json['contentCount'] as num?)?.toInt(),
);

Map<String, dynamic> _$$PlaybookCategoryDtoImplToJson(
  _$PlaybookCategoryDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'icon': instance.icon,
  'contentCount': instance.contentCount,
};

_$PlaybookAuthorDtoImpl _$$PlaybookAuthorDtoImplFromJson(
  Map<String, dynamic> json,
) => _$PlaybookAuthorDtoImpl(
  id: json['id'],
  name: json['name'] as String,
  title: json['title'] as String?,
  bio: json['bio'] as String?,
  avatar: json['avatar'],
  company: json['company'] as String?,
);

Map<String, dynamic> _$$PlaybookAuthorDtoImplToJson(
  _$PlaybookAuthorDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'title': instance.title,
  'bio': instance.bio,
  'avatar': instance.avatar,
  'company': instance.company,
};

_$PlaybookContentDtoImpl _$$PlaybookContentDtoImplFromJson(
  Map<String, dynamic> json,
) => _$PlaybookContentDtoImpl(
  id: json['id'],
  title: json['title'] as String,
  type: json['type'] as String? ?? 'guide',
  summary: json['summary'] as String,
  content: json['content'] as String? ?? '',
  category: json['category'],
  author: json['author'],
  difficulty: json['difficulty'] as String? ?? 'beginner',
  coverImage: json['coverImage'],
  videoUrl: json['videoUrl'] as String?,
  readingTimeMinutes: (json['readingTimeMinutes'] as num?)?.toInt(),
  durationMinutes: (json['durationMinutes'] as num?)?.toInt(),
  isFeatured: json['isFeatured'] as bool? ?? false,
  isPremium: json['isPremium'] as bool? ?? false,
  viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
  likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$$PlaybookContentDtoImplToJson(
  _$PlaybookContentDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'type': instance.type,
  'summary': instance.summary,
  'content': instance.content,
  'category': instance.category,
  'author': instance.author,
  'difficulty': instance.difficulty,
  'coverImage': instance.coverImage,
  'videoUrl': instance.videoUrl,
  'readingTimeMinutes': instance.readingTimeMinutes,
  'durationMinutes': instance.durationMinutes,
  'isFeatured': instance.isFeatured,
  'isPremium': instance.isPremium,
  'viewCount': instance.viewCount,
  'likeCount': instance.likeCount,
  'tags': instance.tags,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};

_$PlaybookListResponseImpl _$$PlaybookListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$PlaybookListResponseImpl(
  docs: (json['docs'] as List<dynamic>)
      .map((e) => PlaybookContentDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalDocs: (json['totalDocs'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  hasNextPage: json['hasNextPage'] as bool,
  hasPrevPage: json['hasPrevPage'] as bool,
);

Map<String, dynamic> _$$PlaybookListResponseImplToJson(
  _$PlaybookListResponseImpl instance,
) => <String, dynamic>{
  'docs': instance.docs,
  'totalDocs': instance.totalDocs,
  'limit': instance.limit,
  'page': instance.page,
  'totalPages': instance.totalPages,
  'hasNextPage': instance.hasNextPage,
  'hasPrevPage': instance.hasPrevPage,
};

_$PlaybookCategoriesResponseImpl _$$PlaybookCategoriesResponseImplFromJson(
  Map<String, dynamic> json,
) => _$PlaybookCategoriesResponseImpl(
  docs: (json['docs'] as List<dynamic>)
      .map((e) => PlaybookCategoryDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalDocs: (json['totalDocs'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  hasNextPage: json['hasNextPage'] as bool,
  hasPrevPage: json['hasPrevPage'] as bool,
);

Map<String, dynamic> _$$PlaybookCategoriesResponseImplToJson(
  _$PlaybookCategoriesResponseImpl instance,
) => <String, dynamic>{
  'docs': instance.docs,
  'totalDocs': instance.totalDocs,
  'limit': instance.limit,
  'page': instance.page,
  'totalPages': instance.totalPages,
  'hasNextPage': instance.hasNextPage,
  'hasPrevPage': instance.hasPrevPage,
};
