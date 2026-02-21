// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'property.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Property {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  PropertyType get type => throw _privateConstructorUsedError;
  PropertyStatus get status => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get agentId => throw _privateConstructorUsedError;
  String? get agentName => throw _privateConstructorUsedError;
  String? get agentPhone => throw _privateConstructorUsedError;
  String? get agentEmail => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;
  List<String> get amenities => throw _privateConstructorUsedError;
  double? get size => throw _privateConstructorUsedError;
  int? get bedrooms => throw _privateConstructorUsedError;
  int? get bathrooms => throw _privateConstructorUsedError;
  int? get yearBuilt => throw _privateConstructorUsedError;
  bool? get isFeatured => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  int? get bidCount => throw _privateConstructorUsedError;
  double? get highestBid => throw _privateConstructorUsedError;

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PropertyCopyWith<Property> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PropertyCopyWith<$Res> {
  factory $PropertyCopyWith(Property value, $Res Function(Property) then) =
      _$PropertyCopyWithImpl<$Res, Property>;
  @useResult
  $Res call({
    String id,
    String title,
    PropertyType type,
    PropertyStatus status,
    double price,
    String location,
    String description,
    String? agentId,
    String? agentName,
    String? agentPhone,
    String? agentEmail,
    List<String> images,
    List<String> amenities,
    double? size,
    int? bedrooms,
    int? bathrooms,
    int? yearBuilt,
    bool? isFeatured,
    DateTime? createdAt,
    int? bidCount,
    double? highestBid,
  });
}

/// @nodoc
class _$PropertyCopyWithImpl<$Res, $Val extends Property>
    implements $PropertyCopyWith<$Res> {
  _$PropertyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? type = null,
    Object? status = null,
    Object? price = null,
    Object? location = null,
    Object? description = null,
    Object? agentId = freezed,
    Object? agentName = freezed,
    Object? agentPhone = freezed,
    Object? agentEmail = freezed,
    Object? images = null,
    Object? amenities = null,
    Object? size = freezed,
    Object? bedrooms = freezed,
    Object? bathrooms = freezed,
    Object? yearBuilt = freezed,
    Object? isFeatured = freezed,
    Object? createdAt = freezed,
    Object? bidCount = freezed,
    Object? highestBid = freezed,
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
                      as PropertyType,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as PropertyStatus,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
            location: null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            agentId: freezed == agentId
                ? _value.agentId
                : agentId // ignore: cast_nullable_to_non_nullable
                      as String?,
            agentName: freezed == agentName
                ? _value.agentName
                : agentName // ignore: cast_nullable_to_non_nullable
                      as String?,
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
                      as List<String>,
            amenities: null == amenities
                ? _value.amenities
                : amenities // ignore: cast_nullable_to_non_nullable
                      as List<String>,
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
            yearBuilt: freezed == yearBuilt
                ? _value.yearBuilt
                : yearBuilt // ignore: cast_nullable_to_non_nullable
                      as int?,
            isFeatured: freezed == isFeatured
                ? _value.isFeatured
                : isFeatured // ignore: cast_nullable_to_non_nullable
                      as bool?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            bidCount: freezed == bidCount
                ? _value.bidCount
                : bidCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            highestBid: freezed == highestBid
                ? _value.highestBid
                : highestBid // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PropertyImplCopyWith<$Res>
    implements $PropertyCopyWith<$Res> {
  factory _$$PropertyImplCopyWith(
    _$PropertyImpl value,
    $Res Function(_$PropertyImpl) then,
  ) = __$$PropertyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    PropertyType type,
    PropertyStatus status,
    double price,
    String location,
    String description,
    String? agentId,
    String? agentName,
    String? agentPhone,
    String? agentEmail,
    List<String> images,
    List<String> amenities,
    double? size,
    int? bedrooms,
    int? bathrooms,
    int? yearBuilt,
    bool? isFeatured,
    DateTime? createdAt,
    int? bidCount,
    double? highestBid,
  });
}

