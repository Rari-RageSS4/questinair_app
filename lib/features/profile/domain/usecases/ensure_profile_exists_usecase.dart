import 'package:questinair_app/features/profile/domain/entities/profile_user_entity.dart';
import 'package:questinair_app/features/profile/domain/repository/profile_repository.dart';

class EnsureProfileExistsUseCase {
  final ProfileRepository repository;

  EnsureProfileExistsUseCase(this.repository);

  Future<void> call({
    required String uid,
    required String email,
  }) async {
    final exists = await repository.profileExists(uid);

    if (exists) return;

    await repository.createProfile(
      ProfileUserEntity(
        uid: uid,
        email: email,
        name: '',
        profileImageUrl: '',
        createdAt: DateTime.now(),
        quizzesAnswered: 0,
        quizzesCreated: 0,
        bio: '',
        walletBalance: 0,
      ),
    );
  }
}