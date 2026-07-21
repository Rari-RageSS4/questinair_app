import 'package:questinair_app/features/auth/domain/entities/auth_user_entity.dart';

import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<AuthUserEntity> call(String email, String password) {
    return repository.signUp(email, password);
  }
}
