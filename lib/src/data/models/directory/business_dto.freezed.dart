// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BusinessDto _$BusinessDtoFromJson(Map<String, dynamic> json) {
  return _BusinessDto.fromJson(json);
}

/// @nodoc
mixin _$BusinessDto {
  dynamic get id => throw _privateConstructorUsedError;
  dynamic get name => throw _privateConstructorUsedError;
  dynamic get slug => throw _privateConstructorUsedError;
  dynamic get category => throw _privateConstructorUsedError;
  dynamic get description => throw _privateConstructorUsedError;
  dynamic get logo => throw _privateConstructorUsedError;
  dynamic get phone => throw _privateConstructorUsedError;
  dynamic get email => throw _privateConstructorUsedError;
  dynamic get website => throw _privateConstructorUsedError;
  dynamic get address => throw _privateConstructorUsedError;
  dynamic get city => throw _privateConstructorUsedError;
  dynamic get district => throw _privateConstructorUsedError;
  dynamic get geo => throw _privateConstructorUsedError;
  @JsonKey(name: 'social')
  dynamic get socialLinks => throw _privateConstructorUsedError;
  List<dynamic> get businessHours => throw _privateConstructorUsedError;
  List<dynamic> get services => throw _privateConstructorUsedError;
  List<dynamic> get tags => throw _privateConstructorUsedError;
  bool get isFeatured => throw _privateConstructorUsedError;
  int get viewCount => throw _privateConstructorUsedError;
  dynamic get createdAt => throw _privateConstructorUsedError;

  /// Serializes this BusinessDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BusinessDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusinessDtoCopyWith<BusinessDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessDtoCopyWith<$Res> {
  factory $BusinessDtoCopyWith(
    BusinessDto value,
    $Res Function(BusinessDto) then,
  ) = _$BusinessDtoCopyWithImpl<$Res, BusinessDto>;
  @useResult
  $Res call({
    dynamic id,
    dynamic name,
    dynamic slug,
    dynamic category,
    dynamic description,
    dynamic logo,
    dynamic phone,
    dynamic email,
    dynamic website,
    dynamic address,
    dynamic city,
    dynamic district,
    dynamic geo,
    @JsonKey(name: 'social') dynamic socialLinks,
    List<dynamic> businessHours,
    List<dynamic> services,
    List<dynamic> tags,
    bool isFeatured,
    int viewCount,
    dynamic createdAt,
  });
}

/// @nodoc
class _$BusinessDtoCopyWithImpl<$Res, $Val extends BusinessDto>
    implements $BusinessDtoCopyWith<$Res> {
  _$BusinessDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusinessDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? slug = freezed,
    Object? category = freezed,
    Object? description = freezed,
    Object? logo = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? website = freezed,
    Object? address = freezed,
    Object? city = freezed,
    Object? district = freezed,
    Object? geo = freezed,
    Object? socialLinks = freezed,
    Object? businessHours = null,
    Object? services = null,
    Object? tags = null,
    Object? isFeatured = null,
    Object? viewCount = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            slug: freezed == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            logo: freezed == logo
                ? _value.logo
                : logo // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            website: freezed == website
                ? _value.website
                : website // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            city: freezed == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            district: freezed == district
                ? _value.district
                : district // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            geo: freezed == geo
                ? _value.geo
                : geo // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            socialLinks: freezed == socialLinks
                ? _value.socialLinks
                : socialLinks // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            businessHours: null == businessHours
                ? _value.businessHours
                : businessHours // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>,
            services: null == services
                ? _value.services
                : services // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>,
            isFeatured: null == isFeatured
                ? _value.isFeatured
                : isFeatured // ignore: cast_nullable_to_non_nullable
                      as bool,
            viewCount: null == viewCount
                ? _value.viewCount
                : viewCount // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as dynamic,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BusinessDtoImplCopyWith<$Res>
    implements $BusinessDtoCopyWith<$Res> {
  factory _$$BusinessDtoImplCopyWith(
    _$BusinessDtoImpl value,
    $Res Function(_$BusinessDtoImpl) then,
  ) = __$$BusinessDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    dynamic id,
    dynamic name,
    dynamic slug,
    dynamic category,
    dynamic description,
    dynamic logo,
    dynamic phone,
    dynamic email,
    dynamic website,
    dynamic address,
    dynamic city,
    dynamic district,
    dynamic geo,
    @JsonKey(name: 'social') dynamic socialLinks,
    List<dynamic> businessHours,
    List<dynamic> services,
    List<dynamic> tags,
    bool isFeatured,
    int viewCount,
    dynamic createdAt,
  });
}

