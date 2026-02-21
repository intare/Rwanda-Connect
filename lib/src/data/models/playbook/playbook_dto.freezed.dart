// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playbook_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PlaybookCategoryDto _$PlaybookCategoryDtoFromJson(Map<String, dynamic> json) {
  return _PlaybookCategoryDto.fromJson(json);
}

/// @nodoc
mixin _$PlaybookCategoryDto {
  dynamic get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  int? get contentCount => throw _privateConstructorUsedError;

  /// Serializes this PlaybookCategoryDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlaybookCategoryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlaybookCategoryDtoCopyWith<PlaybookCategoryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaybookCategoryDtoCopyWith<$Res> {
  factory $PlaybookCategoryDtoCopyWith(
    PlaybookCategoryDto value,
    $Res Function(PlaybookCategoryDto) then,
  ) = _$PlaybookCategoryDtoCopyWithImpl<$Res, PlaybookCategoryDto>;
  @useResult
  $Res call({
    dynamic id,
    String name,
    String? description,
    String? icon,
    int? contentCount,
  });
}

/// @nodoc
class _$PlaybookCategoryDtoCopyWithImpl<$Res, $Val extends PlaybookCategoryDto>
    implements $PlaybookCategoryDtoCopyWith<$Res> {
  _$PlaybookCategoryDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlaybookCategoryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? description = freezed,
    Object? icon = freezed,
    Object? contentCount = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            icon: freezed == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String?,
            contentCount: freezed == contentCount
                ? _value.contentCount
                : contentCount // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlaybookCategoryDtoImplCopyWith<$Res>
    implements $PlaybookCategoryDtoCopyWith<$Res> {
  factory _$$PlaybookCategoryDtoImplCopyWith(
    _$PlaybookCategoryDtoImpl value,
    $Res Function(_$PlaybookCategoryDtoImpl) then,
  ) = __$$PlaybookCategoryDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    dynamic id,
    String name,
    String? description,
    String? icon,
    int? contentCount,
  });
}

/// @nodoc
class __$$PlaybookCategoryDtoImplCopyWithImpl<$Res>
    extends _$PlaybookCategoryDtoCopyWithImpl<$Res, _$PlaybookCategoryDtoImpl>
    implements _$$PlaybookCategoryDtoImplCopyWith<$Res> {
  __$$PlaybookCategoryDtoImplCopyWithImpl(
    _$PlaybookCategoryDtoImpl _value,
    $Res Function(_$PlaybookCategoryDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlaybookCategoryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? description = freezed,
    Object? icon = freezed,
    Object? contentCount = freezed,
  }) {
    return _then(
      _$PlaybookCategoryDtoImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        icon: freezed == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String?,
        contentCount: freezed == contentCount
            ? _value.contentCount
            : contentCount // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlaybookCategoryDtoImpl implements _PlaybookCategoryDto {
  const _$PlaybookCategoryDtoImpl({
    required this.id,
    required this.name,
    this.description,
    this.icon,
    this.contentCount,
  });

  factory _$PlaybookCategoryDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlaybookCategoryDtoImplFromJson(json);

  @override
  final dynamic id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? icon;
  @override
  final int? contentCount;

  @override
  String toString() {
    return 'PlaybookCategoryDto(id: $id, name: $name, description: $description, icon: $icon, contentCount: $contentCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaybookCategoryDtoImpl &&
            const DeepCollectionEquality().equals(other.id, id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.contentCount, contentCount) ||
                other.contentCount == contentCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(id),
    name,
    description,
    icon,
    contentCount,
  );

  /// Create a copy of PlaybookCategoryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaybookCategoryDtoImplCopyWith<_$PlaybookCategoryDtoImpl> get copyWith =>
      __$$PlaybookCategoryDtoImplCopyWithImpl<_$PlaybookCategoryDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PlaybookCategoryDtoImplToJson(this);
  }
}

abstract class _PlaybookCategoryDto implements PlaybookCategoryDto {
  const factory _PlaybookCategoryDto({
    required final dynamic id,
    required final String name,
    final String? description,
    final String? icon,
    final int? contentCount,
  }) = _$PlaybookCategoryDtoImpl;

  factory _PlaybookCategoryDto.fromJson(Map<String, dynamic> json) =
      _$PlaybookCategoryDtoImpl.fromJson;

  @override
  dynamic get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String? get icon;
  @override
  int? get contentCount;

  /// Create a copy of PlaybookCategoryDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaybookCategoryDtoImplCopyWith<_$PlaybookCategoryDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlaybookAuthorDto _$PlaybookAuthorDtoFromJson(Map<String, dynamic> json) {
  return _PlaybookAuthorDto.fromJson(json);
}

/// @nodoc
mixin _$PlaybookAuthorDto {
  dynamic get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  dynamic get avatar => throw _privateConstructorUsedError;
  String? get company => throw _privateConstructorUsedError;

  /// Serializes this PlaybookAuthorDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlaybookAuthorDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlaybookAuthorDtoCopyWith<PlaybookAuthorDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaybookAuthorDtoCopyWith<$Res> {
  factory $PlaybookAuthorDtoCopyWith(
    PlaybookAuthorDto value,
    $Res Function(PlaybookAuthorDto) then,
  ) = _$PlaybookAuthorDtoCopyWithImpl<$Res, PlaybookAuthorDto>;
  @useResult
  $Res call({
    dynamic id,
    String name,
    String? title,
    String? bio,
    dynamic avatar,
    String? company,
  });
}

/// @nodoc
class _$PlaybookAuthorDtoCopyWithImpl<$Res, $Val extends PlaybookAuthorDto>
    implements $PlaybookAuthorDtoCopyWith<$Res> {
  _$PlaybookAuthorDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlaybookAuthorDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? title = freezed,
    Object? bio = freezed,
    Object? avatar = freezed,
    Object? company = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            bio: freezed == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatar: freezed == avatar
                ? _value.avatar
                : avatar // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            company: freezed == company
                ? _value.company
                : company // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlaybookAuthorDtoImplCopyWith<$Res>
    implements $PlaybookAuthorDtoCopyWith<$Res> {
  factory _$$PlaybookAuthorDtoImplCopyWith(
    _$PlaybookAuthorDtoImpl value,
    $Res Function(_$PlaybookAuthorDtoImpl) then,
  ) = __$$PlaybookAuthorDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    dynamic id,
    String name,
    String? title,
    String? bio,
    dynamic avatar,
    String? company,
  });
}

