import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_dto.freezed.dart';
part 'news_dto.g.dart';

/// DTO for news article from Payload CMS API.
@freezed
class NewsDto with _$NewsDto {
  const factory NewsDto({
    required dynamic id, // Can be int or String from Payload
    required String title,
    required String source,
    required String category,
    required String summary,
    required String url,
    String? publishDate,
    dynamic image, // Can be object or ID
    List<dynamic>? tags,
    bool? isFeatured,
    String? content,
    String? createdAt,
    String? updatedAt,
  }) = _NewsDto;

  factory NewsDto.fromJson(Map<String, dynamic> json) =>
      _$NewsDtoFromJson(json);
}

/// Extension to get string ID.
extension NewsDtoX on NewsDto {
  String get idString => id.toString();

  DateTime? get publishDateTime {
    if (publishDate == null) return null;
    return DateTime.tryParse(publishDate!);
  }
}