/// @nodoc
class __$$BusinessDtoImplCopyWithImpl<$Res>
    extends _$BusinessDtoCopyWithImpl<$Res, _$BusinessDtoImpl>
    implements _$$BusinessDtoImplCopyWith<$Res> {
  __$$BusinessDtoImplCopyWithImpl(
    _$BusinessDtoImpl _value,
    $Res Function(_$BusinessDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BusinessDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? slug = freezed,
    Object? category = freezed,
    Object? description = freezed,
    Object? logo = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? website = freezed,
    Object? address = freezed,
    Object? city = freezed,
    Object? district = freezed,
    Object? geo = freezed,
    Object? socialLinks = freezed,
    Object? businessHours = null,
    Object? services = null,
    Object? tags = null,
    Object? isFeatured = null,
    Object? viewCount = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$BusinessDtoImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        slug: freezed == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        logo: freezed == logo
            ? _value.logo
            : logo // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        website: freezed == website
            ? _value.website
            : website // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        city: freezed == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        district: freezed == district
            ? _value.district
            : district // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        geo: freezed == geo
            ? _value.geo
            : geo // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        socialLinks: freezed == socialLinks
            ? _value.socialLinks
            : socialLinks // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        businessHours: null == businessHours
            ? _value._businessHours
            : businessHours // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>,
        services: null == services
            ? _value._services
            : services // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>,
        isFeatured: null == isFeatured
            ? _value.isFeatured
            : isFeatured // ignore: cast_nullable_to_non_nullable
                  as bool,
        viewCount: null == viewCount
            ? _value.viewCount
            : viewCount // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as dynamic,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BusinessDtoImpl implements _BusinessDto {
  const _$BusinessDtoImpl({
    required this.id,
    required this.name,
    required this.slug,
    required this.category,
    this.description,
    this.logo,
    this.phone,
    this.email,
    this.website,
    this.address,
    this.city,
    this.district,
    this.geo,
    @JsonKey(name: 'social') this.socialLinks,
    final List<dynamic> businessHours = const [],
    final List<dynamic> services = const [],
    final List<dynamic> tags = const [],
    this.isFeatured = false,
    this.viewCount = 0,
    this.createdAt,
  }) : _businessHours = businessHours,
       _services = services,
       _tags = tags;

  factory _$BusinessDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusinessDtoImplFromJson(json);

  @override
  final dynamic id;
  @override
  final dynamic name;
  @override
  final dynamic slug;
  @override
  final dynamic category;
  @override
  final dynamic description;
  @override
  final dynamic logo;
  @override
  final dynamic phone;
  @override
  final dynamic email;
  @override
  final dynamic website;
  @override
  final dynamic address;
  @override
  final dynamic city;
  @override
  final dynamic district;
  @override
  final dynamic geo;
  @override
  @JsonKey(name: 'social')
  final dynamic socialLinks;
  final List<dynamic> _businessHours;
  @override
  @JsonKey()
  List<dynamic> get businessHours {
    if (_businessHours is EqualUnmodifiableListView) return _businessHours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_businessHours);
  }

  final List<dynamic> _services;
  @override
  @JsonKey()
  List<dynamic> get services {
    if (_services is EqualUnmodifiableListView) return _services;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_services);
  }

  final List<dynamic> _tags;
  @override
  @JsonKey()
  List<dynamic> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey()
  final bool isFeatured;
  @override
  @JsonKey()
  final int viewCount;
  @override
  final dynamic createdAt;

  @override
  String toString() {
    return 'BusinessDto(id: $id, name: $name, slug: $slug, category: $category, description: $description, logo: $logo, phone: $phone, email: $email, website: $website, address: $address, city: $city, district: $district, geo: $geo, socialLinks: $socialLinks, businessHours: $businessHours, services: $services, tags: $tags, isFeatured: $isFeatured, viewCount: $viewCount, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessDtoImpl &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.slug, slug) &&
            const DeepCollectionEquality().equals(other.category, category) &&
            const DeepCollectionEquality().equals(
              other.description,
              description,
            ) &&
            const DeepCollectionEquality().equals(other.logo, logo) &&
            const DeepCollectionEquality().equals(other.phone, phone) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.website, website) &&
            const DeepCollectionEquality().equals(other.address, address) &&
            const DeepCollectionEquality().equals(other.city, city) &&
            const DeepCollectionEquality().equals(other.district, district) &&
            const DeepCollectionEquality().equals(other.geo, geo) &&
            const DeepCollectionEquality().equals(
              other.socialLinks,
              socialLinks,
            ) &&
            const DeepCollectionEquality().equals(
              other._businessHours,
              _businessHours,
            ) &&
            const DeepCollectionEquality().equals(other._services, _services) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    const DeepCollectionEquality().hash(id),
    const DeepCollectionEquality().hash(name),
    const DeepCollectionEquality().hash(slug),
    const DeepCollectionEquality().hash(category),
    const DeepCollectionEquality().hash(description),
    const DeepCollectionEquality().hash(logo),
    const DeepCollectionEquality().hash(phone),
    const DeepCollectionEquality().hash(email),
    const DeepCollectionEquality().hash(website),
    const DeepCollectionEquality().hash(address),
    const DeepCollectionEquality().hash(city),
    const DeepCollectionEquality().hash(district),
    const DeepCollectionEquality().hash(geo),
    const DeepCollectionEquality().hash(socialLinks),
    const DeepCollectionEquality().hash(_businessHours),
    const DeepCollectionEquality().hash(_services),
    const DeepCollectionEquality().hash(_tags),
    isFeatured,
    viewCount,
    const DeepCollectionEquality().hash(createdAt),
  ]);

  /// Create a copy of BusinessDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessDtoImplCopyWith<_$BusinessDtoImpl> get copyWith =>
      __$$BusinessDtoImplCopyWithImpl<_$BusinessDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusinessDtoImplToJson(this);
  }
}