/// @nodoc
class __$$PlaybookAuthorDtoImplCopyWithImpl<$Res>
    extends _$PlaybookAuthorDtoCopyWithImpl<$Res, _$PlaybookAuthorDtoImpl>
    implements _$$PlaybookAuthorDtoImplCopyWith<$Res> {
  __$$PlaybookAuthorDtoImplCopyWithImpl(
    _$PlaybookAuthorDtoImpl _value,
    $Res Function(_$PlaybookAuthorDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlaybookAuthorDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? title = freezed,
    Object? bio = freezed,
    Object? avatar = freezed,
    Object? company = freezed,
  }) {
    return _then(
      _$PlaybookAuthorDtoImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        bio: freezed == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatar: freezed == avatar
            ? _value.avatar
            : avatar // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        company: freezed == company
            ? _value.company
            : company // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlaybookAuthorDtoImpl implements _PlaybookAuthorDto {
  const _$PlaybookAuthorDtoImpl({
    required this.id,
    required this.name,
    this.title,
    this.bio,
    this.avatar,
    this.company,
  });

  factory _$PlaybookAuthorDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlaybookAuthorDtoImplFromJson(json);

  @override
  final dynamic id;
  @override
  final String name;
  @override
  final String? title;
  @override
  final String? bio;
  @override
  final dynamic avatar;
  @override
  final String? company;

  @override
  String toString() {
    return 'PlaybookAuthorDto(id: $id, name: $name, title: $title, bio: $bio, avatar: $avatar, company: $company)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaybookAuthorDtoImpl &&
            const DeepCollectionEquality().equals(other.id, id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            const DeepCollectionEquality().equals(other.avatar, avatar) &&
            (identical(other.company, company) || other.company == company));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(id),
    name,
    title,
    bio,
    const DeepCollectionEquality().hash(avatar),
    company,
  );

  /// Create a copy of PlaybookAuthorDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaybookAuthorDtoImplCopyWith<_$PlaybookAuthorDtoImpl> get copyWith =>
      __$$PlaybookAuthorDtoImplCopyWithImpl<_$PlaybookAuthorDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PlaybookAuthorDtoImplToJson(this);
  }
}

abstract class _PlaybookAuthorDto implements PlaybookAuthorDto {
  const factory _PlaybookAuthorDto({
    required final dynamic id,
    required final String name,
    final String? title,
    final String? bio,
    final dynamic avatar,
    final String? company,
  }) = _$PlaybookAuthorDtoImpl;

  factory _PlaybookAuthorDto.fromJson(Map<String, dynamic> json) =
      _$PlaybookAuthorDtoImpl.fromJson;

  @override
  dynamic get id;
  @override
  String get name;
  @override
  String? get title;
  @override
  String? get bio;
  @override
  dynamic get avatar;
  @override
  String? get company;

  /// Create a copy of PlaybookAuthorDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaybookAuthorDtoImplCopyWith<_$PlaybookAuthorDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlaybookContentDto _$PlaybookContentDtoFromJson(Map<String, dynamic> json) {
  return _PlaybookContentDto.fromJson(json);
}

/// @nodoc
mixin _$PlaybookContentDto {
  dynamic get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get summary => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  dynamic get category => throw _privateConstructorUsedError;
  dynamic get author => throw _privateConstructorUsedError;
  String get difficulty => throw _privateConstructorUsedError;
  dynamic get coverImage => throw _privateConstructorUsedError;
  String? get videoUrl => throw _privateConstructorUsedError;
  int? get readingTimeMinutes => throw _privateConstructorUsedError;
  int? get durationMinutes => throw _privateConstructorUsedError;
  bool get isFeatured => throw _privateConstructorUsedError;
  bool get isPremium => throw _privateConstructorUsedError;
  int get viewCount => throw _privateConstructorUsedError;
  int get likeCount => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this PlaybookContentDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlaybookContentDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlaybookContentDtoCopyWith<PlaybookContentDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaybookContentDtoCopyWith<$Res> {
  factory $PlaybookContentDtoCopyWith(
    PlaybookContentDto value,
    $Res Function(PlaybookContentDto) then,
  ) = _$PlaybookContentDtoCopyWithImpl<$Res, PlaybookContentDto>;
  @useResult
  $Res call({
    dynamic id,
    String title,
    String type,
    String summary,
    String content,
    dynamic category,
    dynamic author,
    String difficulty,
    dynamic coverImage,
    String? videoUrl,
    int? readingTimeMinutes,
    int? durationMinutes,
    bool isFeatured,
    bool isPremium,
    int viewCount,
    int likeCount,
    List<String> tags,
    String createdAt,
    String? updatedAt,
  });
}

/// @nodoc
class _$PlaybookContentDtoCopyWithImpl<$Res, $Val extends PlaybookContentDto>
    implements $PlaybookContentDtoCopyWith<$Res> {
  _$PlaybookContentDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlaybookContentDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? type = null,
    Object? summary = null,
    Object? content = null,
    Object? category = freezed,
    Object? author = freezed,
    Object? difficulty = null,
    Object? coverImage = freezed,
    Object? videoUrl = freezed,
    Object? readingTimeMinutes = freezed,
    Object? durationMinutes = freezed,
    Object? isFeatured = null,
    Object? isPremium = null,
    Object? viewCount = null,
    Object? likeCount = null,
    Object? tags = null,
    Object? createdAt = null,
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
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            author: freezed == author
                ? _value.author
                : author // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            difficulty: null == difficulty
                ? _value.difficulty
                : difficulty // ignore: cast_nullable_to_non_nullable
                      as String,
            coverImage: freezed == coverImage
                ? _value.coverImage
                : coverImage // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            videoUrl: freezed == videoUrl
                ? _value.videoUrl
                : videoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            readingTimeMinutes: freezed == readingTimeMinutes
                ? _value.readingTimeMinutes
                : readingTimeMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            durationMinutes: freezed == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            isFeatured: null == isFeatured
                ? _value.isFeatured
                : isFeatured // ignore: cast_nullable_to_non_nullable
                      as bool,
            isPremium: null == isPremium
                ? _value.isPremium
                : isPremium // ignore: cast_nullable_to_non_nullable
                      as bool,
            viewCount: null == viewCount
                ? _value.viewCount
                : viewCount // ignore: cast_nullable_to_non_nullable
                      as int,
            likeCount: null == likeCount
                ? _value.likeCount
                : likeCount // ignore: cast_nullable_to_non_nullable
                      as int,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
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
abstract class _$$PlaybookContentDtoImplCopyWith<$Res>
    implements $PlaybookContentDtoCopyWith<$Res> {
  factory _$$PlaybookContentDtoImplCopyWith(
    _$PlaybookContentDtoImpl value,
    $Res Function(_$PlaybookContentDtoImpl) then,
  ) = __$$PlaybookContentDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    dynamic id,
    String title,
    String type,
    String summary,
    String content,
    dynamic category,
    dynamic author,
    String difficulty,
    dynamic coverImage,
    String? videoUrl,
    int? readingTimeMinutes,
    int? durationMinutes,
    bool isFeatured,
    bool isPremium,
    int viewCount,
    int likeCount,
    List<String> tags,
    String createdAt,
    String? updatedAt,
  });
}

/// @nodoc
class __$$PlaybookContentDtoImplCopyWithImpl<$Res>
    extends _$PlaybookContentDtoCopyWithImpl<$Res, _$PlaybookContentDtoImpl>
    implements _$$PlaybookContentDtoImplCopyWith<$Res> {
  __$$PlaybookContentDtoImplCopyWithImpl(
    _$PlaybookContentDtoImpl _value,
    $Res Function(_$PlaybookContentDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlaybookContentDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? type = null,
    Object? summary = null,
    Object? content = null,
    Object? category = freezed,
    Object? author = freezed,
    Object? difficulty = null,
    Object? coverImage = freezed,
    Object? videoUrl = freezed,
    Object? readingTimeMinutes = freezed,
    Object? durationMinutes = freezed,
    Object? isFeatured = null,
    Object? isPremium = null,
    Object? viewCount = null,
    Object? likeCount = null,
    Object? tags = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$PlaybookContentDtoImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        author: freezed == author
            ? _value.author
            : author // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        difficulty: null == difficulty
            ? _value.difficulty
            : difficulty // ignore: cast_nullable_to_non_nullable
                  as String,
        coverImage: freezed == coverImage
            ? _value.coverImage
            : coverImage // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        videoUrl: freezed == videoUrl
            ? _value.videoUrl
            : videoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        readingTimeMinutes: freezed == readingTimeMinutes
            ? _value.readingTimeMinutes
            : readingTimeMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        durationMinutes: freezed == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        isFeatured: null == isFeatured
            ? _value.isFeatured
            : isFeatured // ignore: cast_nullable_to_non_nullable
                  as bool,
        isPremium: null == isPremium
            ? _value.isPremium
            : isPremium // ignore: cast_nullable_to_non_nullable
                  as bool,
        viewCount: null == viewCount
            ? _value.viewCount
            : viewCount // ignore: cast_nullable_to_non_nullable
                  as int,
        likeCount: null == likeCount
            ? _value.likeCount
            : likeCount // ignore: cast_nullable_to_non_nullable
                  as int,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
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
class _$PlaybookContentDtoImpl implements _PlaybookContentDto {
  const _$PlaybookContentDtoImpl({
    required this.id,
    required this.title,
    this.type = 'guide',
    required this.summary,
    this.content = '',
    required this.category,
    this.author,
    this.difficulty = 'beginner',
    this.coverImage,
    this.videoUrl,
    this.readingTimeMinutes,
    this.durationMinutes,
    this.isFeatured = false,
    this.isPremium = false,
    this.viewCount = 0,
    this.likeCount = 0,
    final List<String> tags = const [],
    required this.createdAt,
    this.updatedAt,
  }) : _tags = tags;

  factory _$PlaybookContentDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlaybookContentDtoImplFromJson(json);

  @override
  final dynamic id;
  @override
  final String title;
  @override
  @JsonKey()
  final String type;
  @override
  final String summary;
  @override
  @JsonKey()
  final String content;
  @override
  final dynamic category;
  @override
  final dynamic author;
  @override
  @JsonKey()
  final String difficulty;
  @override
  final dynamic coverImage;
  @override
  final String? videoUrl;
  @override
  final int? readingTimeMinutes;
  @override
  final int? durationMinutes;
  @override
  @JsonKey()
  final bool isFeatured;
  @override
  @JsonKey()
  final bool isPremium;
  @override
  @JsonKey()
  final int viewCount;
  @override
  @JsonKey()
  final int likeCount;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final String createdAt;
  @override
  final String? updatedAt;

  @override
  String toString() {
    return 'PlaybookContentDto(id: $id, title: $title, type: $type, summary: $summary, content: $content, category: $category, author: $author, difficulty: $difficulty, coverImage: $coverImage, videoUrl: $videoUrl, readingTimeMinutes: $readingTimeMinutes, durationMinutes: $durationMinutes, isFeatured: $isFeatured, isPremium: $isPremium, viewCount: $viewCount, likeCount: $likeCount, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaybookContentDtoImpl &&
            const DeepCollectionEquality().equals(other.id, id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other.category, category) &&
            const DeepCollectionEquality().equals(other.author, author) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            const DeepCollectionEquality().equals(
              other.coverImage,
              coverImage,
            ) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.readingTimeMinutes, readingTimeMinutes) ||
                other.readingTimeMinutes == readingTimeMinutes) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.isPremium, isPremium) ||
                other.isPremium == isPremium) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    const DeepCollectionEquality().hash(id),
    title,
    type,
    summary,
    content,
    const DeepCollectionEquality().hash(category),
    const DeepCollectionEquality().hash(author),
    difficulty,
    const DeepCollectionEquality().hash(coverImage),
    videoUrl,
    readingTimeMinutes,
    durationMinutes,
    isFeatured,
    isPremium,
    viewCount,
    likeCount,
    const DeepCollectionEquality().hash(_tags),
    createdAt,
    updatedAt,
  ]);

  /// Create a copy of PlaybookContentDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaybookContentDtoImplCopyWith<_$PlaybookContentDtoImpl> get copyWith =>
      __$$PlaybookContentDtoImplCopyWithImpl<_$PlaybookContentDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PlaybookContentDtoImplToJson(this);
  }
}

