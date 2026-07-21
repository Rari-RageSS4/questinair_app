import 'package:questinair_app/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:questinair_app/features/profile/domain/repository/profile_repository.dart';
import 'package:questinair_app/features/profile/domain/entities/profile_user_entity.dart';
import 'package:questinair_app/features/profile/data/models/profile_user_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> createProfile(ProfileUserEntity user) {
    final userModel = ProfileUserModel.fromEntity(user);
    return remoteDataSource.createProfile(userModel);
  }

  @override
  Future<ProfileUserEntity> getProfile(String uid) async {
    final userModel = await remoteDataSource.getProfile(uid);
    return userModel.toEntity();
  }

  @override
  Future<void> updateProfile(ProfileUserEntity user) {
    final userModel = ProfileUserModel.fromEntity(user);
    return remoteDataSource.updateProfile(userModel);
  }

  @override
  Future<void> deleteProfile(String uid) {
    return remoteDataSource.deleteProfile(uid);
  }

  @override
  Future<bool> profileExists(String uid) {
    return remoteDataSource.profileExists(uid);
  }
}
