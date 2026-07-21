// lib/features/auth/data/repositories/auth_repository_impl.dart

import 'package:questinair_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:questinair_app/features/auth/data/models/auth_user_model.dart';
import 'package:questinair_app/features/auth/domain/entities/auth_user_entity.dart';
import 'package:questinair_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AuthUserEntity> signIn(String email, String password) async {
    AuthUserModel model = await remoteDataSource.signIn(email, password);
    return model.toEntity();
  }

  @override
  Future<AuthUserEntity> signUp(String email, String password) async {
    AuthUserModel model = await remoteDataSource.signUp(email, password);
    return model.toEntity();
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }

  @override
  Stream<AuthUserEntity?> get authStateChanges =>
      remoteDataSource.authStateChanges
          .map((AuthUserModel? user) => user?.toEntity());
}
