import 'package:freezed_annotation/freezed_annotation.dart';

part 'news.freezed.dart';

/// Domain entity representing a news article.
@freezed
class News with _$News {
  const factory News({
    required String id,
    required String title,
    required String source,
    required String category,
    required String summary,
    required DateTime publishDate,
    required String url,
  }) = _News;
}

/// Available news categories.
enum NewsCategory {
  economy('Economy'),
  investment('Investment'),
  events('Events'),
  business('Business'),
  policy('Policy');

  const NewsCategory(this.label);
  final String label;

  static NewsCategory? fromString(String value) {
    return NewsCategory.values.firstWhere(
      (e) => e.label.toLowerCase() == value.toLowerCase(),
      orElse: () => NewsCategory.economy,
    );
  }
}
