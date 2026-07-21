import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:questinair_app/features/profile/domain/entities/profile_user_entity.dart';

class ProfileUserModel {
  final String uid;
  final String email;
  final String name;
  final String profileImageUrl;
  final Timestamp createdAt;
  final int quizzesAnswered;
  final int quizzesCreated;
  final String? bio;
  final int walletBalance;
  const ProfileUserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.profileImageUrl,
    required this.createdAt,
    required this.quizzesAnswered,
    required this.quizzesCreated,
    this.bio,
    this.walletBalance = 0,
  });

  // 🔹 Create a ProfileUserModel from Firestore document
  factory ProfileUserModel.fromMap(Map<String, dynamic> data) {
    return ProfileUserModel(
        uid: data['uid'] ?? '',
        email: data['email'] ?? '',
        name: data['name'] ?? '',
        profileImageUrl: data['profileImageUrl'] ?? '',
        createdAt: data['createdAt'] ?? Timestamp.now(),
        quizzesAnswered: data['quizzesAnswered'] ?? 0,
        quizzesCreated: data['quizzesCreated'] ?? 0,
        bio: data['bio'],
        walletBalance: data['walletBalance'] ?? 0);
  }

  // 🔹 Convert ProfileUserModel to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'profileImageUrl': profileImageUrl,
      'createdAt': createdAt,
      'quizzesAnswered': quizzesAnswered,
      'quizzesCreated': quizzesCreated,
      'bio': bio,
      'walletBalance': walletBalance,
    };
  }

  // 🔹 CopyWith (helpful when updating profile fields)
  ProfileUserModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? profileImageUrl,
    int? quizzesAnswered,
    int? quizzesCreated,
    String? bio,
    int? walletBalance,
  }) {
    return ProfileUserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt,
      quizzesAnswered: quizzesAnswered ?? this.quizzesAnswered,
      quizzesCreated: quizzesCreated ?? this.quizzesCreated,
      bio: bio ?? this.bio,
      walletBalance: walletBalance ?? this.walletBalance,
    );
  }

  // 🔹 Convert ProfileUserModel to ProfileUserEntity
  ProfileUserEntity toEntity() {
    return ProfileUserEntity(
      uid: uid,
      email: email,
      name: name,
      profileImageUrl: profileImageUrl,
      createdAt: createdAt.toDate(),
      quizzesAnswered: quizzesAnswered,
      quizzesCreated: quizzesCreated,
      bio: bio,
      walletBalance: walletBalance,
    );
  }

// 🔹 Create a ProfileUserModel from a ProfileUserEntity
  factory ProfileUserModel.fromEntity(ProfileUserEntity entity) {
    return ProfileUserModel(
      uid: entity.uid,
      email: entity.email,
      name: entity.name,
      profileImageUrl: entity.profileImageUrl,
      createdAt: Timestamp.fromDate(entity.createdAt),
      quizzesAnswered: entity.quizzesAnswered,
      quizzesCreated: entity.quizzesCreated,
      bio: entity.bio,
      walletBalance: entity.walletBalance,
    );
  }
}
