// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

NotificationPreferences _$NotificationPreferencesFromJson(
  Map<String, dynamic> json,
) {
  return _NotificationPreferences.fromJson(json);
}

/// @nodoc
mixin _$NotificationPreferences {
  bool get pushEnabled => throw _privateConstructorUsedError;
  bool get emailEnabled => throw _privateConstructorUsedError;
  bool get opportunityAlerts => throw _privateConstructorUsedError;
  bool get eventReminders => throw _privateConstructorUsedError;
  bool get communityUpdates => throw _privateConstructorUsedError;
  bool get subscriptionAlerts => throw _privateConstructorUsedError;

  /// Serializes this NotificationPreferences to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationPreferencesCopyWith<NotificationPreferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationPreferencesCopyWith<$Res> {
  factory $NotificationPreferencesCopyWith(
    NotificationPreferences value,
    $Res Function(NotificationPreferences) then,
  ) = _$NotificationPreferencesCopyWithImpl<$Res, NotificationPreferences>;
  @useResult
  $Res call({
    bool pushEnabled,
    bool emailEnabled,
    bool opportunityAlerts,
    bool eventReminders,
    bool communityUpdates,
    bool subscriptionAlerts,
  });
}

/// @nodoc
class _$NotificationPreferencesCopyWithImpl<
  $Res,
  $Val extends NotificationPreferences
