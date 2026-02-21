// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mentorship_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MentorDto _$MentorDtoFromJson(Map<String, dynamic> json) {
  return _MentorDto.fromJson(json);
}

/// @nodoc
mixin _$MentorDto {
  dynamic get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  dynamic get avatar => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get company => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  List<String> get expertise => throw _privateConstructorUsedError;
  int get yearsExperience => throw _privateConstructorUsedError;
  String? get linkedinUrl => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  List<String> get languages => throw _privateConstructorUsedError;
  bool get isAvailable => throw _privateConstructorUsedError;
  int get totalMentees => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  int get reviewCount => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this MentorDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MentorDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MentorDtoCopyWith<MentorDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MentorDtoCopyWith<$Res> {
  factory $MentorDtoCopyWith(MentorDto value, $Res Function(MentorDto) then) =
      _$MentorDtoCopyWithImpl<$Res, MentorDto>;
  @useResult
  $Res call({
    dynamic id,
    String userId,
    String name,
    dynamic avatar,
    String? title,
    String? company,
    String? bio,
    List<String> expertise,
    int yearsExperience,
    String? linkedinUrl,
    String? location,
    List<String> languages,
    bool isAvailable,
    int totalMentees,
    double rating,
    int reviewCount,
    String? createdAt,
  });
}

/// @nodoc
class _$MentorDtoCopyWithImpl<$Res, $Val extends MentorDto>
    implements $MentorDtoCopyWith<$Res> {
  _$MentorDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MentorDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? name = null,
    Object? avatar = freezed,
    Object? title = freezed,
    Object? company = freezed,
    Object? bio = freezed,
    Object? expertise = null,
    Object? yearsExperience = null,
    Object? linkedinUrl = freezed,
    Object? location = freezed,
    Object? languages = null,
    Object? isAvailable = null,
    Object? totalMentees = null,
    Object? rating = null,
    Object? reviewCount = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            avatar: freezed == avatar
                ? _value.avatar
                : avatar // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            company: freezed == company
                ? _value.company
                : company // ignore: cast_nullable_to_non_nullable
                      as String?,
            bio: freezed == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                      as String?,
            expertise: null == expertise
                ? _value.expertise
                : expertise // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            yearsExperience: null == yearsExperience
                ? _value.yearsExperience
                : yearsExperience // ignore: cast_nullable_to_non_nullable
                      as int,
            linkedinUrl: freezed == linkedinUrl
                ? _value.linkedinUrl
                : linkedinUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            languages: null == languages
                ? _value.languages
                : languages // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isAvailable: null == isAvailable
                ? _value.isAvailable
                : isAvailable // ignore: cast_nullable_to_non_nullable
                      as bool,
            totalMentees: null == totalMentees
                ? _value.totalMentees
                : totalMentees // ignore: cast_nullable_to_non_nullable
                      as int,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            reviewCount: null == reviewCount
                ? _value.reviewCount
                : reviewCount // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$MentorDtoImplCopyWith<$Res>
    implements $MentorDtoCopyWith<$Res> {
  factory _$$MentorDtoImplCopyWith(
    _$MentorDtoImpl value,
    $Res Function(_$MentorDtoImpl) then,
  ) = __$$MentorDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    dynamic id,
    String userId,
    String name,
    dynamic avatar,
    String? title,
    String? company,
    String? bio,
    List<String> expertise,
    int yearsExperience,
    String? linkedinUrl,
    String? location,
    List<String> languages,
    bool isAvailable,
    int totalMentees,
    double rating,
    int reviewCount,
    String? createdAt,
  });
}

