

import 'package:questinair_app/features/auth/domain/entities/auth_user_entity.dart';

class AuthUserModel {
  final String uid;
  final String email;

  AuthUserModel({
    required this.uid,
    required this.email,
  });

  factory AuthUserModel.fromMap(Map<String, dynamic> data) {
    return AuthUserModel(
      uid: data['uid'] ?? '',
      email: data['email'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
    };
  }

  factory AuthUserModel.fromEntity(AuthUserEntity entity) {
    return AuthUserModel(
      uid: entity.uid,
      email: entity.email,
    );
  }

  AuthUserEntity toEntity() {
    return AuthUserEntity(
      uid: uid,
      email: email,
    );
  }

  AuthUserModel copyWith({
    String? uid,
    String? email,
  }) {
    return AuthUserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
    );
  }
}