>
    implements $NotificationPreferencesCopyWith<$Res> {
  _$NotificationPreferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pushEnabled = null,
    Object? emailEnabled = null,
    Object? opportunityAlerts = null,
    Object? eventReminders = null,
    Object? communityUpdates = null,
    Object? subscriptionAlerts = null,
  }) {
    return _then(
      _value.copyWith(
            pushEnabled: null == pushEnabled
                ? _value.pushEnabled
                : pushEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            emailEnabled: null == emailEnabled
                ? _value.emailEnabled
                : emailEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            opportunityAlerts: null == opportunityAlerts
                ? _value.opportunityAlerts
                : opportunityAlerts // ignore: cast_nullable_to_non_nullable
                      as bool,
            eventReminders: null == eventReminders
                ? _value.eventReminders
                : eventReminders // ignore: cast_nullable_to_non_nullable
                      as bool,
            communityUpdates: null == communityUpdates
                ? _value.communityUpdates
                : communityUpdates // ignore: cast_nullable_to_non_nullable
                      as bool,
            subscriptionAlerts: null == subscriptionAlerts
                ? _value.subscriptionAlerts
                : subscriptionAlerts // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NotificationPreferencesImplCopyWith<$Res>
    implements $NotificationPreferencesCopyWith<$Res> {
  factory _$$NotificationPreferencesImplCopyWith(
    _$NotificationPreferencesImpl value,
    $Res Function(_$NotificationPreferencesImpl) then,
  ) = __$$NotificationPreferencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool pushEnabled,
    bool emailEnabled,
    bool opportunityAlerts,
    bool eventReminders,
    bool communityUpdates,
    bool subscriptionAlerts,
  });
}

/// @nodoc
class __$$NotificationPreferencesImplCopyWithImpl<$Res>
    extends
        _$NotificationPreferencesCopyWithImpl<
          $Res,
          _$NotificationPreferencesImpl
        >
    implements _$$NotificationPreferencesImplCopyWith<$Res> {
  __$$NotificationPreferencesImplCopyWithImpl(
    _$NotificationPreferencesImpl _value,
    $Res Function(_$NotificationPreferencesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pushEnabled = null,
    Object? emailEnabled = null,
    Object? opportunityAlerts = null,
    Object? eventReminders = null,
    Object? communityUpdates = null,
    Object? subscriptionAlerts = null,
  }) {
    return _then(
      _$NotificationPreferencesImpl(
        pushEnabled: null == pushEnabled
            ? _value.pushEnabled
            : pushEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        emailEnabled: null == emailEnabled
            ? _value.emailEnabled
            : emailEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        opportunityAlerts: null == opportunityAlerts
            ? _value.opportunityAlerts
            : opportunityAlerts // ignore: cast_nullable_to_non_nullable
                  as bool,
        eventReminders: null == eventReminders
            ? _value.eventReminders
            : eventReminders // ignore: cast_nullable_to_non_nullable
                  as bool,
        communityUpdates: null == communityUpdates
            ? _value.communityUpdates
            : communityUpdates // ignore: cast_nullable_to_non_nullable
                  as bool,
        subscriptionAlerts: null == subscriptionAlerts
            ? _value.subscriptionAlerts
            : subscriptionAlerts // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationPreferencesImpl implements _NotificationPreferences {
  const _$NotificationPreferencesImpl({
    this.pushEnabled = true,
    this.emailEnabled = true,
    this.opportunityAlerts = true,
    this.eventReminders = true,
    this.communityUpdates = true,
    this.subscriptionAlerts = true,
  });

  factory _$NotificationPreferencesImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationPreferencesImplFromJson(json);

  @override
  @JsonKey()
  final bool pushEnabled;
  @override
  @JsonKey()
  final bool emailEnabled;
  @override
  @JsonKey()
  final bool opportunityAlerts;
  @override
  @JsonKey()
  final bool eventReminders;
  @override
  @JsonKey()
  final bool communityUpdates;
  @override
  @JsonKey()
  final bool subscriptionAlerts;

  @override
  String toString() {
    return 'NotificationPreferences(pushEnabled: $pushEnabled, emailEnabled: $emailEnabled, opportunityAlerts: $opportunityAlerts, eventReminders: $eventReminders, communityUpdates: $communityUpdates, subscriptionAlerts: $subscriptionAlerts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationPreferencesImpl &&
            (identical(other.pushEnabled, pushEnabled) ||
                other.pushEnabled == pushEnabled) &&
            (identical(other.emailEnabled, emailEnabled) ||
                other.emailEnabled == emailEnabled) &&
            (identical(other.opportunityAlerts, opportunityAlerts) ||
                other.opportunityAlerts == opportunityAlerts) &&
            (identical(other.eventReminders, eventReminders) ||
                other.eventReminders == eventReminders) &&
            (identical(other.communityUpdates, communityUpdates) ||
                other.communityUpdates == communityUpdates) &&
            (identical(other.subscriptionAlerts, subscriptionAlerts) ||
                other.subscriptionAlerts == subscriptionAlerts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    pushEnabled,
    emailEnabled,
    opportunityAlerts,
    eventReminders,
    communityUpdates,
    subscriptionAlerts,
  );

  /// Create a copy of NotificationPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationPreferencesImplCopyWith<_$NotificationPreferencesImpl>
  get copyWith =>
      __$$NotificationPreferencesImplCopyWithImpl<
        _$NotificationPreferencesImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationPreferencesImplToJson(this);
  }
}

abstract class _NotificationPreferences implements NotificationPreferences {
  const factory _NotificationPreferences({
    final bool pushEnabled,
    final bool emailEnabled,
    final bool opportunityAlerts,
    final bool eventReminders,
    final bool communityUpdates,
    final bool subscriptionAlerts,
  }) = _$NotificationPreferencesImpl;

  factory _NotificationPreferences.fromJson(Map<String, dynamic> json) =
      _$NotificationPreferencesImpl.fromJson;

  @override
  bool get pushEnabled;
  @override
  bool get emailEnabled;
  @override
  bool get opportunityAlerts;
  @override
  bool get eventReminders;
  @override
  bool get communityUpdates;
  @override
  bool get subscriptionAlerts;

  /// Create a copy of NotificationPreferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationPreferencesImplCopyWith<_$NotificationPreferencesImpl>
  get copyWith => throw _privateConstructorUsedError;
}
