// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'opportunity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Opportunity {
  String get id => throw _privateConstructorUsedError;
  OpportunityType get type => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get company => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  DateTime get deadline => throw _privateConstructorUsedError;
  bool get verified => throw _privateConstructorUsedError;
  int? get salary => throw _privateConstructorUsedError;
  String? get applyUrl => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Create a copy of Opportunity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OpportunityCopyWith<Opportunity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OpportunityCopyWith<$Res> {
  factory $OpportunityCopyWith(
    Opportunity value,
    $Res Function(Opportunity) then,
  ) = _$OpportunityCopyWithImpl<$Res, Opportunity>;
  @useResult
  $Res call({
    String id,
    OpportunityType type,
    String title,
    String company,
    String location,
    DateTime deadline,
    bool verified,
    int? salary,
    String? applyUrl,
    String? description,
  });
}

/// @nodoc
class _$OpportunityCopyWithImpl<$Res, $Val extends Opportunity>
    implements $OpportunityCopyWith<$Res> {
  _$OpportunityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Opportunity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? company = null,
    Object? location = null,
    Object? deadline = null,
    Object? verified = null,
    Object? salary = freezed,
    Object? applyUrl = freezed,
    Object? description = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as OpportunityType,
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
            deadline: null == deadline
                ? _value.deadline
                : deadline // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            verified: null == verified
                ? _value.verified
                : verified // ignore: cast_nullable_to_non_nullable
                      as bool,
            salary: freezed == salary
                ? _value.salary
                : salary // ignore: cast_nullable_to_non_nullable
                      as int?,
            applyUrl: freezed == applyUrl
                ? _value.applyUrl
                : applyUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OpportunityImplCopyWith<$Res>
    implements $OpportunityCopyWith<$Res> {
  factory _$$OpportunityImplCopyWith(
    _$OpportunityImpl value,
    $Res Function(_$OpportunityImpl) then,
  ) = __$$OpportunityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    OpportunityType type,
    String title,
    String company,
    String location,
    DateTime deadline,
    bool verified,
    int? salary,
    String? applyUrl,
    String? description,
  });
}

/// @nodoc
class __$$OpportunityImplCopyWithImpl<$Res>
    extends _$OpportunityCopyWithImpl<$Res, _$OpportunityImpl>
    implements _$$OpportunityImplCopyWith<$Res> {
  __$$OpportunityImplCopyWithImpl(
    _$OpportunityImpl _value,
    $Res Function(_$OpportunityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Opportunity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? company = null,
    Object? location = null,
    Object? deadline = null,
    Object? verified = null,
    Object? salary = freezed,
    Object? applyUrl = freezed,
    Object? description = freezed,
  }) {
    return _then(
      _$OpportunityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as OpportunityType,
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
        deadline: null == deadline
            ? _value.deadline
            : deadline // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        verified: null == verified
            ? _value.verified
            : verified // ignore: cast_nullable_to_non_nullable
                  as bool,
        salary: freezed == salary
            ? _value.salary
            : salary // ignore: cast_nullable_to_non_nullable
                  as int?,
        applyUrl: freezed == applyUrl
            ? _value.applyUrl
            : applyUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$OpportunityImpl extends _Opportunity {
  const _$OpportunityImpl({
    required this.id,
    required this.type,
    required this.title,
    required this.company,
    required this.location,
    required this.deadline,
    required this.verified,
    this.salary,
    this.applyUrl,
    this.description,
  }) : super._();

  @override
  final String id;
  @override
  final OpportunityType type;
  @override
  final String title;
  @override
  final String company;
  @override
  final String location;
  @override
  final DateTime deadline;
  @override
  final bool verified;
  @override
  final int? salary;
  @override
  final String? applyUrl;
  @override
  final String? description;

  @override
  String toString() {
    return 'Opportunity(id: $id, type: $type, title: $title, company: $company, location: $location, deadline: $deadline, verified: $verified, salary: $salary, applyUrl: $applyUrl, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OpportunityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.verified, verified) ||
                other.verified == verified) &&
            (identical(other.salary, salary) || other.salary == salary) &&
            (identical(other.applyUrl, applyUrl) ||
                other.applyUrl == applyUrl) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    title,
    company,
    location,
    deadline,
    verified,
    salary,
    applyUrl,
    description,
  );

  /// Create a copy of Opportunity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OpportunityImplCopyWith<_$OpportunityImpl> get copyWith =>
      __$$OpportunityImplCopyWithImpl<_$OpportunityImpl>(this, _$identity);
}

abstract class _Opportunity extends Opportunity {
  const factory _Opportunity({
    required final String id,
    required final OpportunityType type,
    required final String title,
    required final String company,
    required final String location,
    required final DateTime deadline,
    required final bool verified,
    final int? salary,
    final String? applyUrl,
    final String? description,
  }) = _$OpportunityImpl;
  const _Opportunity._() : super._();

  @override
  String get id;
  @override
  OpportunityType get type;
  @override
  String get title;
  @override
  String get company;
  @override
  String get location;
  @override
  DateTime get deadline;
  @override
  bool get verified;
  @override
  int? get salary;
  @override
  String? get applyUrl;
  @override
  String? get description;

  /// Create a copy of Opportunity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OpportunityImplCopyWith<_$OpportunityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
