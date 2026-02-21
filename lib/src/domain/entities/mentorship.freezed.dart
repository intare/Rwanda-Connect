// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mentorship.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Mentor {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get company => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  List<MentorExpertise> get expertise => throw _privateConstructorUsedError;
  int get yearsExperience => throw _privateConstructorUsedError;
  String? get linkedinUrl => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  List<String> get languages => throw _privateConstructorUsedError;
  bool get isAvailable => throw _privateConstructorUsedError;
  int get totalMentees => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  int get reviewCount => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of Mentor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MentorCopyWith<Mentor> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MentorCopyWith<$Res> {
  factory $MentorCopyWith(Mentor value, $Res Function(Mentor) then) =
      _$MentorCopyWithImpl<$Res, Mentor>;
  @useResult
  $Res call({
    String id,
    String userId,
    String name,
    String? avatar,
    String? title,
    String? company,
    String? bio,
    List<MentorExpertise> expertise,
    int yearsExperience,
    String? linkedinUrl,
    String? location,
    List<String> languages,
    bool isAvailable,
    int totalMentees,
    double rating,
    int reviewCount,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$MentorCopyWithImpl<$Res, $Val extends Mentor>
    implements $MentorCopyWith<$Res> {
  _$MentorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Mentor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
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
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
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
                      as String?,
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
                      as List<MentorExpertise>,
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
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MentorImplCopyWith<$Res> implements $MentorCopyWith<$Res> {
  factory _$$MentorImplCopyWith(
    _$MentorImpl value,
    $Res Function(_$MentorImpl) then,
  ) = __$$MentorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String name,
    String? avatar,
    String? title,
    String? company,
    String? bio,
    List<MentorExpertise> expertise,
    int yearsExperience,
    String? linkedinUrl,
    String? location,
    List<String> languages,
    bool isAvailable,
    int totalMentees,
    double rating,
    int reviewCount,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$MentorImplCopyWithImpl<$Res>
    extends _$MentorCopyWithImpl<$Res, _$MentorImpl>
    implements _$$MentorImplCopyWith<$Res> {
  __$$MentorImplCopyWithImpl(
    _$MentorImpl _value,
    $Res Function(_$MentorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Mentor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
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
      _$MentorImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
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
                  as String?,
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
                  as List<MentorExpertise>,
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
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$MentorImpl extends _Mentor {
  const _$MentorImpl({
    required this.id,
    required this.userId,
    required this.name,
    this.avatar,
    this.title,
    this.company,
    this.bio,
    required final List<MentorExpertise> expertise,
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
       _languages = languages,
       super._();

  @override
  final String id;
  @override
  final String userId;
  @override
  final String name;
  @override
  final String? avatar;
  @override
  final String? title;
  @override
  final String? company;
  @override
  final String? bio;
  final List<MentorExpertise> _expertise;
  @override
  List<MentorExpertise> get expertise {
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
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Mentor(id: $id, userId: $userId, name: $name, avatar: $avatar, title: $title, company: $company, bio: $bio, expertise: $expertise, yearsExperience: $yearsExperience, linkedinUrl: $linkedinUrl, location: $location, languages: $languages, isAvailable: $isAvailable, totalMentees: $totalMentees, rating: $rating, reviewCount: $reviewCount, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MentorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
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

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    name,
    avatar,
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

  /// Create a copy of Mentor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MentorImplCopyWith<_$MentorImpl> get copyWith =>
      __$$MentorImplCopyWithImpl<_$MentorImpl>(this, _$identity);
}

abstract class _Mentor extends Mentor {
  const factory _Mentor({
    required final String id,
    required final String userId,
    required final String name,
    final String? avatar,
    final String? title,
    final String? company,
    final String? bio,
    required final List<MentorExpertise> expertise,
    final int yearsExperience,
    final String? linkedinUrl,
    final String? location,
    final List<String> languages,
    final bool isAvailable,
    final int totalMentees,
    final double rating,
    final int reviewCount,
    final DateTime? createdAt,
  }) = _$MentorImpl;
  const _Mentor._() : super._();

  @override
  String get id;
  @override
  String get userId;
  @override
  String get name;
  @override
  String? get avatar;
  @override
  String? get title;
  @override
  String? get company;
  @override
  String? get bio;
  @override
  List<MentorExpertise> get expertise;
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
  DateTime? get createdAt;

  /// Create a copy of Mentor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MentorImplCopyWith<_$MentorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MentorshipRequest {
  String get id => throw _privateConstructorUsedError;
  String get mentorId => throw _privateConstructorUsedError;
  String get menteeId => throw _privateConstructorUsedError;
  MentorshipRequestStatus get status => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String? get mentorName => throw _privateConstructorUsedError;
  String? get mentorAvatar => throw _privateConstructorUsedError;
  String? get mentorTitle => throw _privateConstructorUsedError;
  String? get menteeName => throw _privateConstructorUsedError;
  String? get menteeAvatar => throw _privateConstructorUsedError;
  String? get responseMessage => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get respondedAt => throw _privateConstructorUsedError;

  /// Create a copy of MentorshipRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MentorshipRequestCopyWith<MentorshipRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MentorshipRequestCopyWith<$Res> {
  factory $MentorshipRequestCopyWith(
    MentorshipRequest value,
    $Res Function(MentorshipRequest) then,
  ) = _$MentorshipRequestCopyWithImpl<$Res, MentorshipRequest>;
  @useResult
  $Res call({
    String id,
    String mentorId,
    String menteeId,
    MentorshipRequestStatus status,
    String message,
    String? mentorName,
    String? mentorAvatar,
    String? mentorTitle,
    String? menteeName,
    String? menteeAvatar,
    String? responseMessage,
    DateTime createdAt,
    DateTime? respondedAt,
  });
}

/// @nodoc
class _$MentorshipRequestCopyWithImpl<$Res, $Val extends MentorshipRequest>
    implements $MentorshipRequestCopyWith<$Res> {
  _$MentorshipRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MentorshipRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mentorId = null,
    Object? menteeId = null,
    Object? status = null,
    Object? message = null,
    Object? mentorName = freezed,
    Object? mentorAvatar = freezed,
    Object? mentorTitle = freezed,
    Object? menteeName = freezed,
    Object? menteeAvatar = freezed,
    Object? responseMessage = freezed,
    Object? createdAt = null,
    Object? respondedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            mentorId: null == mentorId
                ? _value.mentorId
                : mentorId // ignore: cast_nullable_to_non_nullable
                      as String,
            menteeId: null == menteeId
                ? _value.menteeId
                : menteeId // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as MentorshipRequestStatus,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            mentorName: freezed == mentorName
                ? _value.mentorName
                : mentorName // ignore: cast_nullable_to_non_nullable
                      as String?,
            mentorAvatar: freezed == mentorAvatar
                ? _value.mentorAvatar
                : mentorAvatar // ignore: cast_nullable_to_non_nullable
                      as String?,
            mentorTitle: freezed == mentorTitle
                ? _value.mentorTitle
                : mentorTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            menteeName: freezed == menteeName
                ? _value.menteeName
                : menteeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            menteeAvatar: freezed == menteeAvatar
                ? _value.menteeAvatar
                : menteeAvatar // ignore: cast_nullable_to_non_nullable
                      as String?,
            responseMessage: freezed == responseMessage
                ? _value.responseMessage
                : responseMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            respondedAt: freezed == respondedAt
                ? _value.respondedAt
                : respondedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MentorshipRequestImplCopyWith<$Res>
    implements $MentorshipRequestCopyWith<$Res> {
  factory _$$MentorshipRequestImplCopyWith(
    _$MentorshipRequestImpl value,
    $Res Function(_$MentorshipRequestImpl) then,
  ) = __$$MentorshipRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String mentorId,
    String menteeId,
    MentorshipRequestStatus status,
    String message,
    String? mentorName,
    String? mentorAvatar,
    String? mentorTitle,
    String? menteeName,
    String? menteeAvatar,
    String? responseMessage,
    DateTime createdAt,
    DateTime? respondedAt,
  });
}

/// @nodoc
class __$$MentorshipRequestImplCopyWithImpl<$Res>
    extends _$MentorshipRequestCopyWithImpl<$Res, _$MentorshipRequestImpl>
    implements _$$MentorshipRequestImplCopyWith<$Res> {
  __$$MentorshipRequestImplCopyWithImpl(
    _$MentorshipRequestImpl _value,
    $Res Function(_$MentorshipRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MentorshipRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mentorId = null,
    Object? menteeId = null,
    Object? status = null,
    Object? message = null,
    Object? mentorName = freezed,
    Object? mentorAvatar = freezed,
    Object? mentorTitle = freezed,
    Object? menteeName = freezed,
    Object? menteeAvatar = freezed,
    Object? responseMessage = freezed,
    Object? createdAt = null,
    Object? respondedAt = freezed,
  }) {
    return _then(
      _$MentorshipRequestImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        mentorId: null == mentorId
            ? _value.mentorId
            : mentorId // ignore: cast_nullable_to_non_nullable
                  as String,
        menteeId: null == menteeId
            ? _value.menteeId
            : menteeId // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as MentorshipRequestStatus,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        mentorName: freezed == mentorName
            ? _value.mentorName
            : mentorName // ignore: cast_nullable_to_non_nullable
                  as String?,
        mentorAvatar: freezed == mentorAvatar
            ? _value.mentorAvatar
            : mentorAvatar // ignore: cast_nullable_to_non_nullable
                  as String?,
        mentorTitle: freezed == mentorTitle
            ? _value.mentorTitle
            : mentorTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        menteeName: freezed == menteeName
            ? _value.menteeName
            : menteeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        menteeAvatar: freezed == menteeAvatar
            ? _value.menteeAvatar
            : menteeAvatar // ignore: cast_nullable_to_non_nullable
                  as String?,
        responseMessage: freezed == responseMessage
            ? _value.responseMessage
            : responseMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        respondedAt: freezed == respondedAt
            ? _value.respondedAt
            : respondedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$MentorshipRequestImpl extends _MentorshipRequest {
  const _$MentorshipRequestImpl({
    required this.id,
    required this.mentorId,
    required this.menteeId,
    required this.status,
    required this.message,
    this.mentorName,
    this.mentorAvatar,
    this.mentorTitle,
    this.menteeName,
    this.menteeAvatar,
    this.responseMessage,
    required this.createdAt,
    this.respondedAt,
  }) : super._();

  @override
  final String id;
  @override
  final String mentorId;
  @override
  final String menteeId;
  @override
  final MentorshipRequestStatus status;
  @override
  final String message;
  @override
  final String? mentorName;
  @override
  final String? mentorAvatar;
  @override
  final String? mentorTitle;
  @override
  final String? menteeName;
  @override
  final String? menteeAvatar;
  @override
  final String? responseMessage;
  @override
  final DateTime createdAt;
  @override
  final DateTime? respondedAt;

  @override
  String toString() {
    return 'MentorshipRequest(id: $id, mentorId: $mentorId, menteeId: $menteeId, status: $status, message: $message, mentorName: $mentorName, mentorAvatar: $mentorAvatar, mentorTitle: $mentorTitle, menteeName: $menteeName, menteeAvatar: $menteeAvatar, responseMessage: $responseMessage, createdAt: $createdAt, respondedAt: $respondedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MentorshipRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.mentorId, mentorId) ||
                other.mentorId == mentorId) &&
            (identical(other.menteeId, menteeId) ||
                other.menteeId == menteeId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.mentorName, mentorName) ||
                other.mentorName == mentorName) &&
            (identical(other.mentorAvatar, mentorAvatar) ||
                other.mentorAvatar == mentorAvatar) &&
            (identical(other.mentorTitle, mentorTitle) ||
                other.mentorTitle == mentorTitle) &&
            (identical(other.menteeName, menteeName) ||
                other.menteeName == menteeName) &&
            (identical(other.menteeAvatar, menteeAvatar) ||
                other.menteeAvatar == menteeAvatar) &&
            (identical(other.responseMessage, responseMessage) ||
                other.responseMessage == responseMessage) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.respondedAt, respondedAt) ||
                other.respondedAt == respondedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    mentorId,
    menteeId,
    status,
    message,
    mentorName,
    mentorAvatar,
    mentorTitle,
    menteeName,
    menteeAvatar,
    responseMessage,
    createdAt,
    respondedAt,
  );

  /// Create a copy of MentorshipRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MentorshipRequestImplCopyWith<_$MentorshipRequestImpl> get copyWith =>
      __$$MentorshipRequestImplCopyWithImpl<_$MentorshipRequestImpl>(
        this,
        _$identity,
      );
}

abstract class _MentorshipRequest extends MentorshipRequest {
  const factory _MentorshipRequest({
    required final String id,
    required final String mentorId,
    required final String menteeId,
    required final MentorshipRequestStatus status,
    required final String message,
    final String? mentorName,
    final String? mentorAvatar,
    final String? mentorTitle,
    final String? menteeName,
    final String? menteeAvatar,
    final String? responseMessage,
    required final DateTime createdAt,
    final DateTime? respondedAt,
  }) = _$MentorshipRequestImpl;
  const _MentorshipRequest._() : super._();

  @override
  String get id;
  @override
  String get mentorId;
  @override
  String get menteeId;
  @override
  MentorshipRequestStatus get status;
  @override
  String get message;
  @override
  String? get mentorName;
  @override
  String? get mentorAvatar;
  @override
  String? get mentorTitle;
  @override
  String? get menteeName;
  @override
  String? get menteeAvatar;
  @override
  String? get responseMessage;
  @override
  DateTime get createdAt;
  @override
  DateTime? get respondedAt;

  /// Create a copy of MentorshipRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MentorshipRequestImplCopyWith<_$MentorshipRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MentorshipConnection {
  String get id => throw _privateConstructorUsedError;
  String get mentorId => throw _privateConstructorUsedError;
  String get menteeId => throw _privateConstructorUsedError;
  Mentor get mentor => throw _privateConstructorUsedError;
  String? get menteeName => throw _privateConstructorUsedError;
  String? get menteeAvatar => throw _privateConstructorUsedError;
  DateTime get startedAt => throw _privateConstructorUsedError;
  DateTime? get endedAt => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Create a copy of MentorshipConnection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MentorshipConnectionCopyWith<MentorshipConnection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MentorshipConnectionCopyWith<$Res> {
  factory $MentorshipConnectionCopyWith(
    MentorshipConnection value,
    $Res Function(MentorshipConnection) then,
  ) = _$MentorshipConnectionCopyWithImpl<$Res, MentorshipConnection>;
  @useResult
  $Res call({
    String id,
    String mentorId,
    String menteeId,
    Mentor mentor,
    String? menteeName,
    String? menteeAvatar,
    DateTime startedAt,
    DateTime? endedAt,
    bool isActive,
    String? notes,
  });

  $MentorCopyWith<$Res> get mentor;
}

/// @nodoc
class _$MentorshipConnectionCopyWithImpl<
  $Res,
  $Val extends MentorshipConnection
>
    implements $MentorshipConnectionCopyWith<$Res> {
  _$MentorshipConnectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MentorshipConnection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mentorId = null,
    Object? menteeId = null,
    Object? mentor = null,
    Object? menteeName = freezed,
    Object? menteeAvatar = freezed,
    Object? startedAt = null,
    Object? endedAt = freezed,
    Object? isActive = null,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            mentorId: null == mentorId
                ? _value.mentorId
                : mentorId // ignore: cast_nullable_to_non_nullable
                      as String,
            menteeId: null == menteeId
                ? _value.menteeId
                : menteeId // ignore: cast_nullable_to_non_nullable
                      as String,
            mentor: null == mentor
                ? _value.mentor
                : mentor // ignore: cast_nullable_to_non_nullable
                      as Mentor,
            menteeName: freezed == menteeName
                ? _value.menteeName
                : menteeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            menteeAvatar: freezed == menteeAvatar
                ? _value.menteeAvatar
                : menteeAvatar // ignore: cast_nullable_to_non_nullable
                      as String?,
            startedAt: null == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endedAt: freezed == endedAt
                ? _value.endedAt
                : endedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
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

  /// Create a copy of MentorshipConnection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MentorCopyWith<$Res> get mentor {
    return $MentorCopyWith<$Res>(_value.mentor, (value) {
      return _then(_value.copyWith(mentor: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MentorshipConnectionImplCopyWith<$Res>
    implements $MentorshipConnectionCopyWith<$Res> {
  factory _$$MentorshipConnectionImplCopyWith(
    _$MentorshipConnectionImpl value,
    $Res Function(_$MentorshipConnectionImpl) then,
  ) = __$$MentorshipConnectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String mentorId,
    String menteeId,
    Mentor mentor,
    String? menteeName,
    String? menteeAvatar,
    DateTime startedAt,
    DateTime? endedAt,
    bool isActive,
    String? notes,
  });

  @override
  $MentorCopyWith<$Res> get mentor;
}

/// @nodoc
class __$$MentorshipConnectionImplCopyWithImpl<$Res>
    extends _$MentorshipConnectionCopyWithImpl<$Res, _$MentorshipConnectionImpl>
    implements _$$MentorshipConnectionImplCopyWith<$Res> {
  __$$MentorshipConnectionImplCopyWithImpl(
    _$MentorshipConnectionImpl _value,
    $Res Function(_$MentorshipConnectionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MentorshipConnection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mentorId = null,
    Object? menteeId = null,
    Object? mentor = null,
    Object? menteeName = freezed,
    Object? menteeAvatar = freezed,
    Object? startedAt = null,
    Object? endedAt = freezed,
    Object? isActive = null,
    Object? notes = freezed,
  }) {
    return _then(
      _$MentorshipConnectionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        mentorId: null == mentorId
            ? _value.mentorId
            : mentorId // ignore: cast_nullable_to_non_nullable
                  as String,
        menteeId: null == menteeId
            ? _value.menteeId
            : menteeId // ignore: cast_nullable_to_non_nullable
                  as String,
        mentor: null == mentor
            ? _value.mentor
            : mentor // ignore: cast_nullable_to_non_nullable
                  as Mentor,
        menteeName: freezed == menteeName
            ? _value.menteeName
            : menteeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        menteeAvatar: freezed == menteeAvatar
            ? _value.menteeAvatar
            : menteeAvatar // ignore: cast_nullable_to_non_nullable
                  as String?,
        startedAt: null == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endedAt: freezed == endedAt
            ? _value.endedAt
            : endedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
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

class _$MentorshipConnectionImpl extends _MentorshipConnection {
  const _$MentorshipConnectionImpl({
    required this.id,
    required this.mentorId,
    required this.menteeId,
    required this.mentor,
    this.menteeName,
    this.menteeAvatar,
    required this.startedAt,
    this.endedAt,
    this.isActive = false,
    this.notes,
  }) : super._();

  @override
  final String id;
  @override
  final String mentorId;
  @override
  final String menteeId;
  @override
  final Mentor mentor;
  @override
  final String? menteeName;
  @override
  final String? menteeAvatar;
  @override
  final DateTime startedAt;
  @override
  final DateTime? endedAt;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final String? notes;

  @override
  String toString() {
    return 'MentorshipConnection(id: $id, mentorId: $mentorId, menteeId: $menteeId, mentor: $mentor, menteeName: $menteeName, menteeAvatar: $menteeAvatar, startedAt: $startedAt, endedAt: $endedAt, isActive: $isActive, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MentorshipConnectionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.mentorId, mentorId) ||
                other.mentorId == mentorId) &&
            (identical(other.menteeId, menteeId) ||
                other.menteeId == menteeId) &&
            (identical(other.mentor, mentor) || other.mentor == mentor) &&
            (identical(other.menteeName, menteeName) ||
                other.menteeName == menteeName) &&
            (identical(other.menteeAvatar, menteeAvatar) ||
                other.menteeAvatar == menteeAvatar) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    mentorId,
    menteeId,
    mentor,
    menteeName,
    menteeAvatar,
    startedAt,
    endedAt,
    isActive,
    notes,
  );

  /// Create a copy of MentorshipConnection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MentorshipConnectionImplCopyWith<_$MentorshipConnectionImpl>
  get copyWith =>
      __$$MentorshipConnectionImplCopyWithImpl<_$MentorshipConnectionImpl>(
        this,
        _$identity,
      );
}

abstract class _MentorshipConnection extends MentorshipConnection {
  const factory _MentorshipConnection({
    required final String id,
    required final String mentorId,
    required final String menteeId,
    required final Mentor mentor,
    final String? menteeName,
    final String? menteeAvatar,
    required final DateTime startedAt,
    final DateTime? endedAt,
    final bool isActive,
    final String? notes,
  }) = _$MentorshipConnectionImpl;
  const _MentorshipConnection._() : super._();

  @override
  String get id;
  @override
  String get mentorId;
  @override
  String get menteeId;
  @override
  Mentor get mentor;
  @override
  String? get menteeName;
  @override
  String? get menteeAvatar;
  @override
  DateTime get startedAt;
  @override
  DateTime? get endedAt;
  @override
  bool get isActive;
  @override
  String? get notes;

  /// Create a copy of MentorshipConnection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MentorshipConnectionImplCopyWith<_$MentorshipConnectionImpl>
  get copyWith => throw _privateConstructorUsedError;
}