abstract class _PlaybookContentDto implements PlaybookContentDto {
  const factory _PlaybookContentDto({
    required final dynamic id,
    required final String title,
    final String type,
    required final String summary,
    final String content,
    required final dynamic category,
    final dynamic author,
    final String difficulty,
    final dynamic coverImage,
    final String? videoUrl,
    final int? readingTimeMinutes,
    final int? durationMinutes,
    final bool isFeatured,
    final bool isPremium,
    final int viewCount,
    final int likeCount,
    final List<String> tags,
    required final String createdAt,
    final String? updatedAt,
  }) = _$PlaybookContentDtoImpl;

  factory _PlaybookContentDto.fromJson(Map<String, dynamic> json) =
      _$PlaybookContentDtoImpl.fromJson;

  @override
  dynamic get id;
  @override
  String get title;
  @override
  String get type;
  @override
  String get summary;
  @override
  String get content;
  @override
  dynamic get category;
  @override
  dynamic get author;
  @override
  String get difficulty;
  @override
  dynamic get coverImage;
  @override
  String? get videoUrl;
  @override
  int? get readingTimeMinutes;
  @override
  int? get durationMinutes;
  @override
  bool get isFeatured;
  @override
  bool get isPremium;
  @override
  int get viewCount;
  @override
  int get likeCount;
  @override
  List<String> get tags;
  @override
  String get createdAt;
  @override
  String? get updatedAt;

