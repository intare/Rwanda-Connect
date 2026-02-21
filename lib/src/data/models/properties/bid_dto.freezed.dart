// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bid_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BidDto _$BidDtoFromJson(Map<String, dynamic> json) {
  return _BidDto.fromJson(json);
}

/// @nodoc
mixin _$BidDto {
  dynamic get id => throw _privateConstructorUsedError;
  String get propertyId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;
  String? get propertyTitle => throw _privateConstructorUsedError;
  String? get propertyImage => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this BidDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BidDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BidDtoCopyWith<BidDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BidDtoCopyWith<$Res> {
  factory $BidDtoCopyWith(BidDto value, $Res Function(BidDto) then) =
      _$BidDtoCopyWithImpl<$Res, BidDto>;
  @useResult
  $Res call({
    dynamic id,
    String propertyId,
    String userId,
    double amount,
    String status,
    String createdAt,
    String? updatedAt,
    String? propertyTitle,
    String? propertyImage,
    String? message,
  });
}

/// @nodoc
class _$BidDtoCopyWithImpl<$Res, $Val extends BidDto>
    implements $BidDtoCopyWith<$Res> {
  _$BidDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BidDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? propertyId = null,
    Object? userId = null,
    Object? amount = null,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? propertyTitle = freezed,
    Object? propertyImage = freezed,
    Object? message = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            propertyId: null == propertyId
                ? _value.propertyId
                : propertyId // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            propertyTitle: freezed == propertyTitle
                ? _value.propertyTitle
                : propertyTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            propertyImage: freezed == propertyImage
                ? _value.propertyImage
                : propertyImage // ignore: cast_nullable_to_non_nullable
                      as String?,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BidDtoImplCopyWith<$Res> implements $BidDtoCopyWith<$Res> {
  factory _$$BidDtoImplCopyWith(
    _$BidDtoImpl value,
    $Res Function(_$BidDtoImpl) then,
  ) = __$$BidDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    dynamic id,
    String propertyId,
    String userId,
    double amount,
    String status,
    String createdAt,
    String? updatedAt,
    String? propertyTitle,
    String? propertyImage,
    String? message,
  });
}

