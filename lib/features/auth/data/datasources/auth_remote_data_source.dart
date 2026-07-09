import 'package:questinair_app/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {

  Future<UserModel> signIn(
      String email,
      String password);

  Future<UserModel> signUp(
      String email,
      String password);

  Future<void> signOut();

  UserModel? getCurrentUser();

   Stream<UserModel?> get authStateChanges;
}