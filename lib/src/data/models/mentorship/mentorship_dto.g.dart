// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentorship_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MentorDtoImpl _$$MentorDtoImplFromJson(
  Map<String, dynamic> json,
) => _$MentorDtoImpl(
  id: json['id'],
  userId: json['userId'] as String,
  name: json['name'] as String,
  avatar: json['avatar'],
  title: json['title'] as String?,
  company: json['company'] as String?,
  bio: json['bio'] as String?,
  expertise:
      (json['expertise'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  yearsExperience: (json['yearsExperience'] as num?)?.toInt() ?? 0,
  linkedinUrl: json['linkedinUrl'] as String?,
  location: json['location'] as String?,
  languages:
      (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  isAvailable: json['isAvailable'] as bool? ?? true,
  totalMentees: (json['totalMentees'] as num?)?.toInt() ?? 0,
  rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
  reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$$MentorDtoImplToJson(_$MentorDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'avatar': instance.avatar,
      'title': instance.title,
      'company': instance.company,
      'bio': instance.bio,
      'expertise': instance.expertise,
      'yearsExperience': instance.yearsExperience,
      'linkedinUrl': instance.linkedinUrl,
      'location': instance.location,
      'languages': instance.languages,
      'isAvailable': instance.isAvailable,
      'totalMentees': instance.totalMentees,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
      'createdAt': instance.createdAt,
    };

_$MentorshipRequestDtoImpl _$$MentorshipRequestDtoImplFromJson(
  Map<String, dynamic> json,
) => _$MentorshipRequestDtoImpl(
  id: json['id'],
  mentor: json['mentor'],
  mentee: json['mentee'],
  status: json['status'] as String? ?? 'pending',
  message: json['message'] as String,
  responseMessage: json['responseMessage'] as String?,
  createdAt: json['createdAt'] as String,
  respondedAt: json['respondedAt'] as String?,
);

Map<String, dynamic> _$$MentorshipRequestDtoImplToJson(
  _$MentorshipRequestDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'mentor': instance.mentor,
  'mentee': instance.mentee,
  'status': instance.status,
  'message': instance.message,
  'responseMessage': instance.responseMessage,
  'createdAt': instance.createdAt,
  'respondedAt': instance.respondedAt,
};

_$MentorshipConnectionDtoImpl _$$MentorshipConnectionDtoImplFromJson(
  Map<String, dynamic> json,
) => _$MentorshipConnectionDtoImpl(
  id: json['id'],
  mentor: json['mentor'],
  mentee: json['mentee'],
  startedAt: json['startedAt'] as String,
  endedAt: json['endedAt'] as String?,
  isActive: json['isActive'] as bool? ?? true,
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$$MentorshipConnectionDtoImplToJson(
  _$MentorshipConnectionDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'mentor': instance.mentor,
  'mentee': instance.mentee,
  'startedAt': instance.startedAt,
  'endedAt': instance.endedAt,
  'isActive': instance.isActive,
  'notes': instance.notes,
};

_$MentorsListResponseImpl _$$MentorsListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$MentorsListResponseImpl(
  docs: (json['docs'] as List<dynamic>)
      .map((e) => MentorDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalDocs: (json['totalDocs'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  hasNextPage: json['hasNextPage'] as bool,
  hasPrevPage: json['hasPrevPage'] as bool,
);

Map<String, dynamic> _$$MentorsListResponseImplToJson(
  _$MentorsListResponseImpl instance,
) => <String, dynamic>{
  'docs': instance.docs,
  'totalDocs': instance.totalDocs,
  'limit': instance.limit,
  'page': instance.page,
  'totalPages': instance.totalPages,
  'hasNextPage': instance.hasNextPage,
  'hasPrevPage': instance.hasPrevPage,
};

_$MentorshipRequestsListResponseImpl
_$$MentorshipRequestsListResponseImplFromJson(Map<String, dynamic> json) =>
    _$MentorshipRequestsListResponseImpl(
      docs: (json['docs'] as List<dynamic>)
          .map((e) => MentorshipRequestDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDocs: (json['totalDocs'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      hasNextPage: json['hasNextPage'] as bool,
      hasPrevPage: json['hasPrevPage'] as bool,
    );

Map<String, dynamic> _$$MentorshipRequestsListResponseImplToJson(
  _$MentorshipRequestsListResponseImpl instance,
) => <String, dynamic>{
  'docs': instance.docs,
  'totalDocs': instance.totalDocs,
  'limit': instance.limit,
  'page': instance.page,
  'totalPages': instance.totalPages,
  'hasNextPage': instance.hasNextPage,
  'hasPrevPage': instance.hasPrevPage,
};

_$MentorshipConnectionsListResponseImpl
_$$MentorshipConnectionsListResponseImplFromJson(Map<String, dynamic> json) =>
    _$MentorshipConnectionsListResponseImpl(
      docs: (json['docs'] as List<dynamic>)
          .map(
            (e) => MentorshipConnectionDto.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      totalDocs: (json['totalDocs'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      hasNextPage: json['hasNextPage'] as bool,
      hasPrevPage: json['hasPrevPage'] as bool,
    );

Map<String, dynamic> _$$MentorshipConnectionsListResponseImplToJson(
  _$MentorshipConnectionsListResponseImpl instance,
) => <String, dynamic>{
  'docs': instance.docs,
  'totalDocs': instance.totalDocs,
  'limit': instance.limit,
  'page': instance.page,
  'totalPages': instance.totalPages,
  'hasNextPage': instance.hasNextPage,
  'hasPrevPage': instance.hasPrevPage,
};

_$SendMentorshipRequestDtoImpl _$$SendMentorshipRequestDtoImplFromJson(
  Map<String, dynamic> json,
) => _$SendMentorshipRequestDtoImpl(
  mentorId: json['mentorId'] as String,
  message: json['message'] as String,
);

Map<String, dynamic> _$$SendMentorshipRequestDtoImplToJson(
  _$SendMentorshipRequestDtoImpl instance,
) => <String, dynamic>{
  'mentorId': instance.mentorId,
  'message': instance.message,
};

_$RegisterMentorDtoImpl _$$RegisterMentorDtoImplFromJson(
  Map<String, dynamic> json,
) => _$RegisterMentorDtoImpl(
  bio: json['bio'] as String,
  expertise: (json['expertise'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  yearsExperience: (json['yearsExperience'] as num).toInt(),
  linkedinUrl: json['linkedinUrl'] as String?,
);

Map<String, dynamic> _$$RegisterMentorDtoImplToJson(
  _$RegisterMentorDtoImpl instance,
) => <String, dynamic>{
  'bio': instance.bio,
  'expertise': instance.expertise,
  'yearsExperience': instance.yearsExperience,
  'linkedinUrl': instance.linkedinUrl,
};
