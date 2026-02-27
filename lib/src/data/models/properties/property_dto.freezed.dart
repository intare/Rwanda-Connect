// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'property_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PropertyDto _$PropertyDtoFromJson(Map<String, dynamic> json) {
  return _PropertyDto.fromJson(json);
}

/// @nodoc
mixin _$PropertyDto {
  dynamic get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'category')
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'listingType')
  String get status => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'contactPhone')
  String? get agentPhone => throw _privateConstructorUsedError;
  @JsonKey(name: 'contactEmail')
  String? get agentEmail => throw _privateConstructorUsedError;
  List<dynamic> get images => throw _privateConstructorUsedError;
  @JsonKey(name: 'areaSqm')
  double? get size => throw _privateConstructorUsedError;
  int? get bedrooms => throw _privateConstructorUsedError;
  int? get bathrooms => throw _privateConstructorUsedError;
  bool get isFeatured => throw _privateConstructorUsedError;
  bool get isAvailable => throw _privateConstructorUsedError;
  @JsonKey(name: 'datePosted')
  String? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this PropertyDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PropertyDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PropertyDtoCopyWith<PropertyDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PropertyDtoCopyWith<$Res> {
  factory $PropertyDtoCopyWith(
    PropertyDto value,
    $Res Function(PropertyDto) then,
  ) = _$PropertyDtoCopyWithImpl<$Res, PropertyDto>;
  @useResult
  $Res call({
    dynamic id,
    String title,
    @JsonKey(name: 'category') String type,
    @JsonKey(name: 'listingType') String status,
    double price,
    String currency,
    String location,
    String description,
    @JsonKey(name: 'contactPhone') String? agentPhone,
    @JsonKey(name: 'contactEmail') String? agentEmail,
    List<dynamic> images,
    @JsonKey(name: 'areaSqm') double? size,
    int? bedrooms,
    int? bathrooms,
    bool isFeatured,
    bool isAvailable,
    @JsonKey(name: 'datePosted') String? createdAt,
  });
}

/// @nodoc
class _$PropertyDtoCopyWithImpl<$Res, $Val extends PropertyDto>
    implements $PropertyDtoCopyWith<$Res> {
  _$PropertyDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PropertyDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? type = null,
    Object? status = null,
    Object? price = null,
    Object? currency = null,
    Object? location = null,
    Object? description = null,
    Object? agentPhone = freezed,
    Object? agentEmail = freezed,
    Object? images = null,
    Object? size = freezed,
    Object? bedrooms = freezed,
    Object? bathrooms = freezed,
    Object? isFeatured = null,
    Object? isAvailable = null,
    Object? createdAt = freezed,
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
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            location: null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            agentPhone: freezed == agentPhone
                ? _value.agentPhone
                : agentPhone // ignore: cast_nullable_to_non_nullable
                      as String?,
            agentEmail: freezed == agentEmail
                ? _value.agentEmail
                : agentEmail // ignore: cast_nullable_to_non_nullable
                      as String?,
            images: null == images
                ? _value.images
                : images // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>,
            size: freezed == size
                ? _value.size
                : size // ignore: cast_nullable_to_non_nullable
                      as double?,
            bedrooms: freezed == bedrooms
                ? _value.bedrooms
                : bedrooms // ignore: cast_nullable_to_non_nullable
                      as int?,
            bathrooms: freezed == bathrooms
                ? _value.bathrooms
                : bathrooms // ignore: cast_nullable_to_non_nullable
                      as int?,
            isFeatured: null == isFeatured
                ? _value.isFeatured
                : isFeatured // ignore: cast_nullable_to_non_nullable
                      as bool,
            isAvailable: null == isAvailable
                ? _value.isAvailable
                : isAvailable // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PropertyDtoImplCopyWith<$Res>
    implements $PropertyDtoCopyWith<$Res> {
  factory _$$PropertyDtoImplCopyWith(
    _$PropertyDtoImpl value,
    $Res Function(_$PropertyDtoImpl) then,
  ) = __$$PropertyDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    dynamic id,
    String title,
    @JsonKey(name: 'category') String type,
    @JsonKey(name: 'listingType') String status,
    double price,
    String currency,
    String location,
    String description,
    @JsonKey(name: 'contactPhone') String? agentPhone,
    @JsonKey(name: 'contactEmail') String? agentEmail,
    List<dynamic> images,
    @JsonKey(name: 'areaSqm') double? size,
    int? bedrooms,
    int? bathrooms,
    bool isFeatured,
    bool isAvailable,
    @JsonKey(name: 'datePosted') String? createdAt,
  });
}

