import 'package:questinair_app/features/auth/domain/entities/auth_user_entity.dart';

abstract class AuthRepository {
  Future<AuthUserEntity> signUp(String email, String password);
  Future<AuthUserEntity> signIn(String email, String password);
  Future<void> signOut();
  Stream<AuthUserEntity?> get authStateChanges;
}
 