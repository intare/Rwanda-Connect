// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playbook.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PlaybookCategory {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  int get contentCount => throw _privateConstructorUsedError;

  /// Create a copy of PlaybookCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlaybookCategoryCopyWith<PlaybookCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaybookCategoryCopyWith<$Res> {
  factory $PlaybookCategoryCopyWith(
    PlaybookCategory value,
    $Res Function(PlaybookCategory) then,
  ) = _$PlaybookCategoryCopyWithImpl<$Res, PlaybookCategory>;
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    String? icon,
    int contentCount,
  });
}

/// @nodoc
class _$PlaybookCategoryCopyWithImpl<$Res, $Val extends PlaybookCategory>
    implements $PlaybookCategoryCopyWith<$Res> {
  _$PlaybookCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlaybookCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? icon = freezed,
    Object? contentCount = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
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
            contentCount: null == contentCount
                ? _value.contentCount
                : contentCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlaybookCategoryImplCopyWith<$Res>
    implements $PlaybookCategoryCopyWith<$Res> {
  factory _$$PlaybookCategoryImplCopyWith(
    _$PlaybookCategoryImpl value,
    $Res Function(_$PlaybookCategoryImpl) then,
  ) = __$$PlaybookCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    String? icon,
    int contentCount,
  });
}

/// @nodoc
class __$$PlaybookCategoryImplCopyWithImpl<$Res>
    extends _$PlaybookCategoryCopyWithImpl<$Res, _$PlaybookCategoryImpl>
    implements _$$PlaybookCategoryImplCopyWith<$Res> {
  __$$PlaybookCategoryImplCopyWithImpl(
    _$PlaybookCategoryImpl _value,
    $Res Function(_$PlaybookCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlaybookCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? icon = freezed,
    Object? contentCount = null,
  }) {
    return _then(
      _$PlaybookCategoryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
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
        contentCount: null == contentCount
            ? _value.contentCount
            : contentCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$PlaybookCategoryImpl extends _PlaybookCategory {
  const _$PlaybookCategoryImpl({
    required this.id,
    required this.name,
    this.description,
    this.icon,
    this.contentCount = 0,
  }) : super._();

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? icon;
  @override
  @JsonKey()
  final int contentCount;

  @override
  String toString() {
    return 'PlaybookCategory(id: $id, name: $name, description: $description, icon: $icon, contentCount: $contentCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaybookCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.contentCount, contentCount) ||
                other.contentCount == contentCount));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, description, icon, contentCount);

  /// Create a copy of PlaybookCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaybookCategoryImplCopyWith<_$PlaybookCategoryImpl> get copyWith =>
      __$$PlaybookCategoryImplCopyWithImpl<_$PlaybookCategoryImpl>(
        this,
        _$identity,
      );
}

abstract class _PlaybookCategory extends PlaybookCategory {
  const factory _PlaybookCategory({
    required final String id,
    required final String name,
    final String? description,
    final String? icon,
    final int contentCount,
  }) = _$PlaybookCategoryImpl;
  const _PlaybookCategory._() : super._();

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String? get icon;
  @override
  int get contentCount;

  /// Create a copy of PlaybookCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaybookCategoryImplCopyWith<_$PlaybookCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PlaybookAuthor {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  String? get company => throw _privateConstructorUsedError;

  /// Create a copy of PlaybookAuthor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlaybookAuthorCopyWith<PlaybookAuthor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaybookAuthorCopyWith<$Res> {
  factory $PlaybookAuthorCopyWith(
    PlaybookAuthor value,
    $Res Function(PlaybookAuthor) then,
  ) = _$PlaybookAuthorCopyWithImpl<$Res, PlaybookAuthor>;
  @useResult
  $Res call({
    String id,
    String name,
    String? title,
    String? bio,
    String? avatar,
    String? company,
  });
}

/// @nodoc
class _$PlaybookAuthorCopyWithImpl<$Res, $Val extends PlaybookAuthor>
    implements $PlaybookAuthorCopyWith<$Res> {
  _$PlaybookAuthorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlaybookAuthor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? title = freezed,
    Object? bio = freezed,
    Object? avatar = freezed,
    Object? company = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
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
                      as String?,
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
abstract class _$$PlaybookAuthorImplCopyWith<$Res>
    implements $PlaybookAuthorCopyWith<$Res> {
  factory _$$PlaybookAuthorImplCopyWith(
    _$PlaybookAuthorImpl value,
    $Res Function(_$PlaybookAuthorImpl) then,
  ) = __$$PlaybookAuthorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? title,
    String? bio,
    String? avatar,
    String? company,
  });
}