/// @nodoc
class __$$PropertyDtoImplCopyWithImpl<$Res>
    extends _$PropertyDtoCopyWithImpl<$Res, _$PropertyDtoImpl>
    implements _$$PropertyDtoImplCopyWith<$Res> {
  __$$PropertyDtoImplCopyWithImpl(
    _$PropertyDtoImpl _value,
    $Res Function(_$PropertyDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PropertyDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? type = null,
    Object? status = null,
    Object? price = null,
    Object? currency = null,
    Object? location = null,
    Object? description = null,
    Object? agentPhone = freezed,
    Object? agentEmail = freezed,
    Object? images = null,
    Object? size = freezed,
    Object? bedrooms = freezed,
    Object? bathrooms = freezed,
    Object? isFeatured = null,
    Object? isAvailable = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$PropertyDtoImpl(
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
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        location: null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        agentPhone: freezed == agentPhone
            ? _value.agentPhone
            : agentPhone // ignore: cast_nullable_to_non_nullable
                  as String?,
        agentEmail: freezed == agentEmail
            ? _value.agentEmail
            : agentEmail // ignore: cast_nullable_to_non_nullable
                  as String?,
        images: null == images
            ? _value._images
            : images // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>,
        size: freezed == size
            ? _value.size
            : size // ignore: cast_nullable_to_non_nullable
                  as double?,
        bedrooms: freezed == bedrooms
            ? _value.bedrooms
            : bedrooms // ignore: cast_nullable_to_non_nullable
                  as int?,
        bathrooms: freezed == bathrooms
            ? _value.bathrooms
            : bathrooms // ignore: cast_nullable_to_non_nullable
                  as int?,
        isFeatured: null == isFeatured
            ? _value.isFeatured
            : isFeatured // ignore: cast_nullable_to_non_nullable
                  as bool,
        isAvailable: null == isAvailable
            ? _value.isAvailable
            : isAvailable // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PropertyDtoImpl implements _PropertyDto {
  const _$PropertyDtoImpl({
    required this.id,
    required this.title,
    @JsonKey(name: 'category') this.type = 'house',
    @JsonKey(name: 'listingType') this.status = 'sale',
    this.price = 0,
    this.currency = 'RWF',
    this.location = '',
    this.description = '',
    @JsonKey(name: 'contactPhone') this.agentPhone,
    @JsonKey(name: 'contactEmail') this.agentEmail,
    final List<dynamic> images = const [],
    @JsonKey(name: 'areaSqm') this.size,
    this.bedrooms,
    this.bathrooms,
    this.isFeatured = false,
    this.isAvailable = true,
    @JsonKey(name: 'datePosted') this.createdAt,
  }) : _images = images;

  factory _$PropertyDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PropertyDtoImplFromJson(json);

  @override
  final dynamic id;
  @override
  final String title;
  @override
  @JsonKey(name: 'category')
  final String type;
  @override
  @JsonKey(name: 'listingType')
  final String status;
  @override
  @JsonKey()
  final double price;
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey()
  final String location;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey(name: 'contactPhone')
  final String? agentPhone;
  @override
  @JsonKey(name: 'contactEmail')
  final String? agentEmail;
  final List<dynamic> _images;
  @override
  @JsonKey()
  List<dynamic> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  @JsonKey(name: 'areaSqm')
  final double? size;
  @override
  final int? bedrooms;
  @override
  final int? bathrooms;
  @override
  @JsonKey()
  final bool isFeatured;
  @override
  @JsonKey()
  final bool isAvailable;
  @override
  @JsonKey(name: 'datePosted')
  final String? createdAt;

  @override
  String toString() {
    return 'PropertyDto(id: $id, title: $title, type: $type, status: $status, price: $price, currency: $currency, location: $location, description: $description, agentPhone: $agentPhone, agentEmail: $agentEmail, images: $images, size: $size, bedrooms: $bedrooms, bathrooms: $bathrooms, isFeatured: $isFeatured, isAvailable: $isAvailable, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PropertyDtoImpl &&
            const DeepCollectionEquality().equals(other.id, id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.agentPhone, agentPhone) ||
                other.agentPhone == agentPhone) &&
            (identical(other.agentEmail, agentEmail) ||
                other.agentEmail == agentEmail) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.bedrooms, bedrooms) ||
                other.bedrooms == bedrooms) &&
            (identical(other.bathrooms, bathrooms) ||
                other.bathrooms == bathrooms) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(id),
    title,
    type,
    status,
    price,
    currency,
    location,
    description,
    agentPhone,
    agentEmail,
    const DeepCollectionEquality().hash(_images),
    size,
    bedrooms,
    bathrooms,
    isFeatured,
    isAvailable,
    createdAt,
  );

  /// Create a copy of PropertyDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PropertyDtoImplCopyWith<_$PropertyDtoImpl> get copyWith =>
      __$$PropertyDtoImplCopyWithImpl<_$PropertyDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PropertyDtoImplToJson(this);
  }
}

