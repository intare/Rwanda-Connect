// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bookmark.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Bookmark {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  BookmarkType get type => throw _privateConstructorUsedError;
  String get itemId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// The bookmarked opportunity (populated when type is opportunity).
  Opportunity? get opportunity => throw _privateConstructorUsedError;

  /// Create a copy of Bookmark
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookmarkCopyWith<Bookmark> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookmarkCopyWith<$Res> {
  factory $BookmarkCopyWith(Bookmark value, $Res Function(Bookmark) then) =
      _$BookmarkCopyWithImpl<$Res, Bookmark>;
  @useResult
  $Res call({
    String id,
    String userId,
    BookmarkType type,
    String itemId,
    DateTime createdAt,
    Opportunity? opportunity,
  });

  $OpportunityCopyWith<$Res>? get opportunity;
}

/// @nodoc
class _$BookmarkCopyWithImpl<$Res, $Val extends Bookmark>
    implements $BookmarkCopyWith<$Res> {
  _$BookmarkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Bookmark
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? itemId = null,
    Object? createdAt = null,
    Object? opportunity = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as BookmarkType,
            itemId: null == itemId
                ? _value.itemId
                : itemId // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            opportunity: freezed == opportunity
                ? _value.opportunity
                : opportunity // ignore: cast_nullable_to_non_nullable
                      as Opportunity?,
          )
          as $Val,
    );
  }

  /// Create a copy of Bookmark
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OpportunityCopyWith<$Res>? get opportunity {
    if (_value.opportunity == null) {
      return null;
    }

    return $OpportunityCopyWith<$Res>(_value.opportunity!, (value) {
      return _then(_value.copyWith(opportunity: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BookmarkImplCopyWith<$Res>
    implements $BookmarkCopyWith<$Res> {
  factory _$$BookmarkImplCopyWith(
    _$BookmarkImpl value,
    $Res Function(_$BookmarkImpl) then,
  ) = __$$BookmarkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    BookmarkType type,
    String itemId,
    DateTime createdAt,
    Opportunity? opportunity,
  });

  @override
  $OpportunityCopyWith<$Res>? get opportunity;
}

/// @nodoc
class __$$BookmarkImplCopyWithImpl<$Res>
    extends _$BookmarkCopyWithImpl<$Res, _$BookmarkImpl>
    implements _$$BookmarkImplCopyWith<$Res> {
  __$$BookmarkImplCopyWithImpl(
    _$BookmarkImpl _value,
    $Res Function(_$BookmarkImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Bookmark
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? itemId = null,
    Object? createdAt = null,
    Object? opportunity = freezed,
  }) {
    return _then(
      _$BookmarkImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as BookmarkType,
        itemId: null == itemId
            ? _value.itemId
            : itemId // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        opportunity: freezed == opportunity
            ? _value.opportunity
            : opportunity // ignore: cast_nullable_to_non_nullable
                  as Opportunity?,
      ),
    );
  }
}

/// @nodoc

class _$BookmarkImpl extends _Bookmark {
  const _$BookmarkImpl({
    required this.id,
    required this.userId,
    required this.type,
    required this.itemId,
    required this.createdAt,
    this.opportunity,
  }) : super._();

  @override
  final String id;
  @override
  final String userId;
  @override
  final BookmarkType type;
  @override
  final String itemId;
  @override
  final DateTime createdAt;

  /// The bookmarked opportunity (populated when type is opportunity).
  @override
  final Opportunity? opportunity;

  @override
  String toString() {
    return 'Bookmark(id: $id, userId: $userId, type: $type, itemId: $itemId, createdAt: $createdAt, opportunity: $opportunity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookmarkImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.opportunity, opportunity) ||
                other.opportunity == opportunity));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    type,
    itemId,
    createdAt,
    opportunity,
  );

  /// Create a copy of Bookmark
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookmarkImplCopyWith<_$BookmarkImpl> get copyWith =>
      __$$BookmarkImplCopyWithImpl<_$BookmarkImpl>(this, _$identity);
}

abstract class _Bookmark extends Bookmark {
  const factory _Bookmark({
    required final String id,
    required final String userId,
    required final BookmarkType type,
    required final String itemId,
    required final DateTime createdAt,
    final Opportunity? opportunity,
  }) = _$BookmarkImpl;
  const _Bookmark._() : super._();

  @override
  String get id;
  @override
  String get userId;
  @override
  BookmarkType get type;
  @override
  String get itemId;
  @override
  DateTime get createdAt;

  /// The bookmarked opportunity (populated when type is opportunity).
  @override
  Opportunity? get opportunity;

  /// Create a copy of Bookmark
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookmarkImplCopyWith<_$BookmarkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
