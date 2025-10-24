// lib/features/auth/data/models/user_model.dart

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:questinair_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.email,
  });

  // This is the factory constructor that was missing or commented out
  factory UserModel.fromFirebaseUser(firebase_auth.User user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '', // Handle potential null email from Firebase
    );
  }

  // The copyWith method you've added
  UserModel copyWith({
    String? uid,
    String? email,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
    );
  }

  // The toJson method you've added
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
    };
  }
}