  /// Create a copy of PlaybookContentDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaybookContentDtoImplCopyWith<_$PlaybookContentDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlaybookListResponse _$PlaybookListResponseFromJson(Map<String, dynamic> json) {
  return _PlaybookListResponse.fromJson(json);
}

/// @nodoc
mixin _$PlaybookListResponse {
  List<PlaybookContentDto> get docs => throw _privateConstructorUsedError;
  int get totalDocs => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  bool get hasNextPage => throw _privateConstructorUsedError;
  bool get hasPrevPage => throw _privateConstructorUsedError;

  /// Serializes this PlaybookListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlaybookListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlaybookListResponseCopyWith<PlaybookListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaybookListResponseCopyWith<$Res> {
  factory $PlaybookListResponseCopyWith(
    PlaybookListResponse value,
    $Res Function(PlaybookListResponse) then,
  ) = _$PlaybookListResponseCopyWithImpl<$Res, PlaybookListResponse>;
  @useResult
  $Res call({
    List<PlaybookContentDto> docs,
    int totalDocs,
    int limit,
    int page,
    int totalPages,
    bool hasNextPage,
    bool hasPrevPage,
  });
}

/// @nodoc
class _$PlaybookListResponseCopyWithImpl<
  $Res,
  $Val extends PlaybookListResponse
