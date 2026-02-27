import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/auth/auth_models.dart';

/// Service for managing user profiles in Firestore.
class FirestoreProfileService {
  FirestoreProfileService(this._firestore);

  final FirebaseFirestore _firestore;

  /// Collection reference for user profiles.
  CollectionReference<Map<String, dynamic>> get _profilesCollection =>
      _firestore.collection('profiles');

  /// Get a user profile by ID.
  Future<UserDto?> getProfile(String userId) async {
    try {
      final doc = await _profilesCollection.doc(userId).get();
      if (!doc.exists || doc.data() == null) {
        return null;
      }
      return UserDto.fromJson({
        'id': doc.id,
        ...doc.data()!,
      });
    } catch (e) {
      print('Error getting profile: $e');
      return null;
    }
  }

  /// Create or update a user profile.
  Future<UserDto> saveProfile(UserDto user) async {
    try {
      final data = {
        'email': user.email,
        'name': user.name,
        'location': user.location,
        'interests': user.interests,
        'onboardingCompleted': user.onboardingCompleted ?? false,
        'emailVerified': user.emailVerified ?? false,
        'profileImage': user.profileImage,
        'createdAt': user.createdAt ?? FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      await _profilesCollection.doc(user.idString).set(
            data,
            SetOptions(merge: true),
          );

      // Return updated user
      return user.copyWith(
        updatedAt: DateTime.now().toIso8601String(),
      );
    } catch (e) {
      print('Error saving profile: $e');
      rethrow;
    }
  }

  /// Update specific fields of a user profile.
  Future<UserDto?> updateProfile({
    required String userId,
    String? name,
    String? location,
    List<String>? interests,
    bool? onboardingCompleted,
    String? profileImage,
  }) async {
    try {
      final updates = <String, dynamic>{
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (name != null) updates['name'] = name;
      if (location != null) updates['location'] = location;
      if (interests != null) updates['interests'] = interests;
      if (onboardingCompleted != null) {
        updates['onboardingCompleted'] = onboardingCompleted;
      }
      if (profileImage != null) updates['profileImage'] = profileImage;

      await _profilesCollection.doc(userId).update(updates);

      // Fetch and return updated profile
      return getProfile(userId);
    } catch (e) {
      print('Error updating profile: $e');
      return null;
    }
  }

  /// Delete a user profile.
  Future<void> deleteProfile(String userId) async {
    try {
      await _profilesCollection.doc(userId).delete();
    } catch (e) {
      print('Error deleting profile: $e');
    }
  }

  /// Stream of profile changes for real-time updates.
  Stream<UserDto?> profileStream(String userId) {
    return _profilesCollection.doc(userId).snapshots().map((doc) {
      if (!doc.exists || doc.data() == null) {
        return null;
      }
      return UserDto.fromJson({
        'id': doc.id,
        ...doc.data()!,
      });
    });
  }

  /// Create initial profile for a new user.
  Future<UserDto> createInitialProfile({
    required String userId,
    required String email,
    String? name,
  }) async {
    final user = UserDto(
      id: userId,
      email: email,
      name: name,
      onboardingCompleted: false,
      emailVerified: false,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    return saveProfile(user);
  }
}

/// Provider for FirebaseFirestore instance.
final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

/// Provider for FirestoreProfileService.
final firestoreProfileServiceProvider = Provider<FirestoreProfileService>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return FirestoreProfileService(firestore);
});
