import 'package:questinair_app/features/profile/domain/repository/profile_repository.dart';

class DeleteProfileUseCase {
  final ProfileRepository repository;

  DeleteProfileUseCase(this.repository);

  Future<void> call(String uid){
    return repository.deleteProfile(uid);
  }
}