/// @nodoc
class __$$MentorDtoImplCopyWithImpl<$Res>
    extends _$MentorDtoCopyWithImpl<$Res, _$MentorDtoImpl>
    implements _$$MentorDtoImplCopyWith<$Res> {
  __$$MentorDtoImplCopyWithImpl(
    _$MentorDtoImpl _value,
    $Res Function(_$MentorDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MentorDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? name = null,
    Object? avatar = freezed,
    Object? title = freezed,
    Object? company = freezed,
    Object? bio = freezed,
    Object? expertise = null,
    Object? yearsExperience = null,
    Object? linkedinUrl = freezed,
    Object? location = freezed,
    Object? languages = null,
    Object? isAvailable = null,
    Object? totalMentees = null,
    Object? rating = null,
    Object? reviewCount = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$MentorDtoImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        avatar: freezed == avatar
            ? _value.avatar
            : avatar // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        company: freezed == company
            ? _value.company
            : company // ignore: cast_nullable_to_non_nullable
                  as String?,
        bio: freezed == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String?,
        expertise: null == expertise
            ? _value._expertise
            : expertise // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        yearsExperience: null == yearsExperience
            ? _value.yearsExperience
            : yearsExperience // ignore: cast_nullable_to_non_nullable
                  as int,
        linkedinUrl: freezed == linkedinUrl
            ? _value.linkedinUrl
            : linkedinUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        languages: null == languages
            ? _value._languages
            : languages // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isAvailable: null == isAvailable
            ? _value.isAvailable
            : isAvailable // ignore: cast_nullable_to_non_nullable
                  as bool,
        totalMentees: null == totalMentees
            ? _value.totalMentees
            : totalMentees // ignore: cast_nullable_to_non_nullable
                  as int,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        reviewCount: null == reviewCount
            ? _value.reviewCount
            : reviewCount // ignore: cast_nullable_to_non_nullable
                  as int,
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
class _$MentorDtoImpl implements _MentorDto {
  const _$MentorDtoImpl({
    required this.id,
    required this.userId,
    required this.name,
    this.avatar,
    this.title,
    this.company,
    this.bio,
    final List<String> expertise = const [],
    this.yearsExperience = 0,
    this.linkedinUrl,
    this.location,
    final List<String> languages = const [],
    this.isAvailable = true,
    this.totalMentees = 0,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.createdAt,
  }) : _expertise = expertise,
       _languages = languages;

  factory _$MentorDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MentorDtoImplFromJson(json);

  @override
  final dynamic id;
  @override
  final String userId;
  @override
  final String name;
  @override
  final dynamic avatar;
  @override
  final String? title;
  @override
  final String? company;
  @override
  final String? bio;
  final List<String> _expertise;
  @override
  @JsonKey()
  List<String> get expertise {
    if (_expertise is EqualUnmodifiableListView) return _expertise;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_expertise);
  }

  @override
  @JsonKey()
  final int yearsExperience;
  @override
  final String? linkedinUrl;
  @override
  final String? location;
  final List<String> _languages;
  @override
  @JsonKey()
  List<String> get languages {
    if (_languages is EqualUnmodifiableListView) return _languages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_languages);
  }

  @override
  @JsonKey()
  final bool isAvailable;
  @override
  @JsonKey()
  final int totalMentees;
  @override
  @JsonKey()
  final double rating;
  @override
  @JsonKey()
  final int reviewCount;
  @override
  final String? createdAt;

  @override
  String toString() {
    return 'MentorDto(id: $id, userId: $userId, name: $name, avatar: $avatar, title: $title, company: $company, bio: $bio, expertise: $expertise, yearsExperience: $yearsExperience, linkedinUrl: $linkedinUrl, location: $location, languages: $languages, isAvailable: $isAvailable, totalMentees: $totalMentees, rating: $rating, reviewCount: $reviewCount, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MentorDtoImpl &&
            const DeepCollectionEquality().equals(other.id, id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.avatar, avatar) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            const DeepCollectionEquality().equals(
              other._expertise,
              _expertise,
            ) &&
            (identical(other.yearsExperience, yearsExperience) ||
                other.yearsExperience == yearsExperience) &&
            (identical(other.linkedinUrl, linkedinUrl) ||
                other.linkedinUrl == linkedinUrl) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality().equals(
              other._languages,
              _languages,
            ) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.totalMentees, totalMentees) ||
                other.totalMentees == totalMentees) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.reviewCount, reviewCount) ||
                other.reviewCount == reviewCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(id),
    userId,
    name,
    const DeepCollectionEquality().hash(avatar),
    title,
    company,
    bio,
    const DeepCollectionEquality().hash(_expertise),
    yearsExperience,
    linkedinUrl,
    location,
    const DeepCollectionEquality().hash(_languages),
    isAvailable,
    totalMentees,
    rating,
    reviewCount,
    createdAt,
  );

  /// Create a copy of MentorDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MentorDtoImplCopyWith<_$MentorDtoImpl> get copyWith =>
      __$$MentorDtoImplCopyWithImpl<_$MentorDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MentorDtoImplToJson(this);
  }
}

abstract class _MentorDto implements MentorDto {
  const factory _MentorDto({
    required final dynamic id,
    required final String userId,
    required final String name,
    final dynamic avatar,
    final String? title,
    final String? company,
    final String? bio,
    final List<String> expertise,
    final int yearsExperience,
    final String? linkedinUrl,
    final String? location,
    final List<String> languages,
    final bool isAvailable,
    final int totalMentees,
    final double rating,
    final int reviewCount,
    final String? createdAt,
  }) = _$MentorDtoImpl;

  factory _MentorDto.fromJson(Map<String, dynamic> json) =
      _$MentorDtoImpl.fromJson;

  @override
  dynamic get id;
  @override
  String get userId;
  @override
  String get name;
  @override
  dynamic get avatar;
  @override
  String? get title;
  @override
  String? get company;
  @override
  String? get bio;
  @override
  List<String> get expertise;
  @override
  int get yearsExperience;
  @override
  String? get linkedinUrl;
  @override
  String? get location;
  @override
  List<String> get languages;
  @override
  bool get isAvailable;
  @override
  int get totalMentees;
  @override
  double get rating;
  @override
  int get reviewCount;
  @override
  String? get createdAt;

  /// Create a copy of MentorDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MentorDtoImplCopyWith<_$MentorDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MentorshipRequestDto _$MentorshipRequestDtoFromJson(Map<String, dynamic> json) {
  return _MentorshipRequestDto.fromJson(json);
}

/// @nodoc
mixin _$MentorshipRequestDto {
  dynamic get id => throw _privateConstructorUsedError;
  dynamic get mentor => throw _privateConstructorUsedError;
  dynamic get mentee => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String? get responseMessage => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String? get respondedAt => throw _privateConstructorUsedError;

  /// Serializes this MentorshipRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MentorshipRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MentorshipRequestDtoCopyWith<MentorshipRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MentorshipRequestDtoCopyWith<$Res> {
  factory $MentorshipRequestDtoCopyWith(
    MentorshipRequestDto value,
    $Res Function(MentorshipRequestDto) then,
  ) = _$MentorshipRequestDtoCopyWithImpl<$Res, MentorshipRequestDto>;
  @useResult
  $Res call({
    dynamic id,
    dynamic mentor,
    dynamic mentee,
    String status,
    String message,
    String? responseMessage,
    String createdAt,
    String? respondedAt,
  });
}

/// @nodoc
class _$MentorshipRequestDtoCopyWithImpl<
  $Res,
  $Val extends MentorshipRequestDto