/// @nodoc
class __$$PropertyImplCopyWithImpl<$Res>
    extends _$PropertyCopyWithImpl<$Res, _$PropertyImpl>
    implements _$$PropertyImplCopyWith<$Res> {
  __$$PropertyImplCopyWithImpl(
    _$PropertyImpl _value,
    $Res Function(_$PropertyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? type = null,
    Object? status = null,
    Object? price = null,
    Object? location = null,
    Object? description = null,
    Object? agentId = freezed,
    Object? agentName = freezed,
    Object? agentPhone = freezed,
    Object? agentEmail = freezed,
    Object? images = null,
    Object? amenities = null,
    Object? size = freezed,
    Object? bedrooms = freezed,
    Object? bathrooms = freezed,
    Object? yearBuilt = freezed,
    Object? isFeatured = freezed,
    Object? createdAt = freezed,
    Object? bidCount = freezed,
    Object? highestBid = freezed,
  }) {
    return _then(
      _$PropertyImpl(
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
                  as PropertyType,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as PropertyStatus,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
        location: null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        agentId: freezed == agentId
            ? _value.agentId
            : agentId // ignore: cast_nullable_to_non_nullable
                  as String?,
        agentName: freezed == agentName
            ? _value.agentName
            : agentName // ignore: cast_nullable_to_non_nullable
                  as String?,
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
                  as List<String>,
        amenities: null == amenities
            ? _value._amenities
            : amenities // ignore: cast_nullable_to_non_nullable
                  as List<String>,
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
        yearBuilt: freezed == yearBuilt
            ? _value.yearBuilt
            : yearBuilt // ignore: cast_nullable_to_non_nullable
                  as int?,
        isFeatured: freezed == isFeatured
            ? _value.isFeatured
            : isFeatured // ignore: cast_nullable_to_non_nullable
                  as bool?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        bidCount: freezed == bidCount
            ? _value.bidCount
            : bidCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        highestBid: freezed == highestBid
            ? _value.highestBid
            : highestBid // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc

class _$PropertyImpl extends _Property {
  const _$PropertyImpl({
    required this.id,
    required this.title,
    required this.type,
    required this.status,
    required this.price,
    required this.location,
    required this.description,
    this.agentId,
    this.agentName,
    this.agentPhone,
    this.agentEmail,
    final List<String> images = const [],
    final List<String> amenities = const [],
    this.size,
    this.bedrooms,
    this.bathrooms,
    this.yearBuilt,
    this.isFeatured,
    this.createdAt,
    this.bidCount,
    this.highestBid,
  }) : _images = images,
       _amenities = amenities,
       super._();

  @override
  final String id;
  @override
  final String title;
  @override
  final PropertyType type;
  @override
  final PropertyStatus status;
  @override
  final double price;
  @override
  final String location;
  @override
  final String description;
  @override
  final String? agentId;
  @override
  final String? agentName;
  @override
  final String? agentPhone;
  @override
  final String? agentEmail;
  final List<String> _images;
  @override
  @JsonKey()
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  final List<String> _amenities;
  @override
  @JsonKey()
  List<String> get amenities {
    if (_amenities is EqualUnmodifiableListView) return _amenities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_amenities);
  }

  @override
  final double? size;
  @override
  final int? bedrooms;
  @override
  final int? bathrooms;
  @override
  final int? yearBuilt;
  @override
  final bool? isFeatured;
  @override
  final DateTime? createdAt;
  @override
  final int? bidCount;
  @override
  final double? highestBid;

  @override
  String toString() {
    return 'Property(id: $id, title: $title, type: $type, status: $status, price: $price, location: $location, description: $description, agentId: $agentId, agentName: $agentName, agentPhone: $agentPhone, agentEmail: $agentEmail, images: $images, amenities: $amenities, size: $size, bedrooms: $bedrooms, bathrooms: $bathrooms, yearBuilt: $yearBuilt, isFeatured: $isFeatured, createdAt: $createdAt, bidCount: $bidCount, highestBid: $highestBid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PropertyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.agentId, agentId) || other.agentId == agentId) &&
            (identical(other.agentName, agentName) ||
                other.agentName == agentName) &&
            (identical(other.agentPhone, agentPhone) ||
                other.agentPhone == agentPhone) &&
            (identical(other.agentEmail, agentEmail) ||
                other.agentEmail == agentEmail) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            const DeepCollectionEquality().equals(
              other._amenities,
              _amenities,
            ) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.bedrooms, bedrooms) ||
                other.bedrooms == bedrooms) &&
            (identical(other.bathrooms, bathrooms) ||
                other.bathrooms == bathrooms) &&
            (identical(other.yearBuilt, yearBuilt) ||
                other.yearBuilt == yearBuilt) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.bidCount, bidCount) ||
                other.bidCount == bidCount) &&
            (identical(other.highestBid, highestBid) ||
                other.highestBid == highestBid));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    title,
    type,
    status,
    price,
    location,
    description,
    agentId,
    agentName,
    agentPhone,
    agentEmail,
    const DeepCollectionEquality().hash(_images),
    const DeepCollectionEquality().hash(_amenities),
    size,
    bedrooms,
    bathrooms,
    yearBuilt,
    isFeatured,
    createdAt,
    bidCount,
    highestBid,
  ]);

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PropertyImplCopyWith<_$PropertyImpl> get copyWith =>
      __$$PropertyImplCopyWithImpl<_$PropertyImpl>(this, _$identity);
}

abstract class _Property extends Property {
  const factory _Property({
    required final String id,
    required final String title,
    required final PropertyType type,
    required final PropertyStatus status,
    required final double price,
    required final String location,
    required final String description,
    final String? agentId,
    final String? agentName,
    final String? agentPhone,
    final String? agentEmail,
    final List<String> images,
    final List<String> amenities,
    final double? size,
    final int? bedrooms,
    final int? bathrooms,
    final int? yearBuilt,
    final bool? isFeatured,
    final DateTime? createdAt,
    final int? bidCount,
    final double? highestBid,
  }) = _$PropertyImpl;
  const _Property._() : super._();

  @override
  String get id;
  @override
  String get title;
  @override
  PropertyType get type;
  @override
  PropertyStatus get status;
  @override
  double get price;
  @override
  String get location;
  @override
  String get description;
  @override
  String? get agentId;
  @override
  String? get agentName;
  @override
  String? get agentPhone;
  @override
  String? get agentEmail;
  @override
  List<String> get images;
  @override
  List<String> get amenities;
  @override
  double? get size;
  @override
  int? get bedrooms;
  @override
  int? get bathrooms;
  @override
  int? get yearBuilt;
  @override
  bool? get isFeatured;
  @override
  DateTime? get createdAt;
  @override
  int? get bidCount;
  @override
  double? get highestBid;

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PropertyImplCopyWith<_$PropertyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
