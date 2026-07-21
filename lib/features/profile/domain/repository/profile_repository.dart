import 'package:questinair_app/features/profile/domain/entities/profile_user_entity.dart';

abstract class ProfileRepository {
  Future<void> createProfile(ProfileUserEntity user);
  Future<ProfileUserEntity> getProfile(String uid);
  Future<void> updateProfile(ProfileUserEntity user);
  Future<void> deleteProfile(String uid);

  Future<bool> profileExists(String uid);
}
 