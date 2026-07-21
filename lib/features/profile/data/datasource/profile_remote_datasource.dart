import 'package:questinair_app/features/profile/data/models/profile_user_model.dart';

abstract class ProfileRemoteDataSource {

  Future<void> createProfile(ProfileUserModel user);
  
  Future<ProfileUserModel> getProfile(String uid);

  Future<void> updateProfile(ProfileUserModel user);

  Future<void> deleteProfile(String uid);

  Future<bool> profileExists(String uid); 
}
