import 'package:questinair_app/features/profile/domain/entities/profile_user_entity.dart';
import 'package:questinair_app/features/profile/domain/repository/profile_repository.dart';

class CreateProfileUseCase{
  final ProfileRepository repository;
  CreateProfileUseCase(this.repository);

  Future<void> call(ProfileUserEntity user) {
    return repository.createProfile(user);
  }
}