import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:questinair_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:questinair_app/features/auth/data/models/auth_user_model.dart';
import '../../domain/exceptions/auth_exceptions.dart'; 

class FirebaseAuthDataSource implements AuthRemoteDataSource {
  final firebase_auth.FirebaseAuth firebaseAuth;

  FirebaseAuthDataSource({required this.firebaseAuth});

  /* H E L P E R   M E T H O D S */

  AuthException _handleFirebaseAuthException(
      firebase_auth.FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return const AuthEmailAlreadyInUseException();
      case 'user-not-found':
        return const AuthUserNotFoundException();
      case 'wrong-password':
        return const AuthWrongPasswordException();
      case 'invalid-email':
        return const AuthInvalidEmailException();
      case 'weak-password':
        return const AuthWeakPasswordException();
      default:
        return AuthException(
            e.message ?? 'An unknown authentication error occurred.');
    }
  }

  
  AuthUserModel _toUserModel(firebase_auth.User user) {
    return AuthUserModel(
      uid: user.uid,
      email: user.email ?? '',
    );
  }

  @override
  Future<AuthUserModel> signUp(String email, String password) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw const AuthException(
            'User creation failed: Firebase user is null.');
      }
      return _toUserModel(credential.user!);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw AuthException(
          'An unknown error occurred during sign-up: ${e.toString()}');
    }
  }

  @override
  Future<AuthUserModel> signIn(String email, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw const AuthException('Sign in failed: Firebase user is null.');
      }
      return _toUserModel(credential.user!);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw AuthException(
          'An unknown error occurred during sign-in: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw AuthException('Failed to sign out: ${e.toString()}');
    }
  }

  @override
  Stream<AuthUserModel?> get authStateChanges =>
      firebaseAuth.authStateChanges().map(
            (user) => user == null ? null : _toUserModel(user),
          );
}