>
    implements $MentorshipRequestDtoCopyWith<$Res> {
  _$MentorshipRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MentorshipRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? mentor = freezed,
    Object? mentee = freezed,
    Object? status = null,
    Object? message = null,
    Object? responseMessage = freezed,
    Object? createdAt = null,
    Object? respondedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            mentor: freezed == mentor
                ? _value.mentor
                : mentor // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            mentee: freezed == mentee
                ? _value.mentee
                : mentee // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            responseMessage: freezed == responseMessage
                ? _value.responseMessage
                : responseMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            respondedAt: freezed == respondedAt
                ? _value.respondedAt
                : respondedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MentorshipRequestDtoImplCopyWith<$Res>
    implements $MentorshipRequestDtoCopyWith<$Res> {
  factory _$$MentorshipRequestDtoImplCopyWith(
    _$MentorshipRequestDtoImpl value,
    $Res Function(_$MentorshipRequestDtoImpl) then,
  ) = __$$MentorshipRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    dynamic id,
    dynamic mentor,
    dynamic mentee,
    String status,
    String message,
    String? responseMessage,
    String createdAt,
    String? respondedAt,
  });
}

/// @nodoc
class __$$MentorshipRequestDtoImplCopyWithImpl<$Res>
    extends _$MentorshipRequestDtoCopyWithImpl<$Res, _$MentorshipRequestDtoImpl>
    implements _$$MentorshipRequestDtoImplCopyWith<$Res> {
  __$$MentorshipRequestDtoImplCopyWithImpl(
    _$MentorshipRequestDtoImpl _value,
    $Res Function(_$MentorshipRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MentorshipRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? mentor = freezed,
    Object? mentee = freezed,
    Object? status = null,
    Object? message = null,
    Object? responseMessage = freezed,
    Object? createdAt = null,
    Object? respondedAt = freezed,
  }) {
    return _then(
      _$MentorshipRequestDtoImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        mentor: freezed == mentor
            ? _value.mentor
            : mentor // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        mentee: freezed == mentee
            ? _value.mentee
            : mentee // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        responseMessage: freezed == responseMessage
            ? _value.responseMessage
            : responseMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        respondedAt: freezed == respondedAt
            ? _value.respondedAt
            : respondedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MentorshipRequestDtoImpl implements _MentorshipRequestDto {
  const _$MentorshipRequestDtoImpl({
    required this.id,
    required this.mentor,
    required this.mentee,
    this.status = 'pending',
    required this.message,
    this.responseMessage,
    required this.createdAt,
    this.respondedAt,
  });

  factory _$MentorshipRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MentorshipRequestDtoImplFromJson(json);

  @override
  final dynamic id;
  @override
  final dynamic mentor;
  @override
  final dynamic mentee;
  @override
  @JsonKey()
  final String status;
  @override
  final String message;
  @override
  final String? responseMessage;
  @override
  final String createdAt;
  @override
  final String? respondedAt;

  @override
  String toString() {
    return 'MentorshipRequestDto(id: $id, mentor: $mentor, mentee: $mentee, status: $status, message: $message, responseMessage: $responseMessage, createdAt: $createdAt, respondedAt: $respondedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MentorshipRequestDtoImpl &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.mentor, mentor) &&
            const DeepCollectionEquality().equals(other.mentee, mentee) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.responseMessage, responseMessage) ||
                other.responseMessage == responseMessage) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.respondedAt, respondedAt) ||
                other.respondedAt == respondedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(id),
    const DeepCollectionEquality().hash(mentor),
    const DeepCollectionEquality().hash(mentee),
    status,
    message,
    responseMessage,
    createdAt,
    respondedAt,
  );

  /// Create a copy of MentorshipRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MentorshipRequestDtoImplCopyWith<_$MentorshipRequestDtoImpl>
  get copyWith =>
      __$$MentorshipRequestDtoImplCopyWithImpl<_$MentorshipRequestDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MentorshipRequestDtoImplToJson(this);
  }
}

abstract class _MentorshipRequestDto implements MentorshipRequestDto {
  const factory _MentorshipRequestDto({
    required final dynamic id,
    required final dynamic mentor,
    required final dynamic mentee,
    final String status,
    required final String message,
    final String? responseMessage,
    required final String createdAt,
    final String? respondedAt,
  }) = _$MentorshipRequestDtoImpl;

  factory _MentorshipRequestDto.fromJson(Map<String, dynamic> json) =
      _$MentorshipRequestDtoImpl.fromJson;

  @override
  dynamic get id;
  @override
  dynamic get mentor;
  @override
  dynamic get mentee;
  @override
  String get status;
  @override
  String get message;
  @override
  String? get responseMessage;
  @override
  String get createdAt;
  @override
  String? get respondedAt;

