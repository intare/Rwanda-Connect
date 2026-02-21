// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Business {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  BusinessCategory get category => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get logo => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get district => throw _privateConstructorUsedError;
  GeoLocation? get geo => throw _privateConstructorUsedError;
  SocialLinks? get socialLinks => throw _privateConstructorUsedError;
  List<BusinessHours>? get businessHours => throw _privateConstructorUsedError;
  List<String> get services => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  bool get isFeatured => throw _privateConstructorUsedError;
  int get viewCount => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusinessCopyWith<Business> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessCopyWith<$Res> {
  factory $BusinessCopyWith(Business value, $Res Function(Business) then) =
      _$BusinessCopyWithImpl<$Res, Business>;
  @useResult
  $Res call({
    String id,
    String name,
    String slug,
    BusinessCategory category,
    String description,
    String? logo,
    String? phone,
    String? email,
    String? website,
    String? address,
    String? city,
    String? district,
    GeoLocation? geo,
    SocialLinks? socialLinks,
    List<BusinessHours>? businessHours,
    List<String> services,
    List<String> tags,
    bool isFeatured,
    int viewCount,
    DateTime? createdAt,
  });

  $GeoLocationCopyWith<$Res>? get geo;
  $SocialLinksCopyWith<$Res>? get socialLinks;
}

