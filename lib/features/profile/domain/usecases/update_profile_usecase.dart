import 'package:questinair_app/features/profile/domain/entities/profile_user_entity.dart';
import 'package:questinair_app/features/profile/domain/repository/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<void> call(ProfileUserEntity user)  {
    return repository.updateProfile(user);
  }
}