  /// Create a copy of MentorshipRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MentorshipRequestDtoImplCopyWith<_$MentorshipRequestDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

MentorshipConnectionDto _$MentorshipConnectionDtoFromJson(
  Map<String, dynamic> json,
) {
  return _MentorshipConnectionDto.fromJson(json);
}

/// @nodoc
mixin _$MentorshipConnectionDto {
  dynamic get id => throw _privateConstructorUsedError;
  dynamic get mentor => throw _privateConstructorUsedError;
  dynamic get mentee => throw _privateConstructorUsedError;
  String get startedAt => throw _privateConstructorUsedError;
  String? get endedAt => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this MentorshipConnectionDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MentorshipConnectionDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MentorshipConnectionDtoCopyWith<MentorshipConnectionDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MentorshipConnectionDtoCopyWith<$Res> {
  factory $MentorshipConnectionDtoCopyWith(
    MentorshipConnectionDto value,
    $Res Function(MentorshipConnectionDto) then,
  ) = _$MentorshipConnectionDtoCopyWithImpl<$Res, MentorshipConnectionDto>;
  @useResult
  $Res call({
    dynamic id,
    dynamic mentor,
    dynamic mentee,
    String startedAt,
    String? endedAt,
    bool isActive,
    String? notes,
  });
}

/// @nodoc
class _$MentorshipConnectionDtoCopyWithImpl<
  $Res,
  $Val extends MentorshipConnectionDto
>
    implements $MentorshipConnectionDtoCopyWith<$Res> {
  _$MentorshipConnectionDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MentorshipConnectionDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? mentor = freezed,
    Object? mentee = freezed,
    Object? startedAt = null,
    Object? endedAt = freezed,
    Object? isActive = null,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            mentor: freezed == mentor
                ? _value.mentor
                : mentor // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            mentee: freezed == mentee
                ? _value.mentee
                : mentee // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            startedAt: null == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as String,
            endedAt: freezed == endedAt
                ? _value.endedAt
                : endedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MentorshipConnectionDtoImplCopyWith<$Res>
    implements $MentorshipConnectionDtoCopyWith<$Res> {
  factory _$$MentorshipConnectionDtoImplCopyWith(
    _$MentorshipConnectionDtoImpl value,
    $Res Function(_$MentorshipConnectionDtoImpl) then,
  ) = __$$MentorshipConnectionDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    dynamic id,
    dynamic mentor,
    dynamic mentee,
    String startedAt,
    String? endedAt,
    bool isActive,
    String? notes,
  });
}

/// @nodoc
class __$$MentorshipConnectionDtoImplCopyWithImpl<$Res>
    extends
        _$MentorshipConnectionDtoCopyWithImpl<
          $Res,
          _$MentorshipConnectionDtoImpl
        >
    implements _$$MentorshipConnectionDtoImplCopyWith<$Res> {
  __$$MentorshipConnectionDtoImplCopyWithImpl(
    _$MentorshipConnectionDtoImpl _value,
    $Res Function(_$MentorshipConnectionDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MentorshipConnectionDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? mentor = freezed,
    Object? mentee = freezed,
    Object? startedAt = null,
    Object? endedAt = freezed,
    Object? isActive = null,
    Object? notes = freezed,
  }) {
    return _then(
      _$MentorshipConnectionDtoImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        mentor: freezed == mentor
            ? _value.mentor
            : mentor // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        mentee: freezed == mentee
            ? _value.mentee
            : mentee // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        startedAt: null == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as String,
        endedAt: freezed == endedAt
            ? _value.endedAt
            : endedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MentorshipConnectionDtoImpl implements _MentorshipConnectionDto {
  const _$MentorshipConnectionDtoImpl({
    required this.id,
    required this.mentor,
    required this.mentee,
    required this.startedAt,
    this.endedAt,
    this.isActive = true,
    this.notes,
  });

  factory _$MentorshipConnectionDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MentorshipConnectionDtoImplFromJson(json);

  @override
  final dynamic id;
  @override
  final dynamic mentor;
  @override
  final dynamic mentee;
  @override
  final String startedAt;
  @override
  final String? endedAt;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final String? notes;

  @override
  String toString() {
    return 'MentorshipConnectionDto(id: $id, mentor: $mentor, mentee: $mentee, startedAt: $startedAt, endedAt: $endedAt, isActive: $isActive, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MentorshipConnectionDtoImpl &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.mentor, mentor) &&
            const DeepCollectionEquality().equals(other.mentee, mentee) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(id),
    const DeepCollectionEquality().hash(mentor),
    const DeepCollectionEquality().hash(mentee),
    startedAt,
    endedAt,
    isActive,
    notes,
  );

  /// Create a copy of MentorshipConnectionDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MentorshipConnectionDtoImplCopyWith<_$MentorshipConnectionDtoImpl>
  get copyWith =>
      __$$MentorshipConnectionDtoImplCopyWithImpl<
        _$MentorshipConnectionDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MentorshipConnectionDtoImplToJson(this);
  }
}

abstract class _MentorshipConnectionDto implements MentorshipConnectionDto {
  const factory _MentorshipConnectionDto({
    required final dynamic id,
    required final dynamic mentor,
    required final dynamic mentee,
    required final String startedAt,
    final String? endedAt,
    final bool isActive,
    final String? notes,
  }) = _$MentorshipConnectionDtoImpl;

  factory _MentorshipConnectionDto.fromJson(Map<String, dynamic> json) =
      _$MentorshipConnectionDtoImpl.fromJson;

  @override
  dynamic get id;
  @override
  dynamic get mentor;
  @override
  dynamic get mentee;
  @override
  String get startedAt;
  @override
  String? get endedAt;
  @override
  bool get isActive;
  @override
  String? get notes;

  /// Create a copy of MentorshipConnectionDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MentorshipConnectionDtoImplCopyWith<_$MentorshipConnectionDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

MentorsListResponse _$MentorsListResponseFromJson(Map<String, dynamic> json) {
  return _MentorsListResponse.fromJson(json);
}

/// @nodoc
mixin _$MentorsListResponse {
  List<MentorDto> get docs => throw _privateConstructorUsedError;
  int get totalDocs => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  bool get hasNextPage => throw _privateConstructorUsedError;
  bool get hasPrevPage => throw _privateConstructorUsedError;

  /// Serializes this MentorsListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MentorsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MentorsListResponseCopyWith<MentorsListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MentorsListResponseCopyWith<$Res> {
  factory $MentorsListResponseCopyWith(
    MentorsListResponse value,
    $Res Function(MentorsListResponse) then,
  ) = _$MentorsListResponseCopyWithImpl<$Res, MentorsListResponse>;
  @useResult
  $Res call({
    List<MentorDto> docs,
    int totalDocs,
    int limit,
    int page,
    int totalPages,
    bool hasNextPage,
    bool hasPrevPage,
  });
}

/// @nodoc
class _$MentorsListResponseCopyWithImpl<$Res, $Val extends MentorsListResponse>
    implements $MentorsListResponseCopyWith<$Res> {
  _$MentorsListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MentorsListResponse
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
                      as List<MentorDto>,
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
abstract class _$$MentorsListResponseImplCopyWith<$Res>
    implements $MentorsListResponseCopyWith<$Res> {
  factory _$$MentorsListResponseImplCopyWith(
    _$MentorsListResponseImpl value,
    $Res Function(_$MentorsListResponseImpl) then,
  ) = __$$MentorsListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<MentorDto> docs,
    int totalDocs,
    int limit,
    int page,
    int totalPages,
    bool hasNextPage,
    bool hasPrevPage,
  });
}

/// @nodoc
class __$$MentorsListResponseImplCopyWithImpl<$Res>
    extends _$MentorsListResponseCopyWithImpl<$Res, _$MentorsListResponseImpl>
    implements _$$MentorsListResponseImplCopyWith<$Res> {
  __$$MentorsListResponseImplCopyWithImpl(
    _$MentorsListResponseImpl _value,
    $Res Function(_$MentorsListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MentorsListResponse
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
      _$MentorsListResponseImpl(
        docs: null == docs
            ? _value._docs
            : docs // ignore: cast_nullable_to_non_nullable
                  as List<MentorDto>,
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
class _$MentorsListResponseImpl implements _MentorsListResponse {
  const _$MentorsListResponseImpl({
    required final List<MentorDto> docs,
    required this.totalDocs,
    required this.limit,
    required this.page,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPrevPage,
  }) : _docs = docs;

  factory _$MentorsListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MentorsListResponseImplFromJson(json);

  final List<MentorDto> _docs;
  @override
  List<MentorDto> get docs {
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
    return 'MentorsListResponse(docs: $docs, totalDocs: $totalDocs, limit: $limit, page: $page, totalPages: $totalPages, hasNextPage: $hasNextPage, hasPrevPage: $hasPrevPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MentorsListResponseImpl &&
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

  /// Create a copy of MentorsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MentorsListResponseImplCopyWith<_$MentorsListResponseImpl> get copyWith =>
      __$$MentorsListResponseImplCopyWithImpl<_$MentorsListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MentorsListResponseImplToJson(this);
  }
}

abstract class _MentorsListResponse implements MentorsListResponse {
  const factory _MentorsListResponse({
    required final List<MentorDto> docs,
    required final int totalDocs,
    required final int limit,
    required final int page,
    required final int totalPages,
    required final bool hasNextPage,
    required final bool hasPrevPage,
  }) = _$MentorsListResponseImpl;

  factory _MentorsListResponse.fromJson(Map<String, dynamic> json) =
      _$MentorsListResponseImpl.fromJson;

  @override
  List<MentorDto> get docs;
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

  /// Create a copy of MentorsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MentorsListResponseImplCopyWith<_$MentorsListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MentorshipRequestsListResponse _$MentorshipRequestsListResponseFromJson(
  Map<String, dynamic> json,
) {
  return _MentorshipRequestsListResponse.fromJson(json);
}

/// @nodoc
mixin _$MentorshipRequestsListResponse {
  List<MentorshipRequestDto> get docs => throw _privateConstructorUsedError;
  int get totalDocs => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  bool get hasNextPage => throw _privateConstructorUsedError;
  bool get hasPrevPage => throw _privateConstructorUsedError;

  /// Serializes this MentorshipRequestsListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MentorshipRequestsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MentorshipRequestsListResponseCopyWith<MentorshipRequestsListResponse>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MentorshipRequestsListResponseCopyWith<$Res> {
  factory $MentorshipRequestsListResponseCopyWith(
    MentorshipRequestsListResponse value,
    $Res Function(MentorshipRequestsListResponse) then,
  ) =
      _$MentorshipRequestsListResponseCopyWithImpl<
        $Res,
        MentorshipRequestsListResponse
      >;
  @useResult
  $Res call({
    List<MentorshipRequestDto> docs,
    int totalDocs,
    int limit,
    int page,
    int totalPages,
    bool hasNextPage,
    bool hasPrevPage,
  });
}

/// @nodoc
class _$MentorshipRequestsListResponseCopyWithImpl<
  $Res,
  $Val extends MentorshipRequestsListResponse
>
    implements $MentorshipRequestsListResponseCopyWith<$Res> {
  _$MentorshipRequestsListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MentorshipRequestsListResponse
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
                      as List<MentorshipRequestDto>,
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
abstract class _$$MentorshipRequestsListResponseImplCopyWith<$Res>
    implements $MentorshipRequestsListResponseCopyWith<$Res> {
  factory _$$MentorshipRequestsListResponseImplCopyWith(
    _$MentorshipRequestsListResponseImpl value,
    $Res Function(_$MentorshipRequestsListResponseImpl) then,
  ) = __$$MentorshipRequestsListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<MentorshipRequestDto> docs,
    int totalDocs,
    int limit,
    int page,
    int totalPages,
    bool hasNextPage,
    bool hasPrevPage,
  });
}

/// @nodoc
class __$$MentorshipRequestsListResponseImplCopyWithImpl<$Res>
    extends
        _$MentorshipRequestsListResponseCopyWithImpl<
          $Res,
          _$MentorshipRequestsListResponseImpl
        >
    implements _$$MentorshipRequestsListResponseImplCopyWith<$Res> {
  __$$MentorshipRequestsListResponseImplCopyWithImpl(
    _$MentorshipRequestsListResponseImpl _value,
    $Res Function(_$MentorshipRequestsListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MentorshipRequestsListResponse
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
      _$MentorshipRequestsListResponseImpl(
        docs: null == docs
            ? _value._docs
            : docs // ignore: cast_nullable_to_non_nullable
                  as List<MentorshipRequestDto>,
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
class _$MentorshipRequestsListResponseImpl
    implements _MentorshipRequestsListResponse {
  const _$MentorshipRequestsListResponseImpl({
    required final List<MentorshipRequestDto> docs,
    required this.totalDocs,
    required this.limit,
    required this.page,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPrevPage,
  }) : _docs = docs;

  factory _$MentorshipRequestsListResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$MentorshipRequestsListResponseImplFromJson(json);

  final List<MentorshipRequestDto> _docs;
  @override
  List<MentorshipRequestDto> get docs {
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
    return 'MentorshipRequestsListResponse(docs: $docs, totalDocs: $totalDocs, limit: $limit, page: $page, totalPages: $totalPages, hasNextPage: $hasNextPage, hasPrevPage: $hasPrevPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MentorshipRequestsListResponseImpl &&
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

  /// Create a copy of MentorshipRequestsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MentorshipRequestsListResponseImplCopyWith<
    _$MentorshipRequestsListResponseImpl
  >
  get copyWith =>
      __$$MentorshipRequestsListResponseImplCopyWithImpl<
        _$MentorshipRequestsListResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MentorshipRequestsListResponseImplToJson(this);
  }
}

abstract class _MentorshipRequestsListResponse
    implements MentorshipRequestsListResponse {
  const factory _MentorshipRequestsListResponse({
    required final List<MentorshipRequestDto> docs,
    required final int totalDocs,
    required final int limit,
    required final int page,
    required final int totalPages,
    required final bool hasNextPage,
    required final bool hasPrevPage,
  }) = _$MentorshipRequestsListResponseImpl;

  factory _MentorshipRequestsListResponse.fromJson(Map<String, dynamic> json) =
      _$MentorshipRequestsListResponseImpl.fromJson;

  @override
  List<MentorshipRequestDto> get docs;
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

  /// Create a copy of MentorshipRequestsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MentorshipRequestsListResponseImplCopyWith<
    _$MentorshipRequestsListResponseImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

MentorshipConnectionsListResponse _$MentorshipConnectionsListResponseFromJson(
  Map<String, dynamic> json,
) {
  return _MentorshipConnectionsListResponse.fromJson(json);
}

/// @nodoc
mixin _$MentorshipConnectionsListResponse {
  List<MentorshipConnectionDto> get docs => throw _privateConstructorUsedError;
  int get totalDocs => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  bool get hasNextPage => throw _privateConstructorUsedError;
  bool get hasPrevPage => throw _privateConstructorUsedError;

  /// Serializes this MentorshipConnectionsListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MentorshipConnectionsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MentorshipConnectionsListResponseCopyWith<MentorshipConnectionsListResponse>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MentorshipConnectionsListResponseCopyWith<$Res> {
  factory $MentorshipConnectionsListResponseCopyWith(
    MentorshipConnectionsListResponse value,
    $Res Function(MentorshipConnectionsListResponse) then,
  ) =
      _$MentorshipConnectionsListResponseCopyWithImpl<
        $Res,
        MentorshipConnectionsListResponse
      >;
  @useResult
  $Res call({
    List<MentorshipConnectionDto> docs,
    int totalDocs,
    int limit,
    int page,
    int totalPages,
    bool hasNextPage,
    bool hasPrevPage,
  });
}

/// @nodoc
class _$MentorshipConnectionsListResponseCopyWithImpl<
  $Res,
  $Val extends MentorshipConnectionsListResponse
>
    implements $MentorshipConnectionsListResponseCopyWith<$Res> {
  _$MentorshipConnectionsListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MentorshipConnectionsListResponse
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
                      as List<MentorshipConnectionDto>,
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
abstract class _$$MentorshipConnectionsListResponseImplCopyWith<$Res>
    implements $MentorshipConnectionsListResponseCopyWith<$Res> {
  factory _$$MentorshipConnectionsListResponseImplCopyWith(
    _$MentorshipConnectionsListResponseImpl value,
    $Res Function(_$MentorshipConnectionsListResponseImpl) then,
  ) = __$$MentorshipConnectionsListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<MentorshipConnectionDto> docs,
    int totalDocs,
    int limit,
    int page,
    int totalPages,
    bool hasNextPage,
    bool hasPrevPage,
  });
}

/// @nodoc
class __$$MentorshipConnectionsListResponseImplCopyWithImpl<$Res>
    extends
        _$MentorshipConnectionsListResponseCopyWithImpl<
          $Res,
          _$MentorshipConnectionsListResponseImpl
        >
    implements _$$MentorshipConnectionsListResponseImplCopyWith<$Res> {
  __$$MentorshipConnectionsListResponseImplCopyWithImpl(
    _$MentorshipConnectionsListResponseImpl _value,
    $Res Function(_$MentorshipConnectionsListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MentorshipConnectionsListResponse
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
      _$MentorshipConnectionsListResponseImpl(
        docs: null == docs
            ? _value._docs
            : docs // ignore: cast_nullable_to_non_nullable
                  as List<MentorshipConnectionDto>,
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
class _$MentorshipConnectionsListResponseImpl
    implements _MentorshipConnectionsListResponse {
  const _$MentorshipConnectionsListResponseImpl({
    required final List<MentorshipConnectionDto> docs,
    required this.totalDocs,
    required this.limit,
    required this.page,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPrevPage,
  }) : _docs = docs;

  factory _$MentorshipConnectionsListResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$MentorshipConnectionsListResponseImplFromJson(json);

  final List<MentorshipConnectionDto> _docs;
  @override
  List<MentorshipConnectionDto> get docs {
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
    return 'MentorshipConnectionsListResponse(docs: $docs, totalDocs: $totalDocs, limit: $limit, page: $page, totalPages: $totalPages, hasNextPage: $hasNextPage, hasPrevPage: $hasPrevPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MentorshipConnectionsListResponseImpl &&
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

  /// Create a copy of MentorshipConnectionsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MentorshipConnectionsListResponseImplCopyWith<
    _$MentorshipConnectionsListResponseImpl
  >
  get copyWith =>
      __$$MentorshipConnectionsListResponseImplCopyWithImpl<
        _$MentorshipConnectionsListResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MentorshipConnectionsListResponseImplToJson(this);
  }
}

abstract class _MentorshipConnectionsListResponse
    implements MentorshipConnectionsListResponse {
  const factory _MentorshipConnectionsListResponse({
    required final List<MentorshipConnectionDto> docs,
    required final int totalDocs,
    required final int limit,
    required final int page,
    required final int totalPages,
    required final bool hasNextPage,
    required final bool hasPrevPage,
  }) = _$MentorshipConnectionsListResponseImpl;

  factory _MentorshipConnectionsListResponse.fromJson(
    Map<String, dynamic> json,
  ) = _$MentorshipConnectionsListResponseImpl.fromJson;

  @override
  List<MentorshipConnectionDto> get docs;
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

  /// Create a copy of MentorshipConnectionsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MentorshipConnectionsListResponseImplCopyWith<
    _$MentorshipConnectionsListResponseImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

SendMentorshipRequestDto _$SendMentorshipRequestDtoFromJson(
  Map<String, dynamic> json,
) {
  return _SendMentorshipRequestDto.fromJson(json);
}

/// @nodoc
mixin _$SendMentorshipRequestDto {
  String get mentorId => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  /// Serializes this SendMentorshipRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SendMentorshipRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SendMentorshipRequestDtoCopyWith<SendMentorshipRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendMentorshipRequestDtoCopyWith<$Res> {
  factory $SendMentorshipRequestDtoCopyWith(
    SendMentorshipRequestDto value,
    $Res Function(SendMentorshipRequestDto) then,
  ) = _$SendMentorshipRequestDtoCopyWithImpl<$Res, SendMentorshipRequestDto>;
  @useResult
  $Res call({String mentorId, String message});
}

/// @nodoc
class _$SendMentorshipRequestDtoCopyWithImpl<
  $Res,
  $Val extends SendMentorshipRequestDto
>
    implements $SendMentorshipRequestDtoCopyWith<$Res> {
  _$SendMentorshipRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SendMentorshipRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? mentorId = null, Object? message = null}) {
    return _then(
      _value.copyWith(
            mentorId: null == mentorId
                ? _value.mentorId
                : mentorId // ignore: cast_nullable_to_non_nullable
                      as String,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SendMentorshipRequestDtoImplCopyWith<$Res>
    implements $SendMentorshipRequestDtoCopyWith<$Res> {
  factory _$$SendMentorshipRequestDtoImplCopyWith(
    _$SendMentorshipRequestDtoImpl value,
    $Res Function(_$SendMentorshipRequestDtoImpl) then,
  ) = __$$SendMentorshipRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String mentorId, String message});
}

/// @nodoc
class __$$SendMentorshipRequestDtoImplCopyWithImpl<$Res>
    extends
        _$SendMentorshipRequestDtoCopyWithImpl<
          $Res,
          _$SendMentorshipRequestDtoImpl
        >
    implements _$$SendMentorshipRequestDtoImplCopyWith<$Res> {
  __$$SendMentorshipRequestDtoImplCopyWithImpl(
    _$SendMentorshipRequestDtoImpl _value,
    $Res Function(_$SendMentorshipRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SendMentorshipRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? mentorId = null, Object? message = null}) {
    return _then(
      _$SendMentorshipRequestDtoImpl(
        mentorId: null == mentorId
            ? _value.mentorId
            : mentorId // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SendMentorshipRequestDtoImpl implements _SendMentorshipRequestDto {
  const _$SendMentorshipRequestDtoImpl({
    required this.mentorId,
    required this.message,
  });

  factory _$SendMentorshipRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SendMentorshipRequestDtoImplFromJson(json);

  @override
  final String mentorId;
  @override
  final String message;

  @override
  String toString() {
    return 'SendMentorshipRequestDto(mentorId: $mentorId, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendMentorshipRequestDtoImpl &&
            (identical(other.mentorId, mentorId) ||
                other.mentorId == mentorId) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, mentorId, message);

  /// Create a copy of SendMentorshipRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendMentorshipRequestDtoImplCopyWith<_$SendMentorshipRequestDtoImpl>
  get copyWith =>
      __$$SendMentorshipRequestDtoImplCopyWithImpl<
        _$SendMentorshipRequestDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SendMentorshipRequestDtoImplToJson(this);
  }
}

abstract class _SendMentorshipRequestDto implements SendMentorshipRequestDto {
  const factory _SendMentorshipRequestDto({
    required final String mentorId,
    required final String message,
  }) = _$SendMentorshipRequestDtoImpl;

  factory _SendMentorshipRequestDto.fromJson(Map<String, dynamic> json) =
      _$SendMentorshipRequestDtoImpl.fromJson;

  @override
  String get mentorId;
  @override
  String get message;

  /// Create a copy of SendMentorshipRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendMentorshipRequestDtoImplCopyWith<_$SendMentorshipRequestDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

RegisterMentorDto _$RegisterMentorDtoFromJson(Map<String, dynamic> json) {
  return _RegisterMentorDto.fromJson(json);
}

/// @nodoc
mixin _$RegisterMentorDto {
  String get bio => throw _privateConstructorUsedError;
  List<String> get expertise => throw _privateConstructorUsedError;
  int get yearsExperience => throw _privateConstructorUsedError;
  String? get linkedinUrl => throw _privateConstructorUsedError;

  /// Serializes this RegisterMentorDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegisterMentorDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisterMentorDtoCopyWith<RegisterMentorDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterMentorDtoCopyWith<$Res> {
  factory $RegisterMentorDtoCopyWith(
    RegisterMentorDto value,
    $Res Function(RegisterMentorDto) then,
  ) = _$RegisterMentorDtoCopyWithImpl<$Res, RegisterMentorDto>;
  @useResult
  $Res call({
    String bio,
    List<String> expertise,
    int yearsExperience,
    String? linkedinUrl,
  });
}

/// @nodoc
class _$RegisterMentorDtoCopyWithImpl<$Res, $Val extends RegisterMentorDto>
    implements $RegisterMentorDtoCopyWith<$Res> {
  _$RegisterMentorDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterMentorDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bio = null,
    Object? expertise = null,
    Object? yearsExperience = null,
    Object? linkedinUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            bio: null == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                      as String,
            expertise: null == expertise
                ? _value.expertise
                : expertise // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            yearsExperience: null == yearsExperience
                ? _value.yearsExperience
                : yearsExperience // ignore: cast_nullable_to_non_nullable
                      as int,
            linkedinUrl: freezed == linkedinUrl
                ? _value.linkedinUrl
                : linkedinUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RegisterMentorDtoImplCopyWith<$Res>
    implements $RegisterMentorDtoCopyWith<$Res> {
  factory _$$RegisterMentorDtoImplCopyWith(
    _$RegisterMentorDtoImpl value,
    $Res Function(_$RegisterMentorDtoImpl) then,
  ) = __$$RegisterMentorDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String bio,
    List<String> expertise,
    int yearsExperience,
    String? linkedinUrl,
  });
}

/// @nodoc
class __$$RegisterMentorDtoImplCopyWithImpl<$Res>
    extends _$RegisterMentorDtoCopyWithImpl<$Res, _$RegisterMentorDtoImpl>
    implements _$$RegisterMentorDtoImplCopyWith<$Res> {
  __$$RegisterMentorDtoImplCopyWithImpl(
    _$RegisterMentorDtoImpl _value,
    $Res Function(_$RegisterMentorDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RegisterMentorDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bio = null,
    Object? expertise = null,
    Object? yearsExperience = null,
    Object? linkedinUrl = freezed,
  }) {
    return _then(
      _$RegisterMentorDtoImpl(
        bio: null == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String,
        expertise: null == expertise
            ? _value._expertise
            : expertise // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        yearsExperience: null == yearsExperience
            ? _value.yearsExperience
            : yearsExperience // ignore: cast_nullable_to_non_nullable
                  as int,
        linkedinUrl: freezed == linkedinUrl
            ? _value.linkedinUrl
            : linkedinUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RegisterMentorDtoImpl implements _RegisterMentorDto {
  const _$RegisterMentorDtoImpl({
    required this.bio,
    required final List<String> expertise,
    required this.yearsExperience,
    this.linkedinUrl,
  }) : _expertise = expertise;

  factory _$RegisterMentorDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegisterMentorDtoImplFromJson(json);

  @override
  final String bio;
  final List<String> _expertise;
  @override
  List<String> get expertise {
    if (_expertise is EqualUnmodifiableListView) return _expertise;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_expertise);
  }

  @override
  final int yearsExperience;
  @override
  final String? linkedinUrl;

  @override
  String toString() {
    return 'RegisterMentorDto(bio: $bio, expertise: $expertise, yearsExperience: $yearsExperience, linkedinUrl: $linkedinUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterMentorDtoImpl &&
            (identical(other.bio, bio) || other.bio == bio) &&
            const DeepCollectionEquality().equals(
              other._expertise,
              _expertise,
            ) &&
            (identical(other.yearsExperience, yearsExperience) ||
                other.yearsExperience == yearsExperience) &&
            (identical(other.linkedinUrl, linkedinUrl) ||
                other.linkedinUrl == linkedinUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    bio,
    const DeepCollectionEquality().hash(_expertise),
    yearsExperience,
    linkedinUrl,
  );

  /// Create a copy of RegisterMentorDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterMentorDtoImplCopyWith<_$RegisterMentorDtoImpl> get copyWith =>
      __$$RegisterMentorDtoImplCopyWithImpl<_$RegisterMentorDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RegisterMentorDtoImplToJson(this);
  }
}

abstract class _RegisterMentorDto implements RegisterMentorDto {
  const factory _RegisterMentorDto({
    required final String bio,
    required final List<String> expertise,
    required final int yearsExperience,
    final String? linkedinUrl,
  }) = _$RegisterMentorDtoImpl;

  factory _RegisterMentorDto.fromJson(Map<String, dynamic> json) =
      _$RegisterMentorDtoImpl.fromJson;

  @override
  String get bio;
  @override
  List<String> get expertise;
  @override
  int get yearsExperience;
  @override
  String? get linkedinUrl;

  /// Create a copy of RegisterMentorDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterMentorDtoImplCopyWith<_$RegisterMentorDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