/// @nodoc
class _$BusinessCopyWithImpl<$Res, $Val extends Business>
    implements $BusinessCopyWith<$Res> {
  _$BusinessCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? category = null,
    Object? description = null,
    Object? logo = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? website = freezed,
    Object? address = freezed,
    Object? city = freezed,
    Object? district = freezed,
    Object? geo = freezed,
    Object? socialLinks = freezed,
    Object? businessHours = freezed,
    Object? services = null,
    Object? tags = null,
    Object? isFeatured = null,
    Object? viewCount = null,
    Object? createdAt = freezed,
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
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as BusinessCategory,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            logo: freezed == logo
                ? _value.logo
                : logo // ignore: cast_nullable_to_non_nullable
                      as String?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            website: freezed == website
                ? _value.website
                : website // ignore: cast_nullable_to_non_nullable
                      as String?,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
            city: freezed == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String?,
            district: freezed == district
                ? _value.district
                : district // ignore: cast_nullable_to_non_nullable
                      as String?,
            geo: freezed == geo
                ? _value.geo
                : geo // ignore: cast_nullable_to_non_nullable
                      as GeoLocation?,
            socialLinks: freezed == socialLinks
                ? _value.socialLinks
                : socialLinks // ignore: cast_nullable_to_non_nullable
                      as SocialLinks?,
            businessHours: freezed == businessHours
                ? _value.businessHours
                : businessHours // ignore: cast_nullable_to_non_nullable
                      as List<BusinessHours>?,
            services: null == services
                ? _value.services
                : services // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
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
                      as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GeoLocationCopyWith<$Res>? get geo {
    if (_value.geo == null) {
      return null;
    }

    return $GeoLocationCopyWith<$Res>(_value.geo!, (value) {
      return _then(_value.copyWith(geo: value) as $Val);
    });
  }

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SocialLinksCopyWith<$Res>? get socialLinks {
    if (_value.socialLinks == null) {
      return null;
    }

    return $SocialLinksCopyWith<$Res>(_value.socialLinks!, (value) {
      return _then(_value.copyWith(socialLinks: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BusinessImplCopyWith<$Res>
    implements $BusinessCopyWith<$Res> {
  factory _$$BusinessImplCopyWith(
    _$BusinessImpl value,
    $Res Function(_$BusinessImpl) then,
  ) = __$$BusinessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String slug,
    BusinessCategory category,
    String description,
    String? logo,
    String? phone,
    String? email,
    String? website,
    String? address,
    String? city,
    String? district,
    GeoLocation? geo,
    SocialLinks? socialLinks,
    List<BusinessHours>? businessHours,
    List<String> services,
    List<String> tags,
    bool isFeatured,
    int viewCount,
    DateTime? createdAt,
  });

  @override
  $GeoLocationCopyWith<$Res>? get geo;
  @override
  $SocialLinksCopyWith<$Res>? get socialLinks;
}

/// @nodoc
class __$$BusinessImplCopyWithImpl<$Res>
    extends _$BusinessCopyWithImpl<$Res, _$BusinessImpl>
    implements _$$BusinessImplCopyWith<$Res> {
  __$$BusinessImplCopyWithImpl(
    _$BusinessImpl _value,
    $Res Function(_$BusinessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? category = null,
    Object? description = null,
    Object? logo = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? website = freezed,
    Object? address = freezed,
    Object? city = freezed,
    Object? district = freezed,
    Object? geo = freezed,
    Object? socialLinks = freezed,
    Object? businessHours = freezed,
    Object? services = null,
    Object? tags = null,
    Object? isFeatured = null,
    Object? viewCount = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$BusinessImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as BusinessCategory,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        logo: freezed == logo
            ? _value.logo
            : logo // ignore: cast_nullable_to_non_nullable
                  as String?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        website: freezed == website
            ? _value.website
            : website // ignore: cast_nullable_to_non_nullable
                  as String?,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        city: freezed == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String?,
        district: freezed == district
            ? _value.district
            : district // ignore: cast_nullable_to_non_nullable
                  as String?,
        geo: freezed == geo
            ? _value.geo
            : geo // ignore: cast_nullable_to_non_nullable
                  as GeoLocation?,
        socialLinks: freezed == socialLinks
            ? _value.socialLinks
            : socialLinks // ignore: cast_nullable_to_non_nullable
                  as SocialLinks?,
        businessHours: freezed == businessHours
            ? _value._businessHours
            : businessHours // ignore: cast_nullable_to_non_nullable
                  as List<BusinessHours>?,
        services: null == services
            ? _value._services
            : services // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
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
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$BusinessImpl extends _Business {
  const _$BusinessImpl({
    required this.id,
    required this.name,
    required this.slug,
    required this.category,
    required this.description,
    this.logo,
    this.phone,
    this.email,
    this.website,
    this.address,
    this.city,
    this.district,
    this.geo,
    this.socialLinks,
    final List<BusinessHours>? businessHours,
    final List<String> services = const [],
    final List<String> tags = const [],
    this.isFeatured = false,
    this.viewCount = 0,
    this.createdAt,
  }) : _businessHours = businessHours,
       _services = services,
       _tags = tags,
       super._();

  @override
  final String id;
  @override
  final String name;
  @override
  final String slug;
  @override
  final BusinessCategory category;
  @override
  final String description;
  @override
  final String? logo;
  @override
  final String? phone;
  @override
  final String? email;
  @override
  final String? website;
  @override
  final String? address;
  @override
  final String? city;
  @override
  final String? district;
  @override
  final GeoLocation? geo;
  @override
  final SocialLinks? socialLinks;
  final List<BusinessHours>? _businessHours;
  @override
  List<BusinessHours>? get businessHours {
    final value = _businessHours;
    if (value == null) return null;
    if (_businessHours is EqualUnmodifiableListView) return _businessHours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String> _services;
  @override
  @JsonKey()
  List<String> get services {
    if (_services is EqualUnmodifiableListView) return _services;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_services);
  }

  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
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
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Business(id: $id, name: $name, slug: $slug, category: $category, description: $description, logo: $logo, phone: $phone, email: $email, website: $website, address: $address, city: $city, district: $district, geo: $geo, socialLinks: $socialLinks, businessHours: $businessHours, services: $services, tags: $tags, isFeatured: $isFeatured, viewCount: $viewCount, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.logo, logo) || other.logo == logo) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.district, district) ||
                other.district == district) &&
            (identical(other.geo, geo) || other.geo == geo) &&
            (identical(other.socialLinks, socialLinks) ||
                other.socialLinks == socialLinks) &&
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
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    name,
    slug,
    category,
    description,
    logo,
    phone,
    email,
    website,
    address,
    city,
    district,
    geo,
    socialLinks,
    const DeepCollectionEquality().hash(_businessHours),
    const DeepCollectionEquality().hash(_services),
    const DeepCollectionEquality().hash(_tags),
    isFeatured,
    viewCount,
    createdAt,
  ]);

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessImplCopyWith<_$BusinessImpl> get copyWith =>
      __$$BusinessImplCopyWithImpl<_$BusinessImpl>(this, _$identity);
}

abstract class _Business extends Business {
  const factory _Business({
    required final String id,
    required final String name,
    required final String slug,
    required final BusinessCategory category,
    required final String description,
    final String? logo,
    final String? phone,
    final String? email,
    final String? website,
    final String? address,
    final String? city,
    final String? district,
    final GeoLocation? geo,
    final SocialLinks? socialLinks,
    final List<BusinessHours>? businessHours,
    final List<String> services,
    final List<String> tags,
    final bool isFeatured,
    final int viewCount,
    final DateTime? createdAt,
  }) = _$BusinessImpl;
  const _Business._() : super._();

  @override
  String get id;
  @override
  String get name;
  @override
  String get slug;
  @override
  BusinessCategory get category;
  @override
  String get description;
  @override
  String? get logo;
  @override
  String? get phone;
  @override
  String? get email;
  @override
  String? get website;
  @override
  String? get address;
  @override
  String? get city;
  @override
  String? get district;
  @override
  GeoLocation? get geo;
  @override
  SocialLinks? get socialLinks;
  @override
  List<BusinessHours>? get businessHours;
  @override
  List<String> get services;
  @override
  List<String> get tags;
  @override
  bool get isFeatured;
  @override
  int get viewCount;
  @override
  DateTime? get createdAt;

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusinessImplCopyWith<_$BusinessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GeoLocation {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;

  /// Create a copy of GeoLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GeoLocationCopyWith<GeoLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeoLocationCopyWith<$Res> {
  factory $GeoLocationCopyWith(
    GeoLocation value,
    $Res Function(GeoLocation) then,
  ) = _$GeoLocationCopyWithImpl<$Res, GeoLocation>;
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class _$GeoLocationCopyWithImpl<$Res, $Val extends GeoLocation>
    implements $GeoLocationCopyWith<$Res> {
  _$GeoLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GeoLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? latitude = null, Object? longitude = null}) {
    return _then(
      _value.copyWith(
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GeoLocationImplCopyWith<$Res>
    implements $GeoLocationCopyWith<$Res> {
  factory _$$GeoLocationImplCopyWith(
    _$GeoLocationImpl value,
    $Res Function(_$GeoLocationImpl) then,
  ) = __$$GeoLocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class __$$GeoLocationImplCopyWithImpl<$Res>
    extends _$GeoLocationCopyWithImpl<$Res, _$GeoLocationImpl>
    implements _$$GeoLocationImplCopyWith<$Res> {
  __$$GeoLocationImplCopyWithImpl(
    _$GeoLocationImpl _value,
    $Res Function(_$GeoLocationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GeoLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? latitude = null, Object? longitude = null}) {
    return _then(
      _$GeoLocationImpl(
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$GeoLocationImpl implements _GeoLocation {
  const _$GeoLocationImpl({required this.latitude, required this.longitude});

  @override
  final double latitude;
  @override
  final double longitude;

  @override
  String toString() {
    return 'GeoLocation(latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeoLocationImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @override
  int get hashCode => Object.hash(runtimeType, latitude, longitude);

  /// Create a copy of GeoLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GeoLocationImplCopyWith<_$GeoLocationImpl> get copyWith =>
      __$$GeoLocationImplCopyWithImpl<_$GeoLocationImpl>(this, _$identity);
}

abstract class _GeoLocation implements GeoLocation {
  const factory _GeoLocation({
    required final double latitude,
    required final double longitude,
  }) = _$GeoLocationImpl;

  @override
  double get latitude;
  @override
  double get longitude;

  /// Create a copy of GeoLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GeoLocationImplCopyWith<_$GeoLocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SocialLinks {
  String? get facebook => throw _privateConstructorUsedError;
  String? get twitter => throw _privateConstructorUsedError;
  String? get instagram => throw _privateConstructorUsedError;
  String? get linkedin => throw _privateConstructorUsedError;

  /// Create a copy of SocialLinks
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SocialLinksCopyWith<SocialLinks> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SocialLinksCopyWith<$Res> {
  factory $SocialLinksCopyWith(
    SocialLinks value,
    $Res Function(SocialLinks) then,
  ) = _$SocialLinksCopyWithImpl<$Res, SocialLinks>;
  @useResult
  $Res call({
    String? facebook,
    String? twitter,
    String? instagram,
    String? linkedin,
  });
}

/// @nodoc
class _$SocialLinksCopyWithImpl<$Res, $Val extends SocialLinks>
    implements $SocialLinksCopyWith<$Res> {
  _$SocialLinksCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SocialLinks
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
abstract class _$$SocialLinksImplCopyWith<$Res>
    implements $SocialLinksCopyWith<$Res> {
  factory _$$SocialLinksImplCopyWith(
    _$SocialLinksImpl value,
    $Res Function(_$SocialLinksImpl) then,
  ) = __$$SocialLinksImplCopyWithImpl<$Res>;
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
class __$$SocialLinksImplCopyWithImpl<$Res>
    extends _$SocialLinksCopyWithImpl<$Res, _$SocialLinksImpl>
    implements _$$SocialLinksImplCopyWith<$Res> {
  __$$SocialLinksImplCopyWithImpl(
    _$SocialLinksImpl _value,
    $Res Function(_$SocialLinksImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SocialLinks
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
      _$SocialLinksImpl(
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

class _$SocialLinksImpl implements _SocialLinks {
  const _$SocialLinksImpl({
    this.facebook,
    this.twitter,
    this.instagram,
    this.linkedin,
  });

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
    return 'SocialLinks(facebook: $facebook, twitter: $twitter, instagram: $instagram, linkedin: $linkedin)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SocialLinksImpl &&
            (identical(other.facebook, facebook) ||
                other.facebook == facebook) &&
            (identical(other.twitter, twitter) || other.twitter == twitter) &&
            (identical(other.instagram, instagram) ||
                other.instagram == instagram) &&
            (identical(other.linkedin, linkedin) ||
                other.linkedin == linkedin));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, facebook, twitter, instagram, linkedin);

  /// Create a copy of SocialLinks
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SocialLinksImplCopyWith<_$SocialLinksImpl> get copyWith =>
      __$$SocialLinksImplCopyWithImpl<_$SocialLinksImpl>(this, _$identity);
}

abstract class _SocialLinks implements SocialLinks {
  const factory _SocialLinks({
    final String? facebook,
    final String? twitter,
    final String? instagram,
    final String? linkedin,
  }) = _$SocialLinksImpl;

  @override
  String? get facebook;
  @override
  String? get twitter;
  @override
  String? get instagram;
  @override
  String? get linkedin;

  /// Create a copy of SocialLinks
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SocialLinksImplCopyWith<_$SocialLinksImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BusinessHours {
  String get day => throw _privateConstructorUsedError;
  String? get open => throw _privateConstructorUsedError;
  String? get close => throw _privateConstructorUsedError;
  bool get isClosed => throw _privateConstructorUsedError;

  /// Create a copy of BusinessHours
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusinessHoursCopyWith<BusinessHours> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessHoursCopyWith<$Res> {
  factory $BusinessHoursCopyWith(
    BusinessHours value,
    $Res Function(BusinessHours) then,
  ) = _$BusinessHoursCopyWithImpl<$Res, BusinessHours>;
  @useResult
  $Res call({String day, String? open, String? close, bool isClosed});
}

/// @nodoc
class _$BusinessHoursCopyWithImpl<$Res, $Val extends BusinessHours>
    implements $BusinessHoursCopyWith<$Res> {
  _$BusinessHoursCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusinessHours
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
abstract class _$$BusinessHoursImplCopyWith<$Res>
    implements $BusinessHoursCopyWith<$Res> {
  factory _$$BusinessHoursImplCopyWith(
    _$BusinessHoursImpl value,
    $Res Function(_$BusinessHoursImpl) then,
  ) = __$$BusinessHoursImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String day, String? open, String? close, bool isClosed});
}

/// @nodoc
class __$$BusinessHoursImplCopyWithImpl<$Res>
    extends _$BusinessHoursCopyWithImpl<$Res, _$BusinessHoursImpl>
    implements _$$BusinessHoursImplCopyWith<$Res> {
  __$$BusinessHoursImplCopyWithImpl(
    _$BusinessHoursImpl _value,
    $Res Function(_$BusinessHoursImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BusinessHours
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
      _$BusinessHoursImpl(
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

class _$BusinessHoursImpl implements _BusinessHours {
  const _$BusinessHoursImpl({
    required this.day,
    this.open,
    this.close,
    this.isClosed = false,
  });

  @override
  final String day;
  @override
  final String? open;
  @override
  final String? close;
  @override
  @JsonKey()
  final bool isClosed;

  @override
  String toString() {
    return 'BusinessHours(day: $day, open: $open, close: $close, isClosed: $isClosed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessHoursImpl &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.open, open) || other.open == open) &&
            (identical(other.close, close) || other.close == close) &&
            (identical(other.isClosed, isClosed) ||
                other.isClosed == isClosed));
  }

  @override
  int get hashCode => Object.hash(runtimeType, day, open, close, isClosed);

  /// Create a copy of BusinessHours
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessHoursImplCopyWith<_$BusinessHoursImpl> get copyWith =>
      __$$BusinessHoursImplCopyWithImpl<_$BusinessHoursImpl>(this, _$identity);
}

abstract class _BusinessHours implements BusinessHours {
  const factory _BusinessHours({
    required final String day,
    final String? open,
    final String? close,
    final bool isClosed,
  }) = _$BusinessHoursImpl;

  @override
  String get day;
  @override
  String? get open;
  @override
  String? get close;
  @override
  bool get isClosed;

  /// Create a copy of BusinessHours
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusinessHoursImplCopyWith<_$BusinessHoursImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
