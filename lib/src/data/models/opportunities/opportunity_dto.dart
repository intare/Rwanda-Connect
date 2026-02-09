import 'package:freezed_annotation/freezed_annotation.dart';

part 'opportunity_dto.freezed.dart';
part 'opportunity_dto.g.dart';

/// DTO for opportunity from Payload CMS API.
@freezed
class OpportunityDto with _$OpportunityDto {
  const factory OpportunityDto({
    required dynamic id, // Can be int or String from Payload
    required String type,
    required String title,
    required String company,
    required String location,
    required String applyUrl,
    String? deadline,
    bool? verified,
    bool? isFeatured,
    int? salary,
    String? salaryCurrency,
    String? description,
    dynamic companyLogo, // Can be object or ID
    List<dynamic>? requirements,
    String? datePosted,
    String? createdAt,
    String? updatedAt,
  }) = _OpportunityDto;

  factory OpportunityDto.fromJson(Map<String, dynamic> json) =>
      _$OpportunityDtoFromJson(json);
}

/// Extension to get string ID and parsed dates.
extension OpportunityDtoX on OpportunityDto {
  String get idString => id.toString();

  DateTime? get deadlineDateTime {
    if (deadline == null) return null;
    return DateTime.tryParse(deadline!);
  }

  DateTime? get datePostedDateTime {
    if (datePosted == null) return null;
    return DateTime.tryParse(datePosted!);
  }
}