>
    implements $PlaybookListResponseCopyWith<$Res> {
  _$PlaybookListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlaybookListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docs = null,
    Object? totalDocs = null,
    Object? limit = null,
    Object? page = null,
    Object? totalPages = null,
    Object? hasNextPage = null,
    Object? hasPrevPage = null,
  }) {
    return _then(
      _value.copyWith(
            docs: null == docs
                ? _value.docs
                : docs // ignore: cast_nullable_to_non_nullable
                      as List<PlaybookContentDto>,
            totalDocs: null == totalDocs
                ? _value.totalDocs
                : totalDocs // ignore: cast_nullable_to_non_nullable
                      as int,
            limit: null == limit
                ? _value.limit
                : limit // ignore: cast_nullable_to_non_nullable
                      as int,
            page: null == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPages: null == totalPages
                ? _value.totalPages
                : totalPages // ignore: cast_nullable_to_non_nullable
                      as int,
            hasNextPage: null == hasNextPage
                ? _value.hasNextPage
                : hasNextPage // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasPrevPage: null == hasPrevPage
                ? _value.hasPrevPage
                : hasPrevPage // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlaybookListResponseImplCopyWith<$Res>
    implements $PlaybookListResponseCopyWith<$Res> {
  factory _$$PlaybookListResponseImplCopyWith(
    _$PlaybookListResponseImpl value,
    $Res Function(_$PlaybookListResponseImpl) then,
  ) = __$$PlaybookListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<PlaybookContentDto> docs,
    int totalDocs,
    int limit,
    int page,
    int totalPages,
    bool hasNextPage,
    bool hasPrevPage,
  });
}

/// @nodoc
class __$$PlaybookListResponseImplCopyWithImpl<$Res>
    extends _$PlaybookListResponseCopyWithImpl<$Res, _$PlaybookListResponseImpl>
    implements _$$PlaybookListResponseImplCopyWith<$Res> {
  __$$PlaybookListResponseImplCopyWithImpl(
    _$PlaybookListResponseImpl _value,
    $Res Function(_$PlaybookListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlaybookListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docs = null,
    Object? totalDocs = null,
    Object? limit = null,
    Object? page = null,
    Object? totalPages = null,
    Object? hasNextPage = null,
    Object? hasPrevPage = null,
  }) {
    return _then(
      _$PlaybookListResponseImpl(
        docs: null == docs
            ? _value._docs
            : docs // ignore: cast_nullable_to_non_nullable
                  as List<PlaybookContentDto>,
        totalDocs: null == totalDocs
            ? _value.totalDocs
            : totalDocs // ignore: cast_nullable_to_non_nullable
                  as int,
        limit: null == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int,
        page: null == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPages: null == totalPages
            ? _value.totalPages
            : totalPages // ignore: cast_nullable_to_non_nullable
                  as int,
        hasNextPage: null == hasNextPage
            ? _value.hasNextPage
            : hasNextPage // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasPrevPage: null == hasPrevPage
            ? _value.hasPrevPage
            : hasPrevPage // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlaybookListResponseImpl implements _PlaybookListResponse {
  const _$PlaybookListResponseImpl({
    required final List<PlaybookContentDto> docs,
    required this.totalDocs,
    required this.limit,
    required this.page,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPrevPage,
  }) : _docs = docs;

  factory _$PlaybookListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlaybookListResponseImplFromJson(json);

  final List<PlaybookContentDto> _docs;
  @override
  List<PlaybookContentDto> get docs {
    if (_docs is EqualUnmodifiableListView) return _docs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_docs);
  }

  @override
  final int totalDocs;
  @override
  final int limit;
  @override
  final int page;
  @override
  final int totalPages;
  @override
  final bool hasNextPage;
  @override
  final bool hasPrevPage;

  @override
  String toString() {
    return 'PlaybookListResponse(docs: $docs, totalDocs: $totalDocs, limit: $limit, page: $page, totalPages: $totalPages, hasNextPage: $hasNextPage, hasPrevPage: $hasPrevPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaybookListResponseImpl &&
            const DeepCollectionEquality().equals(other._docs, _docs) &&
            (identical(other.totalDocs, totalDocs) ||
                other.totalDocs == totalDocs) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.hasNextPage, hasNextPage) ||
                other.hasNextPage == hasNextPage) &&
            (identical(other.hasPrevPage, hasPrevPage) ||
                other.hasPrevPage == hasPrevPage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_docs),
    totalDocs,
    limit,
    page,
    totalPages,
    hasNextPage,
    hasPrevPage,
  );

  /// Create a copy of PlaybookListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaybookListResponseImplCopyWith<_$PlaybookListResponseImpl>
  get copyWith =>
      __$$PlaybookListResponseImplCopyWithImpl<_$PlaybookListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PlaybookListResponseImplToJson(this);
  }
}

