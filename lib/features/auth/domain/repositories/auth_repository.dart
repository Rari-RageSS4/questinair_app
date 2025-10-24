import 'package:questinair_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signUp(String email, String password);
  Future<UserEntity> signIn(String email, String password);
  Future<void> signOut();
  Future<UserEntity?> getCurrentUser();

  // stream getter for auth state changes
  /// Returns a stream of [UserEntity] that emits the current user state.
  Stream<UserEntity?> get authStateChanges;
}