abstract class _BusinessDto implements BusinessDto {
  const factory _BusinessDto({
    required final dynamic id,
    required final dynamic name,
    required final dynamic slug,
    required final dynamic category,
    final dynamic description,
    final dynamic logo,
    final dynamic phone,
    final dynamic email,
    final dynamic website,
    final dynamic address,
    final dynamic city,
    final dynamic district,
    final dynamic geo,
    @JsonKey(name: 'social') final dynamic socialLinks,
    final List<dynamic> businessHours,
    final List<dynamic> services,
    final List<dynamic> tags,
    final bool isFeatured,
    final int viewCount,
    final dynamic createdAt,
  }) = _$BusinessDtoImpl;

  factory _BusinessDto.fromJson(Map<String, dynamic> json) =
      _$BusinessDtoImpl.fromJson;

  @override
  dynamic get id;
  @override
  dynamic get name;
  @override
  dynamic get slug;
  @override
  dynamic get category;
  @override
  dynamic get description;
  @override
  dynamic get logo;
  @override
  dynamic get phone;
  @override
  dynamic get email;
  @override
  dynamic get website;
  @override
  dynamic get address;
  @override
  dynamic get city;
  @override
  dynamic get district;
  @override
  dynamic get geo;
  @override
  @JsonKey(name: 'social')
  dynamic get socialLinks;
  @override
  List<dynamic> get businessHours;
  @override
  List<dynamic> get services;
  @override
  List<dynamic> get tags;
  @override
  bool get isFeatured;
  @override
  int get viewCount;
  @override
  dynamic get createdAt;

  /// Create a copy of BusinessDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusinessDtoImplCopyWith<_$BusinessDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GeoLocationDto _$GeoLocationDtoFromJson(Map<String, dynamic> json) {
  return _GeoLocationDto.fromJson(json);
}

/// @nodoc
mixin _$GeoLocationDto {
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;

  /// Serializes this GeoLocationDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GeoLocationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GeoLocationDtoCopyWith<GeoLocationDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeoLocationDtoCopyWith<$Res> {
  factory $GeoLocationDtoCopyWith(
    GeoLocationDto value,
    $Res Function(GeoLocationDto) then,
  ) = _$GeoLocationDtoCopyWithImpl<$Res, GeoLocationDto>;
  @useResult
  $Res call({double? latitude, double? longitude});
}