abstract class _PlaybookListResponse implements PlaybookListResponse {
  const factory _PlaybookListResponse({
    required final List<PlaybookContentDto> docs,
    required final int totalDocs,
    required final int limit,
    required final int page,
    required final int totalPages,
    required final bool hasNextPage,
    required final bool hasPrevPage,
  }) = _$PlaybookListResponseImpl;

  factory _PlaybookListResponse.fromJson(Map<String, dynamic> json) =
      _$PlaybookListResponseImpl.fromJson;

  @override
  List<PlaybookContentDto> get docs;
  @override
  int get totalDocs;
  @override
  int get limit;
  @override
  int get page;
  @override
  int get totalPages;
  @override
  bool get hasNextPage;
  @override
  bool get hasPrevPage;

  /// Create a copy of PlaybookListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaybookListResponseImplCopyWith<_$PlaybookListResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PlaybookCategoriesResponse _$PlaybookCategoriesResponseFromJson(
  Map<String, dynamic> json,
) {
  return _PlaybookCategoriesResponse.fromJson(json);
}

/// @nodoc
mixin _$PlaybookCategoriesResponse {
  List<PlaybookCategoryDto> get docs => throw _privateConstructorUsedError;
  int get totalDocs => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  bool get hasNextPage => throw _privateConstructorUsedError;
  bool get hasPrevPage => throw _privateConstructorUsedError;

  /// Serializes this PlaybookCategoriesResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlaybookCategoriesResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlaybookCategoriesResponseCopyWith<PlaybookCategoriesResponse>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaybookCategoriesResponseCopyWith<$Res> {
  factory $PlaybookCategoriesResponseCopyWith(
    PlaybookCategoriesResponse value,
    $Res Function(PlaybookCategoriesResponse) then,
  ) =
      _$PlaybookCategoriesResponseCopyWithImpl<
        $Res,
        PlaybookCategoriesResponse
      >;
  @useResult
  $Res call({
    List<PlaybookCategoryDto> docs,
    int totalDocs,
    int limit,
    int page,
    int totalPages,
    bool hasNextPage,
    bool hasPrevPage,
  });
}

