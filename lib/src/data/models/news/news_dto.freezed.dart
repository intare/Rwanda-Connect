// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

NewsDto _$NewsDtoFromJson(Map<String, dynamic> json) {
  return _NewsDto.fromJson(json);
}

/// @nodoc
mixin _$NewsDto {
  dynamic get id =>
      throw _privateConstructorUsedError; // Can be int or String from Payload
  String get title => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get summary => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String? get publishDate => throw _privateConstructorUsedError;
  dynamic get image =>
      throw _privateConstructorUsedError; // Can be object or ID
  List<dynamic>? get tags => throw _privateConstructorUsedError;
  bool? get isFeatured => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this NewsDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NewsDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NewsDtoCopyWith<NewsDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsDtoCopyWith<$Res> {
  factory $NewsDtoCopyWith(NewsDto value, $Res Function(NewsDto) then) =
      _$NewsDtoCopyWithImpl<$Res, NewsDto>;
  @useResult
  $Res call({
    dynamic id,
    String title,
    String source,
    String category,
    String summary,
    String url,
    String? publishDate,
    dynamic image,
    List<dynamic>? tags,
    bool? isFeatured,
    String? content,
    String? createdAt,
    String? updatedAt,
  });
}

/// @nodoc
class _$NewsDtoCopyWithImpl<$Res, $Val extends NewsDto>
    implements $NewsDtoCopyWith<$Res> {
  _$NewsDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NewsDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? source = null,
    Object? category = null,
    Object? summary = null,
    Object? url = null,
    Object? publishDate = freezed,
    Object? image = freezed,
    Object? tags = freezed,
    Object? isFeatured = freezed,
    Object? content = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String,
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
            publishDate: freezed == publishDate
                ? _value.publishDate
                : publishDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            image: freezed == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            tags: freezed == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>?,
            isFeatured: freezed == isFeatured
                ? _value.isFeatured
                : isFeatured // ignore: cast_nullable_to_non_nullable
                      as bool?,
            content: freezed == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NewsDtoImplCopyWith<$Res> implements $NewsDtoCopyWith<$Res> {
  factory _$$NewsDtoImplCopyWith(
    _$NewsDtoImpl value,
    $Res Function(_$NewsDtoImpl) then,
  ) = __$$NewsDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    dynamic id,
    String title,
    String source,
    String category,
    String summary,
    String url,
    String? publishDate,
    dynamic image,
    List<dynamic>? tags,
    bool? isFeatured,
    String? content,
    String? createdAt,
    String? updatedAt,
  });
}

/// @nodoc
class __$$NewsDtoImplCopyWithImpl<$Res>
    extends _$NewsDtoCopyWithImpl<$Res, _$NewsDtoImpl>
    implements _$$NewsDtoImplCopyWith<$Res> {
  __$$NewsDtoImplCopyWithImpl(
    _$NewsDtoImpl _value,
    $Res Function(_$NewsDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NewsDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? source = null,
    Object? category = null,
    Object? summary = null,
    Object? url = null,
    Object? publishDate = freezed,
    Object? image = freezed,
    Object? tags = freezed,
    Object? isFeatured = freezed,
    Object? content = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$NewsDtoImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String,
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        publishDate: freezed == publishDate
            ? _value.publishDate
            : publishDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        image: freezed == image
            ? _value.image
            : image // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        tags: freezed == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>?,
        isFeatured: freezed == isFeatured
            ? _value.isFeatured
            : isFeatured // ignore: cast_nullable_to_non_nullable
                  as bool?,
        content: freezed == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NewsDtoImpl implements _NewsDto {
  const _$NewsDtoImpl({
    required this.id,
    required this.title,
    required this.source,
    required this.category,
    required this.summary,
    required this.url,
    this.publishDate,
    this.image,
    final List<dynamic>? tags,
    this.isFeatured,
    this.content,
    this.createdAt,
    this.updatedAt,
  }) : _tags = tags;

  factory _$NewsDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewsDtoImplFromJson(json);

  @override
  final dynamic id;
  // Can be int or String from Payload
  @override
  final String title;
  @override
  final String source;
  @override
  final String category;
  @override
  final String summary;
  @override
  final String url;
  @override
  final String? publishDate;
  @override
  final dynamic image;
  // Can be object or ID
  final List<dynamic>? _tags;
  // Can be object or ID
  @override
  List<dynamic>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? isFeatured;
  @override
  final String? content;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;

  @override
  String toString() {
    return 'NewsDto(id: $id, title: $title, source: $source, category: $category, summary: $summary, url: $url, publishDate: $publishDate, image: $image, tags: $tags, isFeatured: $isFeatured, content: $content, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsDtoImpl &&
            const DeepCollectionEquality().equals(other.id, id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.publishDate, publishDate) ||
                other.publishDate == publishDate) &&
            const DeepCollectionEquality().equals(other.image, image) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(id),
    title,
    source,
    category,
    summary,
    url,
    publishDate,
    const DeepCollectionEquality().hash(image),
    const DeepCollectionEquality().hash(_tags),
    isFeatured,
    content,
    createdAt,
    updatedAt,
  );

  /// Create a copy of NewsDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsDtoImplCopyWith<_$NewsDtoImpl> get copyWith =>
      __$$NewsDtoImplCopyWithImpl<_$NewsDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NewsDtoImplToJson(this);
  }
}

abstract class _NewsDto implements NewsDto {
  const factory _NewsDto({
    required final dynamic id,
    required final String title,
    required final String source,
    required final String category,
    required final String summary,
    required final String url,
    final String? publishDate,
    final dynamic image,
    final List<dynamic>? tags,
    final bool? isFeatured,
    final String? content,
    final String? createdAt,
    final String? updatedAt,
  }) = _$NewsDtoImpl;

  factory _NewsDto.fromJson(Map<String, dynamic> json) = _$NewsDtoImpl.fromJson;

  @override
  dynamic get id; // Can be int or String from Payload
  @override
  String get title;
  @override
  String get source;
  @override
  String get category;
  @override
  String get summary;
  @override
  String get url;
  @override
  String? get publishDate;
  @override
  dynamic get image; // Can be object or ID
  @override
  List<dynamic>? get tags;
  @override
  bool? get isFeatured;
  @override
  String? get content;
  @override
  String? get createdAt;
  @override
  String? get updatedAt;

  /// Create a copy of NewsDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewsDtoImplCopyWith<_$NewsDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
