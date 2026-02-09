import '../../domain/entities/news.dart';
import '../models/news/news_dto.dart';

/// Mapper to convert between NewsDto and News domain entity.
extension NewsMapper on NewsDto {
  /// Convert DTO to domain entity.
  News toEntity() {
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