/// @nodoc
class _$PlaybookCategoriesResponseCopyWithImpl<
  $Res,
  $Val extends PlaybookCategoriesResponse
>
    implements $PlaybookCategoriesResponseCopyWith<$Res> {
  _$PlaybookCategoriesResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlaybookCategoriesResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docs = null,
    Object? totalDocs = null,
    Object? limit = null,
    Object? page = null,
    Object? totalPages = null,
    Object? hasNextPage = null,
    Object? hasPrevPage = null,
  }) {
    return _then(
      _value.copyWith(
            docs: null == docs
                ? _value.docs
                : docs // ignore: cast_nullable_to_non_nullable
                      as List<PlaybookCategoryDto>,
            totalDocs: null == totalDocs
                ? _value.totalDocs
                : totalDocs // ignore: cast_nullable_to_non_nullable
                      as int,
            limit: null == limit
                ? _value.limit
                : limit // ignore: cast_nullable_to_non_nullable
                      as int,
            page: null == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPages: null == totalPages
                ? _value.totalPages
                : totalPages // ignore: cast_nullable_to_non_nullable
                      as int,
            hasNextPage: null == hasNextPage
                ? _value.hasNextPage
                : hasNextPage // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasPrevPage: null == hasPrevPage
                ? _value.hasPrevPage
                : hasPrevPage // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlaybookCategoriesResponseImplCopyWith<$Res>
    implements $PlaybookCategoriesResponseCopyWith<$Res> {
  factory _$$PlaybookCategoriesResponseImplCopyWith(
    _$PlaybookCategoriesResponseImpl value,
    $Res Function(_$PlaybookCategoriesResponseImpl) then,
  ) = __$$PlaybookCategoriesResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<PlaybookCategoryDto> docs,
    int totalDocs,
    int limit,
    int page,
    int totalPages,
    bool hasNextPage,
    bool hasPrevPage,
  });
}

/// @nodoc
class __$$PlaybookCategoriesResponseImplCopyWithImpl<$Res>
    extends
        _$PlaybookCategoriesResponseCopyWithImpl<
          $Res,
          _$PlaybookCategoriesResponseImpl
        >
    implements _$$PlaybookCategoriesResponseImplCopyWith<$Res> {
  __$$PlaybookCategoriesResponseImplCopyWithImpl(
    _$PlaybookCategoriesResponseImpl _value,
    $Res Function(_$PlaybookCategoriesResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlaybookCategoriesResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docs = null,
    Object? totalDocs = null,
    Object? limit = null,
    Object? page = null,
    Object? totalPages = null,
    Object? hasNextPage = null,
    Object? hasPrevPage = null,
  }) {
    return _then(
      _$PlaybookCategoriesResponseImpl(
        docs: null == docs
            ? _value._docs
            : docs // ignore: cast_nullable_to_non_nullable
                  as List<PlaybookCategoryDto>,
        totalDocs: null == totalDocs
            ? _value.totalDocs
            : totalDocs // ignore: cast_nullable_to_non_nullable
                  as int,
        limit: null == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int,
        page: null == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPages: null == totalPages
            ? _value.totalPages
            : totalPages // ignore: cast_nullable_to_non_nullable
                  as int,
        hasNextPage: null == hasNextPage
            ? _value.hasNextPage
            : hasNextPage // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasPrevPage: null == hasPrevPage
            ? _value.hasPrevPage
            : hasPrevPage // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlaybookCategoriesResponseImpl implements _PlaybookCategoriesResponse {
  const _$PlaybookCategoriesResponseImpl({
    required final List<PlaybookCategoryDto> docs,
    required this.totalDocs,
    required this.limit,
    required this.page,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPrevPage,
  }) : _docs = docs;

  factory _$PlaybookCategoriesResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$PlaybookCategoriesResponseImplFromJson(json);

  final List<PlaybookCategoryDto> _docs;
  @override
  List<PlaybookCategoryDto> get docs {
    if (_docs is EqualUnmodifiableListView) return _docs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_docs);
  }

  @override
  final int totalDocs;
  @override
  final int limit;
  @override
  final int page;
  @override
  final int totalPages;
  @override
  final bool hasNextPage;
  @override
  final bool hasPrevPage;

  @override
  String toString() {
    return 'PlaybookCategoriesResponse(docs: $docs, totalDocs: $totalDocs, limit: $limit, page: $page, totalPages: $totalPages, hasNextPage: $hasNextPage, hasPrevPage: $hasPrevPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaybookCategoriesResponseImpl &&
            const DeepCollectionEquality().equals(other._docs, _docs) &&
            (identical(other.totalDocs, totalDocs) ||
                other.totalDocs == totalDocs) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.hasNextPage, hasNextPage) ||
                other.hasNextPage == hasNextPage) &&
            (identical(other.hasPrevPage, hasPrevPage) ||
                other.hasPrevPage == hasPrevPage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_docs),
    totalDocs,
    limit,
    page,
    totalPages,
    hasNextPage,
    hasPrevPage,
  );

  /// Create a copy of PlaybookCategoriesResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaybookCategoriesResponseImplCopyWith<_$PlaybookCategoriesResponseImpl>
  get copyWith =>
      __$$PlaybookCategoriesResponseImplCopyWithImpl<
        _$PlaybookCategoriesResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlaybookCategoriesResponseImplToJson(this);
  }
}

abstract class _PlaybookCategoriesResponse
    implements PlaybookCategoriesResponse {
  const factory _PlaybookCategoriesResponse({
    required final List<PlaybookCategoryDto> docs,
    required final int totalDocs,
    required final int limit,
    required final int page,
    required final int totalPages,
    required final bool hasNextPage,
    required final bool hasPrevPage,
  }) = _$PlaybookCategoriesResponseImpl;

  factory _PlaybookCategoriesResponse.fromJson(Map<String, dynamic> json) =
      _$PlaybookCategoriesResponseImpl.fromJson;

  @override
  List<PlaybookCategoryDto> get docs;
  @override
  int get totalDocs;
  @override
  int get limit;
  @override
  int get page;
  @override
  int get totalPages;
  @override
  bool get hasNextPage;
  @override
  bool get hasPrevPage;

  /// Create a copy of PlaybookCategoriesResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaybookCategoriesResponseImplCopyWith<_$PlaybookCategoriesResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}
