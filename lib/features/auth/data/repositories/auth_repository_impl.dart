// lib/features/auth/data/repositories/auth_repository_impl.dart
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth; // <--- NEW: Import Firebase Auth
import 'package:questinair_app/features/auth/data/datasources/firebase_auth_datasource.dart'; // <--- NEW: Import DataSource
import 'package:questinair_app/features/auth/data/models/user_model.dart'; // <--- NEW: Import UserModel
import 'package:questinair_app/features/auth/domain/entities/user_entity.dart';
import 'package:questinair_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource firebaseAuthDataSource; // <--- NEW: Inject DataSource

  AuthRepositoryImpl({required this.firebaseAuthDataSource}); // <--- NEW: Constructor

  @override
  Future<UserEntity> signIn(String email, String password) async {
    return await firebaseAuthDataSource.signIn(email, password);
  }

  @override
  Future<UserEntity> signUp(String email, String password) async {
    return await firebaseAuthDataSource.signUp(email, password);
  }

  @override
  Future<void> signOut() async {
    await firebaseAuthDataSource.signOut();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    return firebaseAuthDataSource.getCurrentUser();
  }

  // <--- NEW: Implement the authStateChanges stream getter
  @override
  Stream<UserEntity?> get authStateChanges {
    // This stream comes directly from the data source, mapping Firebase's User
    // to your domain's UserEntity (via UserModel).
    return firebaseAuthDataSource.firebaseAuth.authStateChanges().map(
      (firebase_auth.User? user) {
        if (user == null) {
          return null; // No user logged in
        } else {
          return UserModel.fromFirebaseUser(user); // Convert Firebase User to UserModel (which is a UserEntity)
        }
      },
    );
  }
}