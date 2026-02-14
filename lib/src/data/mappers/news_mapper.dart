import '../../core/network/api_endpoints.dart';
import '../../domain/entities/news.dart';
import '../models/news/news_dto.dart';

/// Mapper to convert between NewsDto and News domain entity.
extension NewsMapper on NewsDto {
  /// Convert DTO to domain entity.
  News toEntity() {
    // Extract image URL from populated image object
    String? imgUrl;
    if (image is Map<String, dynamic>) {
      final relativeUrl = image['url'] as String?;
      if (relativeUrl != null) {
        // Prepend server URL if it's a relative path
        imgUrl = relativeUrl.startsWith('http')
            ? relativeUrl
            : '${ApiEndpoints.serverUrl}$relativeUrl';
      }
    }

    return News(
      id: id.toString(),
      title: title,
      source: source,
      category: category,
      summary: summary,
      publishDate: publishDate != null
          ? DateTime.tryParse(publishDate!) ?? DateTime.now()
          : DateTime.now(),
      url: url,
      content: content,
      imageUrl: imgUrl,
    );
  }
}

/// Mapper to convert list of DTOs to entities.
extension NewsDtoListMapper on List<NewsDto> {
  /// Convert list of DTOs to domain entities.
  List<News> toEntities() {
    return map((dto) => dto.toEntity()).toList();
  }
}
