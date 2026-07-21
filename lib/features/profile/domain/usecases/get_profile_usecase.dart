import 'package:questinair_app/features/profile/domain/entities/profile_user_entity.dart';
import 'package:questinair_app/features/profile/domain/repository/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<ProfileUserEntity> call(String uid) {
    return repository.getProfile(uid);
  }
}
