import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:questinair_app/features/auth/domain/entities/user_entity.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String profileImageUrl;
  final int questionsCreated;
  final int questionsAnswered;
  const UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.profileImageUrl,
    required this.questionsCreated,
    required this.questionsAnswered,
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

  // 🔹 Convert UserModel to UserEntity
  UserEntity toEntity() {
    return UserEntity(
        uid: uid,
        email: email,
        name: name,
        profileImageUrl: profileImageUrl,
        questionsCreated: questionsCreated,
        questionsAnswered: questionsAnswered);
  }

// 🔹 Create a UserModel from a UserEntity
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
        uid: entity.uid,
        email: entity.email,
        name: entity.name,
        profileImageUrl: entity.profileImageUrl,
        questionsCreated: entity.questionsCreated,
        questionsAnswered: entity.questionsAnswered);
  }
}
