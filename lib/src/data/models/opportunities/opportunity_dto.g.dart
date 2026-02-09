// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opportunity_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OpportunityDtoImpl _$$OpportunityDtoImplFromJson(Map<String, dynamic> json) =>
    _$OpportunityDtoImpl(
      id: json['id'],
      type: json['type'] as String,
      title: json['title'] as String,
      company: json['company'] as String,
      location: json['location'] as String,
      applyUrl: json['applyUrl'] as String,
      deadline: json['deadline'] as String?,
      verified: json['verified'] as bool?,
      isFeatured: json['isFeatured'] as bool?,
      salary: (json['salary'] as num?)?.toInt(),
      salaryCurrency: json['salaryCurrency'] as String?,
      description: json['description'] as String?,
      companyLogo: json['companyLogo'],
      requirements: json['requirements'] as List<dynamic>?,
      datePosted: json['datePosted'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$$OpportunityDtoImplToJson(
  _$OpportunityDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'title': instance.title,
  'company': instance.company,
  'location': instance.location,
  'applyUrl': instance.applyUrl,
  'deadline': instance.deadline,
  'verified': instance.verified,
  'isFeatured': instance.isFeatured,
  'salary': instance.salary,
  'salaryCurrency': instance.salaryCurrency,
  'description': instance.description,
  'companyLogo': instance.companyLogo,
  'requirements': instance.requirements,
  'datePosted': instance.datePosted,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
