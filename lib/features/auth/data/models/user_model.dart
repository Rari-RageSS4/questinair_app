import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:questinair_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.email,
    required super.name,
    required super.profileImageUrl,
    required super.questionsCreated,
    required super.questionsAnswered,
  });

  // 🔹 Create a UserModel from FirebaseAuth user (Auth login)
  factory UserModel.fromFirebaseUser(firebase_auth.User user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
      profileImageUrl: user.photoURL ?? '',
      questionsCreated: 0,
      questionsAnswered: 0,
    );
  }

  // 🔹 Create a UserModel from Firestore document
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return UserModel(
      uid: data['uid'] ?? '',
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      profileImageUrl: data['profileImageUrl'] ?? '',
      questionsCreated: data['questionsCreated'] ?? 0,
      questionsAnswered: data['questionsAnswered'] ?? 0,
    );
  }

  // 🔹 Convert UserModel to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'profileImageUrl': profileImageUrl,
      'questionsCreated': questionsCreated,
      'questionsAnswered': questionsAnswered,
    };
  }

  // 🔹 CopyWith (helpful when updating profile fields)
  UserModel copyWith({
    String? name,
    String? profileImageUrl,
    int? questionsCreated,
    int? questionsAnswered,
  }) {
    return UserModel(
      uid: uid,
      email: email,
      name: name ?? this.name,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      questionsCreated: questionsCreated ?? this.questionsCreated,
      questionsAnswered: questionsAnswered ?? this.questionsAnswered,
    );
  }
}