/// @nodoc
class __$$BidDtoImplCopyWithImpl<$Res>
    extends _$BidDtoCopyWithImpl<$Res, _$BidDtoImpl>
    implements _$$BidDtoImplCopyWith<$Res> {
  __$$BidDtoImplCopyWithImpl(
    _$BidDtoImpl _value,
    $Res Function(_$BidDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BidDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? propertyId = null,
    Object? userId = null,
    Object? amount = null,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? propertyTitle = freezed,
    Object? propertyImage = freezed,
    Object? message = freezed,
  }) {
    return _then(
      _$BidDtoImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        propertyId: null == propertyId
            ? _value.propertyId
            : propertyId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        propertyTitle: freezed == propertyTitle
            ? _value.propertyTitle
            : propertyTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        propertyImage: freezed == propertyImage
            ? _value.propertyImage
            : propertyImage // ignore: cast_nullable_to_non_nullable
                  as String?,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BidDtoImpl implements _BidDto {
  const _$BidDtoImpl({
    required this.id,
    required this.propertyId,
    required this.userId,
    required this.amount,
    this.status = 'pending',
    required this.createdAt,
    this.updatedAt,
    this.propertyTitle,
    this.propertyImage,
    this.message,
  });

  factory _$BidDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BidDtoImplFromJson(json);

  @override
  final dynamic id;
  @override
  final String propertyId;
  @override
  final String userId;
  @override
  final double amount;
  @override
  @JsonKey()
  final String status;
  @override
  final String createdAt;
  @override
  final String? updatedAt;
  @override
  final String? propertyTitle;
  @override
  final String? propertyImage;
  @override
  final String? message;

  @override
  String toString() {
    return 'BidDto(id: $id, propertyId: $propertyId, userId: $userId, amount: $amount, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, propertyTitle: $propertyTitle, propertyImage: $propertyImage, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BidDtoImpl &&
            const DeepCollectionEquality().equals(other.id, id) &&
            (identical(other.propertyId, propertyId) ||
                other.propertyId == propertyId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.propertyTitle, propertyTitle) ||
                other.propertyTitle == propertyTitle) &&
            (identical(other.propertyImage, propertyImage) ||
                other.propertyImage == propertyImage) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(id),
    propertyId,
    userId,
    amount,
    status,
    createdAt,
    updatedAt,
    propertyTitle,
    propertyImage,
    message,
  );

  /// Create a copy of BidDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BidDtoImplCopyWith<_$BidDtoImpl> get copyWith =>
      __$$BidDtoImplCopyWithImpl<_$BidDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BidDtoImplToJson(this);
  }
}

abstract class _BidDto implements BidDto {
  const factory _BidDto({
    required final dynamic id,
    required final String propertyId,
    required final String userId,
    required final double amount,
    final String status,
    required final String createdAt,
    final String? updatedAt,
    final String? propertyTitle,
    final String? propertyImage,
    final String? message,
  }) = _$BidDtoImpl;

  factory _BidDto.fromJson(Map<String, dynamic> json) = _$BidDtoImpl.fromJson;

  @override
  dynamic get id;
  @override
  String get propertyId;
  @override
  String get userId;
  @override
  double get amount;
  @override
  String get status;
  @override
  String get createdAt;
  @override
  String? get updatedAt;
  @override
  String? get propertyTitle;
  @override
  String? get propertyImage;
  @override
  String? get message;

  /// Create a copy of BidDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BidDtoImplCopyWith<_$BidDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BidsListResponse _$BidsListResponseFromJson(Map<String, dynamic> json) {
  return _BidsListResponse.fromJson(json);
}

/// @nodoc
mixin _$BidsListResponse {
  List<BidDto> get docs => throw _privateConstructorUsedError;
  int get totalDocs => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  bool get hasNextPage => throw _privateConstructorUsedError;
  bool get hasPrevPage => throw _privateConstructorUsedError;

  /// Serializes this BidsListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BidsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BidsListResponseCopyWith<BidsListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BidsListResponseCopyWith<$Res> {
  factory $BidsListResponseCopyWith(
    BidsListResponse value,
    $Res Function(BidsListResponse) then,
  ) = _$BidsListResponseCopyWithImpl<$Res, BidsListResponse>;
  @useResult
  $Res call({
    List<BidDto> docs,
    int totalDocs,
    int limit,
    int page,
    int totalPages,
    bool hasNextPage,
    bool hasPrevPage,
  });
}

/// @nodoc
class _$BidsListResponseCopyWithImpl<$Res, $Val extends BidsListResponse>
    implements $BidsListResponseCopyWith<$Res> {
  _$BidsListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BidsListResponse
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
                      as List<BidDto>,
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
abstract class _$$BidsListResponseImplCopyWith<$Res>
    implements $BidsListResponseCopyWith<$Res> {
  factory _$$BidsListResponseImplCopyWith(
    _$BidsListResponseImpl value,
    $Res Function(_$BidsListResponseImpl) then,
  ) = __$$BidsListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<BidDto> docs,
    int totalDocs,
    int limit,
    int page,
    int totalPages,
    bool hasNextPage,
    bool hasPrevPage,
  });
}

