// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'opportunity_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OpportunityDto _$OpportunityDtoFromJson(Map<String, dynamic> json) {
  return _OpportunityDto.fromJson(json);
}

/// @nodoc
mixin _$OpportunityDto {
  dynamic get id =>
      throw _privateConstructorUsedError; // Can be int or String from Payload
  String get type => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get company => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String get applyUrl => throw _privateConstructorUsedError;
  String? get deadline => throw _privateConstructorUsedError;
  bool? get verified => throw _privateConstructorUsedError;
  bool? get isFeatured => throw _privateConstructorUsedError;
  int? get salary => throw _privateConstructorUsedError;
  String? get salaryCurrency => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  dynamic get companyLogo =>
      throw _privateConstructorUsedError; // Can be object or ID
  List<dynamic>? get requirements => throw _privateConstructorUsedError;
  String? get datePosted => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this OpportunityDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OpportunityDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OpportunityDtoCopyWith<OpportunityDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OpportunityDtoCopyWith<$Res> {
  factory $OpportunityDtoCopyWith(
    OpportunityDto value,
    $Res Function(OpportunityDto) then,
  ) = _$OpportunityDtoCopyWithImpl<$Res, OpportunityDto>;
  @useResult
  $Res call({
    dynamic id,
    String type,
    String title,
    String company,
    String location,
    String applyUrl,
    String? deadline,
    bool? verified,
    bool? isFeatured,
    int? salary,
    String? salaryCurrency,
    String? description,
    dynamic companyLogo,
    List<dynamic>? requirements,
    String? datePosted,
    String? createdAt,
    String? updatedAt,
  });
}

/// @nodoc
class _$OpportunityDtoCopyWithImpl<$Res, $Val extends OpportunityDto>
    implements $OpportunityDtoCopyWith<$Res> {
  _$OpportunityDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OpportunityDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = null,
    Object? title = null,
    Object? company = null,
    Object? location = null,
    Object? applyUrl = null,
    Object? deadline = freezed,
    Object? verified = freezed,
    Object? isFeatured = freezed,
    Object? salary = freezed,
    Object? salaryCurrency = freezed,
    Object? description = freezed,
    Object? companyLogo = freezed,
    Object? requirements = freezed,
    Object? datePosted = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            company: null == company
                ? _value.company
                : company // ignore: cast_nullable_to_non_nullable
                      as String,
            location: null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String,
            applyUrl: null == applyUrl
                ? _value.applyUrl
                : applyUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            deadline: freezed == deadline
                ? _value.deadline
                : deadline // ignore: cast_nullable_to_non_nullable
                      as String?,
            verified: freezed == verified
                ? _value.verified
                : verified // ignore: cast_nullable_to_non_nullable
                      as bool?,
            isFeatured: freezed == isFeatured
                ? _value.isFeatured
                : isFeatured // ignore: cast_nullable_to_non_nullable
                      as bool?,
            salary: freezed == salary
                ? _value.salary
                : salary // ignore: cast_nullable_to_non_nullable
                      as int?,
            salaryCurrency: freezed == salaryCurrency
                ? _value.salaryCurrency
                : salaryCurrency // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            companyLogo: freezed == companyLogo
                ? _value.companyLogo
                : companyLogo // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            requirements: freezed == requirements
                ? _value.requirements
                : requirements // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>?,
            datePosted: freezed == datePosted
                ? _value.datePosted
                : datePosted // ignore: cast_nullable_to_non_nullable
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
abstract class _$$OpportunityDtoImplCopyWith<$Res>
    implements $OpportunityDtoCopyWith<$Res> {
  factory _$$OpportunityDtoImplCopyWith(
    _$OpportunityDtoImpl value,
    $Res Function(_$OpportunityDtoImpl) then,
  ) = __$$OpportunityDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    dynamic id,
    String type,
    String title,
    String company,
    String location,
    String applyUrl,
    String? deadline,
    bool? verified,
    bool? isFeatured,
    int? salary,
    String? salaryCurrency,
    String? description,
    dynamic companyLogo,
    List<dynamic>? requirements,
    String? datePosted,
    String? createdAt,
    String? updatedAt,
  });
}