abstract class _PropertyDto implements PropertyDto {
  const factory _PropertyDto({
    required final dynamic id,
    required final String title,
    @JsonKey(name: 'category') final String type,
    @JsonKey(name: 'listingType') final String status,
    final double price,
    final String currency,
    final String location,
    final String description,
    @JsonKey(name: 'contactPhone') final String? agentPhone,
    @JsonKey(name: 'contactEmail') final String? agentEmail,
    final List<dynamic> images,
    @JsonKey(name: 'areaSqm') final double? size,
    final int? bedrooms,
    final int? bathrooms,
    final bool isFeatured,
    final bool isAvailable,
    @JsonKey(name: 'datePosted') final String? createdAt,
  }) = _$PropertyDtoImpl;

  factory _PropertyDto.fromJson(Map<String, dynamic> json) =
      _$PropertyDtoImpl.fromJson;

  @override
  dynamic get id;
  @override
  String get title;
  @override
  @JsonKey(name: 'category')
  String get type;
  @override
  @JsonKey(name: 'listingType')
  String get status;
  @override
  double get price;
  @override
  String get currency;
  @override
  String get location;
  @override
  String get description;
  @override
  @JsonKey(name: 'contactPhone')
  String? get agentPhone;
  @override
  @JsonKey(name: 'contactEmail')
  String? get agentEmail;
  @override
  List<dynamic> get images;
  @override
  @JsonKey(name: 'areaSqm')
  double? get size;
  @override
  int? get bedrooms;
  @override
  int? get bathrooms;
  @override
  bool get isFeatured;
  @override
  bool get isAvailable;
  @override
  @JsonKey(name: 'datePosted')
  String? get createdAt;

  /// Create a copy of PropertyDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PropertyDtoImplCopyWith<_$PropertyDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PropertiesListResponse _$PropertiesListResponseFromJson(
  Map<String, dynamic> json,
) {
  return _PropertiesListResponse.fromJson(json);
}