/// @nodoc
class __$$BidsListResponseImplCopyWithImpl<$Res>
    extends _$BidsListResponseCopyWithImpl<$Res, _$BidsListResponseImpl>
    implements _$$BidsListResponseImplCopyWith<$Res> {
  __$$BidsListResponseImplCopyWithImpl(
    _$BidsListResponseImpl _value,
    $Res Function(_$BidsListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BidsListResponse
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
      _$BidsListResponseImpl(
        docs: null == docs
            ? _value._docs
            : docs // ignore: cast_nullable_to_non_nullable
                  as List<BidDto>,
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
class _$BidsListResponseImpl implements _BidsListResponse {
  const _$BidsListResponseImpl({
    required final List<BidDto> docs,
    required this.totalDocs,
    required this.limit,
    required this.page,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPrevPage,
  }) : _docs = docs;

  factory _$BidsListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BidsListResponseImplFromJson(json);

  final List<BidDto> _docs;
  @override
  List<BidDto> get docs {
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
    return 'BidsListResponse(docs: $docs, totalDocs: $totalDocs, limit: $limit, page: $page, totalPages: $totalPages, hasNextPage: $hasNextPage, hasPrevPage: $hasPrevPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BidsListResponseImpl &&
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

  /// Create a copy of BidsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BidsListResponseImplCopyWith<_$BidsListResponseImpl> get copyWith =>
      __$$BidsListResponseImplCopyWithImpl<_$BidsListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BidsListResponseImplToJson(this);
  }
}

abstract class _BidsListResponse implements BidsListResponse {
  const factory _BidsListResponse({
    required final List<BidDto> docs,
    required final int totalDocs,
    required final int limit,
    required final int page,
    required final int totalPages,
    required final bool hasNextPage,
    required final bool hasPrevPage,
  }) = _$BidsListResponseImpl;

  factory _BidsListResponse.fromJson(Map<String, dynamic> json) =
      _$BidsListResponseImpl.fromJson;

  @override
  List<BidDto> get docs;
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

  /// Create a copy of BidsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BidsListResponseImplCopyWith<_$BidsListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlaceBidRequest _$PlaceBidRequestFromJson(Map<String, dynamic> json) {
  return _PlaceBidRequest.fromJson(json);
}

/// @nodoc
mixin _$PlaceBidRequest {
  double get amount => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this PlaceBidRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlaceBidRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlaceBidRequestCopyWith<PlaceBidRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaceBidRequestCopyWith<$Res> {
  factory $PlaceBidRequestCopyWith(
    PlaceBidRequest value,
    $Res Function(PlaceBidRequest) then,
  ) = _$PlaceBidRequestCopyWithImpl<$Res, PlaceBidRequest>;
  @useResult
  $Res call({double amount, String? message});
}

/// @nodoc
class _$PlaceBidRequestCopyWithImpl<$Res, $Val extends PlaceBidRequest>
    implements $PlaceBidRequestCopyWith<$Res> {
  _$PlaceBidRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlaceBidRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? amount = null, Object? message = freezed}) {
    return _then(
      _value.copyWith(
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlaceBidRequestImplCopyWith<$Res>
    implements $PlaceBidRequestCopyWith<$Res> {
  factory _$$PlaceBidRequestImplCopyWith(
    _$PlaceBidRequestImpl value,
    $Res Function(_$PlaceBidRequestImpl) then,
  ) = __$$PlaceBidRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double amount, String? message});
}

/// @nodoc
class __$$PlaceBidRequestImplCopyWithImpl<$Res>
    extends _$PlaceBidRequestCopyWithImpl<$Res, _$PlaceBidRequestImpl>
    implements _$$PlaceBidRequestImplCopyWith<$Res> {
  __$$PlaceBidRequestImplCopyWithImpl(
    _$PlaceBidRequestImpl _value,
    $Res Function(_$PlaceBidRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlaceBidRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? amount = null, Object? message = freezed}) {
    return _then(
      _$PlaceBidRequestImpl(
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlaceBidRequestImpl implements _PlaceBidRequest {
  const _$PlaceBidRequestImpl({required this.amount, this.message});

  factory _$PlaceBidRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlaceBidRequestImplFromJson(json);

  @override
  final double amount;
  @override
  final String? message;

  @override
  String toString() {
    return 'PlaceBidRequest(amount: $amount, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaceBidRequestImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, amount, message);

  /// Create a copy of PlaceBidRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaceBidRequestImplCopyWith<_$PlaceBidRequestImpl> get copyWith =>
      __$$PlaceBidRequestImplCopyWithImpl<_$PlaceBidRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PlaceBidRequestImplToJson(this);
  }
}

abstract class _PlaceBidRequest implements PlaceBidRequest {
  const factory _PlaceBidRequest({
    required final double amount,
    final String? message,
  }) = _$PlaceBidRequestImpl;

  factory _PlaceBidRequest.fromJson(Map<String, dynamic> json) =
      _$PlaceBidRequestImpl.fromJson;

  @override
  double get amount;
  @override
  String? get message;

  /// Create a copy of PlaceBidRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaceBidRequestImplCopyWith<_$PlaceBidRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