/// @nodoc
class _$GeoLocationDtoCopyWithImpl<$Res, $Val extends GeoLocationDto>
    implements $GeoLocationDtoCopyWith<$Res> {
  _$GeoLocationDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GeoLocationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? latitude = freezed, Object? longitude = freezed}) {
    return _then(
      _value.copyWith(
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GeoLocationDtoImplCopyWith<$Res>
    implements $GeoLocationDtoCopyWith<$Res> {
  factory _$$GeoLocationDtoImplCopyWith(
    _$GeoLocationDtoImpl value,
    $Res Function(_$GeoLocationDtoImpl) then,
  ) = __$$GeoLocationDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double? latitude, double? longitude});
}

/// @nodoc
class __$$GeoLocationDtoImplCopyWithImpl<$Res>
    extends _$GeoLocationDtoCopyWithImpl<$Res, _$GeoLocationDtoImpl>
    implements _$$GeoLocationDtoImplCopyWith<$Res> {
  __$$GeoLocationDtoImplCopyWithImpl(
    _$GeoLocationDtoImpl _value,
    $Res Function(_$GeoLocationDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GeoLocationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? latitude = freezed, Object? longitude = freezed}) {
    return _then(
      _$GeoLocationDtoImpl(
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GeoLocationDtoImpl implements _GeoLocationDto {
  const _$GeoLocationDtoImpl({this.latitude, this.longitude});

  factory _$GeoLocationDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeoLocationDtoImplFromJson(json);

  @override
  final double? latitude;
  @override
  final double? longitude;

  @override
  String toString() {
    return 'GeoLocationDto(latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeoLocationDtoImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, latitude, longitude);

  /// Create a copy of GeoLocationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GeoLocationDtoImplCopyWith<_$GeoLocationDtoImpl> get copyWith =>
      __$$GeoLocationDtoImplCopyWithImpl<_$GeoLocationDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GeoLocationDtoImplToJson(this);
  }
}

abstract class _GeoLocationDto implements GeoLocationDto {
  const factory _GeoLocationDto({
    final double? latitude,
    final double? longitude,
  }) = _$GeoLocationDtoImpl;

  factory _GeoLocationDto.fromJson(Map<String, dynamic> json) =
      _$GeoLocationDtoImpl.fromJson;

  @override
  double? get latitude;
  @override
  double? get longitude;

  /// Create a copy of GeoLocationDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GeoLocationDtoImplCopyWith<_$GeoLocationDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SocialLinksDto _$SocialLinksDtoFromJson(Map<String, dynamic> json) {
  return _SocialLinksDto.fromJson(json);
}

/// @nodoc
mixin _$SocialLinksDto {
  String? get facebook => throw _privateConstructorUsedError;
  String? get twitter => throw _privateConstructorUsedError;
  String? get instagram => throw _privateConstructorUsedError;
  String? get linkedin => throw _privateConstructorUsedError;

  /// Serializes this SocialLinksDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SocialLinksDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SocialLinksDtoCopyWith<SocialLinksDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SocialLinksDtoCopyWith<$Res> {
  factory $SocialLinksDtoCopyWith(
    SocialLinksDto value,
    $Res Function(SocialLinksDto) then,
  ) = _$SocialLinksDtoCopyWithImpl<$Res, SocialLinksDto>;
  @useResult
  $Res call({
    String? facebook,
    String? twitter,
    String? instagram,
    String? linkedin,
  });
}

/// @nodoc
class _$SocialLinksDtoCopyWithImpl<$Res, $Val extends SocialLinksDto>
    implements $SocialLinksDtoCopyWith<$Res> {
  _$SocialLinksDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SocialLinksDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? facebook = freezed,
    Object? twitter = freezed,
    Object? instagram = freezed,
    Object? linkedin = freezed,
  }) {
    return _then(
      _value.copyWith(
            facebook: freezed == facebook
                ? _value.facebook
                : facebook // ignore: cast_nullable_to_non_nullable
                      as String?,
            twitter: freezed == twitter
                ? _value.twitter
                : twitter // ignore: cast_nullable_to_non_nullable
                      as String?,
            instagram: freezed == instagram
                ? _value.instagram
                : instagram // ignore: cast_nullable_to_non_nullable
                      as String?,
            linkedin: freezed == linkedin
                ? _value.linkedin
                : linkedin // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SocialLinksDtoImplCopyWith<$Res>
    implements $SocialLinksDtoCopyWith<$Res> {
  factory _$$SocialLinksDtoImplCopyWith(
    _$SocialLinksDtoImpl value,
    $Res Function(_$SocialLinksDtoImpl) then,
  ) = __$$SocialLinksDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? facebook,
    String? twitter,
    String? instagram,
    String? linkedin,
  });
}

/// @nodoc
class __$$SocialLinksDtoImplCopyWithImpl<$Res>
    extends _$SocialLinksDtoCopyWithImpl<$Res, _$SocialLinksDtoImpl>
    implements _$$SocialLinksDtoImplCopyWith<$Res> {
  __$$SocialLinksDtoImplCopyWithImpl(
    _$SocialLinksDtoImpl _value,
    $Res Function(_$SocialLinksDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SocialLinksDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? facebook = freezed,
    Object? twitter = freezed,
    Object? instagram = freezed,
    Object? linkedin = freezed,
  }) {
    return _then(
      _$SocialLinksDtoImpl(
        facebook: freezed == facebook
            ? _value.facebook
            : facebook // ignore: cast_nullable_to_non_nullable
                  as String?,
        twitter: freezed == twitter
            ? _value.twitter
            : twitter // ignore: cast_nullable_to_non_nullable
                  as String?,
        instagram: freezed == instagram
            ? _value.instagram
            : instagram // ignore: cast_nullable_to_non_nullable
                  as String?,
        linkedin: freezed == linkedin
            ? _value.linkedin
            : linkedin // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SocialLinksDtoImpl implements _SocialLinksDto {
  const _$SocialLinksDtoImpl({
    this.facebook,
    this.twitter,
    this.instagram,
    this.linkedin,
  });

  factory _$SocialLinksDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SocialLinksDtoImplFromJson(json);

  @override
  final String? facebook;
  @override
  final String? twitter;
  @override
  final String? instagram;
  @override
  final String? linkedin;

  @override
  String toString() {
    return 'SocialLinksDto(facebook: $facebook, twitter: $twitter, instagram: $instagram, linkedin: $linkedin)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SocialLinksDtoImpl &&
            (identical(other.facebook, facebook) ||
                other.facebook == facebook) &&
            (identical(other.twitter, twitter) || other.twitter == twitter) &&
            (identical(other.instagram, instagram) ||
                other.instagram == instagram) &&
            (identical(other.linkedin, linkedin) ||
                other.linkedin == linkedin));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, facebook, twitter, instagram, linkedin);

  /// Create a copy of SocialLinksDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SocialLinksDtoImplCopyWith<_$SocialLinksDtoImpl> get copyWith =>
      __$$SocialLinksDtoImplCopyWithImpl<_$SocialLinksDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SocialLinksDtoImplToJson(this);
  }
}

abstract class _SocialLinksDto implements SocialLinksDto {
  const factory _SocialLinksDto({
    final String? facebook,
    final String? twitter,
    final String? instagram,
    final String? linkedin,
  }) = _$SocialLinksDtoImpl;

  factory _SocialLinksDto.fromJson(Map<String, dynamic> json) =
      _$SocialLinksDtoImpl.fromJson;

  @override
  String? get facebook;
  @override
  String? get twitter;
  @override
  String? get instagram;
  @override
  String? get linkedin;

  /// Create a copy of SocialLinksDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SocialLinksDtoImplCopyWith<_$SocialLinksDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BusinessHoursDto _$BusinessHoursDtoFromJson(Map<String, dynamic> json) {
  return _BusinessHoursDto.fromJson(json);
}

/// @nodoc
mixin _$BusinessHoursDto {
  String get day => throw _privateConstructorUsedError;
  @JsonKey(name: 'openTime')
  String? get open => throw _privateConstructorUsedError;
  @JsonKey(name: 'closeTime')
  String? get close => throw _privateConstructorUsedError;
  bool get isClosed => throw _privateConstructorUsedError;

  /// Serializes this BusinessHoursDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BusinessHoursDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusinessHoursDtoCopyWith<BusinessHoursDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessHoursDtoCopyWith<$Res> {
  factory $BusinessHoursDtoCopyWith(
    BusinessHoursDto value,
    $Res Function(BusinessHoursDto) then,
  ) = _$BusinessHoursDtoCopyWithImpl<$Res, BusinessHoursDto>;
  @useResult
  $Res call({
    String day,
    @JsonKey(name: 'openTime') String? open,
    @JsonKey(name: 'closeTime') String? close,
    bool isClosed,
  });
}

/// @nodoc
class _$BusinessHoursDtoCopyWithImpl<$Res, $Val extends BusinessHoursDto>
    implements $BusinessHoursDtoCopyWith<$Res> {
  _$BusinessHoursDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusinessHoursDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? open = freezed,
    Object? close = freezed,
    Object? isClosed = null,
  }) {
    return _then(
      _value.copyWith(
            day: null == day
                ? _value.day
                : day // ignore: cast_nullable_to_non_nullable
                      as String,
            open: freezed == open
                ? _value.open
                : open // ignore: cast_nullable_to_non_nullable
                      as String?,
            close: freezed == close
                ? _value.close
                : close // ignore: cast_nullable_to_non_nullable
                      as String?,
            isClosed: null == isClosed
                ? _value.isClosed
                : isClosed // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BusinessHoursDtoImplCopyWith<$Res>
    implements $BusinessHoursDtoCopyWith<$Res> {
  factory _$$BusinessHoursDtoImplCopyWith(
    _$BusinessHoursDtoImpl value,
    $Res Function(_$BusinessHoursDtoImpl) then,
  ) = __$$BusinessHoursDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String day,
    @JsonKey(name: 'openTime') String? open,
    @JsonKey(name: 'closeTime') String? close,
    bool isClosed,
  });
}

/// @nodoc
class __$$BusinessHoursDtoImplCopyWithImpl<$Res>
    extends _$BusinessHoursDtoCopyWithImpl<$Res, _$BusinessHoursDtoImpl>
    implements _$$BusinessHoursDtoImplCopyWith<$Res> {
  __$$BusinessHoursDtoImplCopyWithImpl(
    _$BusinessHoursDtoImpl _value,
    $Res Function(_$BusinessHoursDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BusinessHoursDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? open = freezed,
    Object? close = freezed,
    Object? isClosed = null,
  }) {
    return _then(
      _$BusinessHoursDtoImpl(
        day: null == day
            ? _value.day
            : day // ignore: cast_nullable_to_non_nullable
                  as String,
        open: freezed == open
            ? _value.open
            : open // ignore: cast_nullable_to_non_nullable
                  as String?,
        close: freezed == close
            ? _value.close
            : close // ignore: cast_nullable_to_non_nullable
                  as String?,
        isClosed: null == isClosed
            ? _value.isClosed
            : isClosed // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BusinessHoursDtoImpl implements _BusinessHoursDto {
  const _$BusinessHoursDtoImpl({
    required this.day,
    @JsonKey(name: 'openTime') this.open,
    @JsonKey(name: 'closeTime') this.close,
    this.isClosed = false,
  });

  factory _$BusinessHoursDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusinessHoursDtoImplFromJson(json);

  @override
  final String day;
  @override
  @JsonKey(name: 'openTime')
  final String? open;
  @override
  @JsonKey(name: 'closeTime')
  final String? close;
  @override
  @JsonKey()
  final bool isClosed;

  @override
  String toString() {
    return 'BusinessHoursDto(day: $day, open: $open, close: $close, isClosed: $isClosed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessHoursDtoImpl &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.open, open) || other.open == open) &&
            (identical(other.close, close) || other.close == close) &&
            (identical(other.isClosed, isClosed) ||
                other.isClosed == isClosed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, day, open, close, isClosed);

  /// Create a copy of BusinessHoursDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessHoursDtoImplCopyWith<_$BusinessHoursDtoImpl> get copyWith =>
      __$$BusinessHoursDtoImplCopyWithImpl<_$BusinessHoursDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BusinessHoursDtoImplToJson(this);
  }
}

abstract class _BusinessHoursDto implements BusinessHoursDto {
  const factory _BusinessHoursDto({
    required final String day,
    @JsonKey(name: 'openTime') final String? open,
    @JsonKey(name: 'closeTime') final String? close,
    final bool isClosed,
  }) = _$BusinessHoursDtoImpl;

  factory _BusinessHoursDto.fromJson(Map<String, dynamic> json) =
      _$BusinessHoursDtoImpl.fromJson;

  @override
  String get day;
  @override
  @JsonKey(name: 'openTime')
  String? get open;
  @override
  @JsonKey(name: 'closeTime')
  String? get close;
  @override
  bool get isClosed;

  /// Create a copy of BusinessHoursDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusinessHoursDtoImplCopyWith<_$BusinessHoursDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BusinessesListResponse _$BusinessesListResponseFromJson(
  Map<String, dynamic> json,
) {
  return _BusinessesListResponse.fromJson(json);
}

/// @nodoc
mixin _$BusinessesListResponse {
  List<BusinessDto> get docs => throw _privateConstructorUsedError;
  int get totalDocs => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  bool get hasNextPage => throw _privateConstructorUsedError;
  bool get hasPrevPage => throw _privateConstructorUsedError;

  /// Serializes this BusinessesListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BusinessesListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusinessesListResponseCopyWith<BusinessesListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessesListResponseCopyWith<$Res> {
  factory $BusinessesListResponseCopyWith(
    BusinessesListResponse value,
    $Res Function(BusinessesListResponse) then,
  ) = _$BusinessesListResponseCopyWithImpl<$Res, BusinessesListResponse>;
  @useResult
  $Res call({
    List<BusinessDto> docs,
    int totalDocs,
    int limit,
    int page,
    int totalPages,
    bool hasNextPage,
    bool hasPrevPage,
  });
}

/// @nodoc
class _$BusinessesListResponseCopyWithImpl<
  $Res,
  $Val extends BusinessesListResponse
>
    implements $BusinessesListResponseCopyWith<$Res> {
  _$BusinessesListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusinessesListResponse
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
                      as List<BusinessDto>,
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
abstract class _$$BusinessesListResponseImplCopyWith<$Res>
    implements $BusinessesListResponseCopyWith<$Res> {
  factory _$$BusinessesListResponseImplCopyWith(
    _$BusinessesListResponseImpl value,
    $Res Function(_$BusinessesListResponseImpl) then,
  ) = __$$BusinessesListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<BusinessDto> docs,
    int totalDocs,
    int limit,
    int page,
    int totalPages,
    bool hasNextPage,
    bool hasPrevPage,
  });
}

/// @nodoc
class __$$BusinessesListResponseImplCopyWithImpl<$Res>
    extends
        _$BusinessesListResponseCopyWithImpl<$Res, _$BusinessesListResponseImpl>
    implements _$$BusinessesListResponseImplCopyWith<$Res> {
  __$$BusinessesListResponseImplCopyWithImpl(
    _$BusinessesListResponseImpl _value,
    $Res Function(_$BusinessesListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BusinessesListResponse
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
      _$BusinessesListResponseImpl(
        docs: null == docs
            ? _value._docs
            : docs // ignore: cast_nullable_to_non_nullable
                  as List<BusinessDto>,
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
class _$BusinessesListResponseImpl implements _BusinessesListResponse {
  const _$BusinessesListResponseImpl({
    required final List<BusinessDto> docs,
    required this.totalDocs,
    required this.limit,
    required this.page,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPrevPage,
  }) : _docs = docs;

  factory _$BusinessesListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusinessesListResponseImplFromJson(json);

  final List<BusinessDto> _docs;
  @override
  List<BusinessDto> get docs {
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
    return 'BusinessesListResponse(docs: $docs, totalDocs: $totalDocs, limit: $limit, page: $page, totalPages: $totalPages, hasNextPage: $hasNextPage, hasPrevPage: $hasPrevPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessesListResponseImpl &&
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

  /// Create a copy of BusinessesListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessesListResponseImplCopyWith<_$BusinessesListResponseImpl>
  get copyWith =>
      __$$BusinessesListResponseImplCopyWithImpl<_$BusinessesListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BusinessesListResponseImplToJson(this);
  }
}

abstract class _BusinessesListResponse implements BusinessesListResponse {
  const factory _BusinessesListResponse({
    required final List<BusinessDto> docs,
    required final int totalDocs,
    required final int limit,
    required final int page,
    required final int totalPages,
    required final bool hasNextPage,
    required final bool hasPrevPage,
  }) = _$BusinessesListResponseImpl;

  factory _BusinessesListResponse.fromJson(Map<String, dynamic> json) =
      _$BusinessesListResponseImpl.fromJson;

  @override
  List<BusinessDto> get docs;
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

  /// Create a copy of BusinessesListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusinessesListResponseImplCopyWith<_$BusinessesListResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}
