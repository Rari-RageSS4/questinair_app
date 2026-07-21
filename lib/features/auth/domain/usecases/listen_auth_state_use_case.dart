import 'package:questinair_app/features/auth/domain/entities/auth_user_entity.dart';
import 'package:questinair_app/features/auth/domain/repositories/auth_repository.dart';

class ListenAuthStateUseCase {
  final AuthRepository repository;

  ListenAuthStateUseCase(this.repository);

  Stream<AuthUserEntity?> call() {
    return repository.authStateChanges;
  }
}
