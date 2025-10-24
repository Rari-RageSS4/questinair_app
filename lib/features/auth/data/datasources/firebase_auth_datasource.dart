// lib/features/auth/data/datasources/firebase_auth_datasource.dart

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../models/user_model.dart';
import '../../domain/exceptions/auth_exceptions.dart'; // <--- NEW: Import your custom exceptions

class FirebaseAuthDataSource {
  final firebase_auth.FirebaseAuth firebaseAuth;

  FirebaseAuthDataSource({required this.firebaseAuth});

  Future<UserModel> signUp(String email, String password) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Ensure user is not null, although Firebase usually guarantees this on success
      if (credential.user == null) {
        throw const AuthException('User creation failed: Firebase user is null.');
      }
      return UserModel.fromFirebaseUser(credential.user!);
    } on firebase_auth.FirebaseAuthException catch (e) {
      // <--- NEW: Catch specific Firebase Auth exceptions and map them
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      // <--- NEW: Catch any other unexpected errors
      throw AuthException('An unknown error occurred during sign-up: ${e.toString()}');
    }
  }

  Future<UserModel> signIn(String email, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Ensure user is not null, although Firebase usually guarantees this on success
      if (credential.user == null) {
        throw const AuthException('Sign in failed: Firebase user is null.');
      }
      return UserModel.fromFirebaseUser(credential.user!);
    } on firebase_auth.FirebaseAuthException catch (e) {
      // <--- NEW: Catch specific Firebase Auth exceptions and map them
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      // <--- NEW: Catch any other unexpected errors
      throw AuthException('An unknown error occurred during sign-in: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    // We don't need extensive error handling here as signOut typically fails less often
    // in ways that require specific mapping, but you could add a try-catch if desired.
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw AuthException('Failed to sign out: ${e.toString()}');
    }
  }

  UserModel? getCurrentUser() {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      return UserModel.fromFirebaseUser(user);
    }
    return null;
  }

  // <--- NEW: Helper method to map Firebase Auth exceptions to your custom exceptions
  AuthException _handleFirebaseAuthException(firebase_auth.FirebaseAuthException e) {
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
      // Add more cases here as you encounter them from Firebase errors.
      // For example:
      // case 'network-request-failed': return const AuthNetworkException();
      default:
        return AuthException(e.message ?? 'An unknown authentication error occurred.');
    }
  }
}