/// @nodoc
class __$$PlaybookAuthorImplCopyWithImpl<$Res>
    extends _$PlaybookAuthorCopyWithImpl<$Res, _$PlaybookAuthorImpl>
    implements _$$PlaybookAuthorImplCopyWith<$Res> {
  __$$PlaybookAuthorImplCopyWithImpl(
    _$PlaybookAuthorImpl _value,
    $Res Function(_$PlaybookAuthorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlaybookAuthor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? title = freezed,
    Object? bio = freezed,
    Object? avatar = freezed,
    Object? company = freezed,
  }) {
    return _then(
      _$PlaybookAuthorImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
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
                  as String?,
        company: freezed == company
            ? _value.company
            : company // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$PlaybookAuthorImpl extends _PlaybookAuthor {
  const _$PlaybookAuthorImpl({
    required this.id,
    required this.name,
    this.title,
    this.bio,
    this.avatar,
    this.company,
  }) : super._();

  @override
  final String id;
  @override
  final String name;
  @override
  final String? title;
  @override
  final String? bio;
  @override
  final String? avatar;
  @override
  final String? company;

  @override
  String toString() {
    return 'PlaybookAuthor(id: $id, name: $name, title: $title, bio: $bio, avatar: $avatar, company: $company)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaybookAuthorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.company, company) || other.company == company));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, title, bio, avatar, company);

  /// Create a copy of PlaybookAuthor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaybookAuthorImplCopyWith<_$PlaybookAuthorImpl> get copyWith =>
      __$$PlaybookAuthorImplCopyWithImpl<_$PlaybookAuthorImpl>(
        this,
        _$identity,
      );
}

abstract class _PlaybookAuthor extends PlaybookAuthor {
  const factory _PlaybookAuthor({
    required final String id,
    required final String name,
    final String? title,
    final String? bio,
    final String? avatar,
    final String? company,
  }) = _$PlaybookAuthorImpl;
  const _PlaybookAuthor._() : super._();

  @override
  String get id;
  @override
  String get name;
  @override
  String? get title;
  @override
  String? get bio;
  @override
  String? get avatar;
  @override
  String? get company;

  /// Create a copy of PlaybookAuthor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaybookAuthorImplCopyWith<_$PlaybookAuthorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PlaybookContent {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  PlaybookContentType get type => throw _privateConstructorUsedError;
  String get summary => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  PlaybookCategory get category => throw _privateConstructorUsedError;
  PlaybookAuthor? get author => throw _privateConstructorUsedError;
  PlaybookDifficulty get difficulty => throw _privateConstructorUsedError;
  String? get coverImage => throw _privateConstructorUsedError;
  String? get videoUrl => throw _privateConstructorUsedError;
  int? get readingTimeMinutes => throw _privateConstructorUsedError;
  int? get durationMinutes => throw _privateConstructorUsedError;
  bool get isFeatured => throw _privateConstructorUsedError;
  bool get isPremium => throw _privateConstructorUsedError;
  int get viewCount => throw _privateConstructorUsedError;
  int get likeCount => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of PlaybookContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlaybookContentCopyWith<PlaybookContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaybookContentCopyWith<$Res> {
  factory $PlaybookContentCopyWith(
    PlaybookContent value,
    $Res Function(PlaybookContent) then,
  ) = _$PlaybookContentCopyWithImpl<$Res, PlaybookContent>;
  @useResult
  $Res call({
    String id,
    String title,
    PlaybookContentType type,
    String summary,
    String content,
    PlaybookCategory category,
    PlaybookAuthor? author,
    PlaybookDifficulty difficulty,
    String? coverImage,
    String? videoUrl,
    int? readingTimeMinutes,
    int? durationMinutes,
    bool isFeatured,
    bool isPremium,
    int viewCount,
    int likeCount,
    List<String> tags,
    DateTime createdAt,
    DateTime? updatedAt,
  });

  $PlaybookCategoryCopyWith<$Res> get category;
  $PlaybookAuthorCopyWith<$Res>? get author;
}

/// @nodoc
class _$PlaybookContentCopyWithImpl<$Res, $Val extends PlaybookContent>
    implements $PlaybookContentCopyWith<$Res> {
  _$PlaybookContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlaybookContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? type = null,
    Object? summary = null,
    Object? content = null,
    Object? category = null,
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
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as PlaybookContentType,
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as PlaybookCategory,
            author: freezed == author
                ? _value.author
                : author // ignore: cast_nullable_to_non_nullable
                      as PlaybookAuthor?,
            difficulty: null == difficulty
                ? _value.difficulty
                : difficulty // ignore: cast_nullable_to_non_nullable
                      as PlaybookDifficulty,
            coverImage: freezed == coverImage
                ? _value.coverImage
                : coverImage // ignore: cast_nullable_to_non_nullable
                      as String?,
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
                      as DateTime,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of PlaybookContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlaybookCategoryCopyWith<$Res> get category {
    return $PlaybookCategoryCopyWith<$Res>(_value.category, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }

  /// Create a copy of PlaybookContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlaybookAuthorCopyWith<$Res>? get author {
    if (_value.author == null) {
      return null;
    }

    return $PlaybookAuthorCopyWith<$Res>(_value.author!, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlaybookContentImplCopyWith<$Res>
    implements $PlaybookContentCopyWith<$Res> {
  factory _$$PlaybookContentImplCopyWith(
    _$PlaybookContentImpl value,
    $Res Function(_$PlaybookContentImpl) then,
  ) = __$$PlaybookContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    PlaybookContentType type,
    String summary,
    String content,
    PlaybookCategory category,
    PlaybookAuthor? author,
    PlaybookDifficulty difficulty,
    String? coverImage,
    String? videoUrl,
    int? readingTimeMinutes,
    int? durationMinutes,
    bool isFeatured,
    bool isPremium,
    int viewCount,
    int likeCount,
    List<String> tags,
    DateTime createdAt,
    DateTime? updatedAt,
  });

  @override
  $PlaybookCategoryCopyWith<$Res> get category;
  @override
  $PlaybookAuthorCopyWith<$Res>? get author;
}

/// @nodoc
class __$$PlaybookContentImplCopyWithImpl<$Res>
    extends _$PlaybookContentCopyWithImpl<$Res, _$PlaybookContentImpl>
    implements _$$PlaybookContentImplCopyWith<$Res> {
  __$$PlaybookContentImplCopyWithImpl(
    _$PlaybookContentImpl _value,
    $Res Function(_$PlaybookContentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlaybookContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? type = null,
    Object? summary = null,
    Object? content = null,
    Object? category = null,
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
      _$PlaybookContentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as PlaybookContentType,
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as PlaybookCategory,
        author: freezed == author
            ? _value.author
            : author // ignore: cast_nullable_to_non_nullable
                  as PlaybookAuthor?,
        difficulty: null == difficulty
            ? _value.difficulty
            : difficulty // ignore: cast_nullable_to_non_nullable
                  as PlaybookDifficulty,
        coverImage: freezed == coverImage
            ? _value.coverImage
            : coverImage // ignore: cast_nullable_to_non_nullable
                  as String?,
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
                  as DateTime,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$PlaybookContentImpl extends _PlaybookContent {
  const _$PlaybookContentImpl({
    required this.id,
    required this.title,
    required this.type,
    required this.summary,
    required this.content,
    required this.category,
    this.author,
    this.difficulty = PlaybookDifficulty.beginner,
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
  }) : _tags = tags,
       super._();

  @override
  final String id;
  @override
  final String title;
  @override
  final PlaybookContentType type;
  @override
  final String summary;
  @override
  final String content;
  @override
  final PlaybookCategory category;
  @override
  final PlaybookAuthor? author;
  @override
  @JsonKey()
  final PlaybookDifficulty difficulty;
  @override
  final String? coverImage;
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
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'PlaybookContent(id: $id, title: $title, type: $type, summary: $summary, content: $content, category: $category, author: $author, difficulty: $difficulty, coverImage: $coverImage, videoUrl: $videoUrl, readingTimeMinutes: $readingTimeMinutes, durationMinutes: $durationMinutes, isFeatured: $isFeatured, isPremium: $isPremium, viewCount: $viewCount, likeCount: $likeCount, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaybookContentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.coverImage, coverImage) ||
                other.coverImage == coverImage) &&
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

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    title,
    type,
    summary,
    content,
    category,
    author,
    difficulty,
    coverImage,
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

  /// Create a copy of PlaybookContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaybookContentImplCopyWith<_$PlaybookContentImpl> get copyWith =>
      __$$PlaybookContentImplCopyWithImpl<_$PlaybookContentImpl>(
        this,
        _$identity,
      );
}

abstract class _PlaybookContent extends PlaybookContent {
  const factory _PlaybookContent({
    required final String id,
    required final String title,
    required final PlaybookContentType type,
    required final String summary,
    required final String content,
    required final PlaybookCategory category,
    final PlaybookAuthor? author,
    final PlaybookDifficulty difficulty,
    final String? coverImage,
    final String? videoUrl,
    final int? readingTimeMinutes,
    final int? durationMinutes,
    final bool isFeatured,
    final bool isPremium,
    final int viewCount,
    final int likeCount,
    final List<String> tags,
    required final DateTime createdAt,
    final DateTime? updatedAt,
  }) = _$PlaybookContentImpl;
  const _PlaybookContent._() : super._();

  @override
  String get id;
  @override
  String get title;
  @override
  PlaybookContentType get type;
  @override
  String get summary;
  @override
  String get content;
  @override
  PlaybookCategory get category;
  @override
  PlaybookAuthor? get author;
  @override
  PlaybookDifficulty get difficulty;
  @override
  String? get coverImage;
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
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of PlaybookContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaybookContentImplCopyWith<_$PlaybookContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
