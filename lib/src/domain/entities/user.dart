import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

/// Domain entity representing a user.
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
    String? location,
    @Default([]) List<String> interests,
  }) = _User;
}
