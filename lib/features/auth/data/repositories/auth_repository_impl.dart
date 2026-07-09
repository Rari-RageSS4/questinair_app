// lib/features/auth/data/repositories/auth_repository_impl.dart

import 'package:questinair_app/features/auth/data/datasources/auth_remote_data_source.dart';
// <--- NEW: Import DataSource
import 'package:questinair_app/features/auth/data/models/user_model.dart'; // <--- NEW: Import UserModel
import 'package:questinair_app/features/auth/domain/entities/user_entity.dart';
import 'package:questinair_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource; // <--- NEW: Inject DataSource

  AuthRepositoryImpl({required this.remoteDataSource}); // <--- NEW: Constructor

  @override
  Future<UserEntity> signIn(String email, String password) async {
    UserModel model = await remoteDataSource.signIn(email, password);
    return model.toEntity();
  }

  @override
  Future<UserEntity> signUp(String email, String password) async {
    UserModel model = await remoteDataSource.signUp(email, password);
    return model.toEntity();
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    UserModel? model =  remoteDataSource.getCurrentUser();
    return model?.toEntity();
  }

  // <--- NEW: Implement the authStateChanges stream getter
  @override
  Stream<UserEntity?> get authStateChanges => remoteDataSource.authStateChanges.map((userModel) => userModel?.toEntity());
}