/// @nodoc
mixin _$PropertiesListResponse {
  List<PropertyDto> get docs => throw _privateConstructorUsedError;
  int get totalDocs => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  bool get hasNextPage => throw _privateConstructorUsedError;
  bool get hasPrevPage => throw _privateConstructorUsedError;

  /// Serializes this PropertiesListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PropertiesListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PropertiesListResponseCopyWith<PropertiesListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PropertiesListResponseCopyWith<$Res> {
  factory $PropertiesListResponseCopyWith(
    PropertiesListResponse value,
    $Res Function(PropertiesListResponse) then,
  ) = _$PropertiesListResponseCopyWithImpl<$Res, PropertiesListResponse>;
  @useResult
  $Res call({
    List<PropertyDto> docs,
    int totalDocs,
    int limit,
    int page,
    int totalPages,
    bool hasNextPage,
    bool hasPrevPage,
  });
}

/// @nodoc
class _$PropertiesListResponseCopyWithImpl<
  $Res,
  $Val extends PropertiesListResponse
>
    implements $PropertiesListResponseCopyWith<$Res> {
  _$PropertiesListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PropertiesListResponse
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
                      as List<PropertyDto>,
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
abstract class _$$PropertiesListResponseImplCopyWith<$Res>
    implements $PropertiesListResponseCopyWith<$Res> {
  factory _$$PropertiesListResponseImplCopyWith(
    _$PropertiesListResponseImpl value,
    $Res Function(_$PropertiesListResponseImpl) then,
  ) = __$$PropertiesListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<PropertyDto> docs,
    int totalDocs,
    int limit,
    int page,
    int totalPages,
    bool hasNextPage,
    bool hasPrevPage,
  });
}

/// @nodoc
class __$$PropertiesListResponseImplCopyWithImpl<$Res>
    extends
        _$PropertiesListResponseCopyWithImpl<$Res, _$PropertiesListResponseImpl>
    implements _$$PropertiesListResponseImplCopyWith<$Res> {
  __$$PropertiesListResponseImplCopyWithImpl(
    _$PropertiesListResponseImpl _value,
    $Res Function(_$PropertiesListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PropertiesListResponse
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
      _$PropertiesListResponseImpl(
        docs: null == docs
            ? _value._docs
            : docs // ignore: cast_nullable_to_non_nullable
                  as List<PropertyDto>,
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
class _$PropertiesListResponseImpl implements _PropertiesListResponse {
  const _$PropertiesListResponseImpl({
    required final List<PropertyDto> docs,
    required this.totalDocs,
    required this.limit,
    required this.page,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPrevPage,
  }) : _docs = docs;

  factory _$PropertiesListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PropertiesListResponseImplFromJson(json);

  final List<PropertyDto> _docs;
  @override
  List<PropertyDto> get docs {
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
    return 'PropertiesListResponse(docs: $docs, totalDocs: $totalDocs, limit: $limit, page: $page, totalPages: $totalPages, hasNextPage: $hasNextPage, hasPrevPage: $hasPrevPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PropertiesListResponseImpl &&
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

  /// Create a copy of PropertiesListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PropertiesListResponseImplCopyWith<_$PropertiesListResponseImpl>
  get copyWith =>
      __$$PropertiesListResponseImplCopyWithImpl<_$PropertiesListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PropertiesListResponseImplToJson(this);
  }
}

abstract class _PropertiesListResponse implements PropertiesListResponse {
  const factory _PropertiesListResponse({
    required final List<PropertyDto> docs,
    required final int totalDocs,
    required final int limit,
    required final int page,
    required final int totalPages,
    required final bool hasNextPage,
    required final bool hasPrevPage,
  }) = _$PropertiesListResponseImpl;

  factory _PropertiesListResponse.fromJson(Map<String, dynamic> json) =
      _$PropertiesListResponseImpl.fromJson;

  @override
  List<PropertyDto> get docs;
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

  /// Create a copy of PropertiesListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PropertiesListResponseImplCopyWith<_$PropertiesListResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}