/// @nodoc
class __$$OpportunityDtoImplCopyWithImpl<$Res>
    extends _$OpportunityDtoCopyWithImpl<$Res, _$OpportunityDtoImpl>
    implements _$$OpportunityDtoImplCopyWith<$Res> {
  __$$OpportunityDtoImplCopyWithImpl(
    _$OpportunityDtoImpl _value,
    $Res Function(_$OpportunityDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OpportunityDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = null,
    Object? title = null,
    Object? company = null,
    Object? location = null,
    Object? applyUrl = null,
    Object? deadline = freezed,
    Object? verified = freezed,
    Object? isFeatured = freezed,
    Object? salary = freezed,
    Object? salaryCurrency = freezed,
    Object? description = freezed,
    Object? companyLogo = freezed,
    Object? requirements = freezed,
    Object? datePosted = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$OpportunityDtoImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        company: null == company
            ? _value.company
            : company // ignore: cast_nullable_to_non_nullable
                  as String,
        location: null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String,
        applyUrl: null == applyUrl
            ? _value.applyUrl
            : applyUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        deadline: freezed == deadline
            ? _value.deadline
            : deadline // ignore: cast_nullable_to_non_nullable
                  as String?,
        verified: freezed == verified
            ? _value.verified
            : verified // ignore: cast_nullable_to_non_nullable
                  as bool?,
        isFeatured: freezed == isFeatured
            ? _value.isFeatured
            : isFeatured // ignore: cast_nullable_to_non_nullable
                  as bool?,
        salary: freezed == salary
            ? _value.salary
            : salary // ignore: cast_nullable_to_non_nullable
                  as int?,
        salaryCurrency: freezed == salaryCurrency
            ? _value.salaryCurrency
            : salaryCurrency // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        companyLogo: freezed == companyLogo
            ? _value.companyLogo
            : companyLogo // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        requirements: freezed == requirements
            ? _value._requirements
            : requirements // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>?,
        datePosted: freezed == datePosted
            ? _value.datePosted
            : datePosted // ignore: cast_nullable_to_non_nullable
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
class _$OpportunityDtoImpl implements _OpportunityDto {
  const _$OpportunityDtoImpl({
    required this.id,
    required this.type,
    required this.title,
    required this.company,
    required this.location,
    required this.applyUrl,
    this.deadline,
    this.verified,
    this.isFeatured,
    this.salary,
    this.salaryCurrency,
    this.description,
    this.companyLogo,
    final List<dynamic>? requirements,
    this.datePosted,
    this.createdAt,
    this.updatedAt,
  }) : _requirements = requirements;

  factory _$OpportunityDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$OpportunityDtoImplFromJson(json);

  @override
  final dynamic id;
  // Can be int or String from Payload
  @override
  final String type;
  @override
  final String title;
  @override
  final String company;
  @override
  final String location;
  @override
  final String applyUrl;
  @override
  final String? deadline;
  @override
  final bool? verified;
  @override
  final bool? isFeatured;
  @override
  final int? salary;
  @override
  final String? salaryCurrency;
  @override
  final String? description;
  @override
  final dynamic companyLogo;
  // Can be object or ID
  final List<dynamic>? _requirements;
  // Can be object or ID
  @override
  List<dynamic>? get requirements {
    final value = _requirements;
    if (value == null) return null;
    if (_requirements is EqualUnmodifiableListView) return _requirements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? datePosted;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;

  @override
  String toString() {
    return 'OpportunityDto(id: $id, type: $type, title: $title, company: $company, location: $location, applyUrl: $applyUrl, deadline: $deadline, verified: $verified, isFeatured: $isFeatured, salary: $salary, salaryCurrency: $salaryCurrency, description: $description, companyLogo: $companyLogo, requirements: $requirements, datePosted: $datePosted, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OpportunityDtoImpl &&
            const DeepCollectionEquality().equals(other.id, id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.applyUrl, applyUrl) ||
                other.applyUrl == applyUrl) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.verified, verified) ||
                other.verified == verified) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.salary, salary) || other.salary == salary) &&
            (identical(other.salaryCurrency, salaryCurrency) ||
                other.salaryCurrency == salaryCurrency) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other.companyLogo,
              companyLogo,
            ) &&
            const DeepCollectionEquality().equals(
              other._requirements,
              _requirements,
            ) &&
            (identical(other.datePosted, datePosted) ||
                other.datePosted == datePosted) &&
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
    type,
    title,
    company,
    location,
    applyUrl,
    deadline,
    verified,
    isFeatured,
    salary,
    salaryCurrency,
    description,
    const DeepCollectionEquality().hash(companyLogo),
    const DeepCollectionEquality().hash(_requirements),
    datePosted,
    createdAt,
    updatedAt,
  );

  /// Create a copy of OpportunityDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OpportunityDtoImplCopyWith<_$OpportunityDtoImpl> get copyWith =>
      __$$OpportunityDtoImplCopyWithImpl<_$OpportunityDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OpportunityDtoImplToJson(this);
  }
}

abstract class _OpportunityDto implements OpportunityDto {
  const factory _OpportunityDto({
    required final dynamic id,
    required final String type,
    required final String title,
    required final String company,
    required final String location,
    required final String applyUrl,
    final String? deadline,
    final bool? verified,
    final bool? isFeatured,
    final int? salary,
    final String? salaryCurrency,
    final String? description,
    final dynamic companyLogo,
    final List<dynamic>? requirements,
    final String? datePosted,
    final String? createdAt,
    final String? updatedAt,
  }) = _$OpportunityDtoImpl;

  factory _OpportunityDto.fromJson(Map<String, dynamic> json) =
      _$OpportunityDtoImpl.fromJson;

  @override
  dynamic get id; // Can be int or String from Payload
  @override
  String get type;
  @override
  String get title;
  @override
  String get company;
  @override
  String get location;
  @override
  String get applyUrl;
  @override
  String? get deadline;
  @override
  bool? get verified;
  @override
  bool? get isFeatured;
  @override
  int? get salary;
  @override
  String? get salaryCurrency;
  @override
  String? get description;
  @override
  dynamic get companyLogo; // Can be object or ID
  @override
  List<dynamic>? get requirements;
  @override
  String? get datePosted;
  @override
  String? get createdAt;
  @override
  String? get updatedAt;

  /// Create a copy of OpportunityDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OpportunityDtoImplCopyWith<_$OpportunityDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
