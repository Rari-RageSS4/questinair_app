import 'package:questinair_app/features/auth/data/models/auth_user_model.dart';

abstract class AuthRemoteDataSource {

  Future<AuthUserModel> signIn(
      String email,
      String password);

  Future<AuthUserModel> signUp(
      String email,
      String password);

  Future<void> signOut();

   Stream<AuthUserModel?> get authStateChanges;
}