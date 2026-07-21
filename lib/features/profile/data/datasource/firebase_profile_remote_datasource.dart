import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:questinair_app/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:questinair_app/features/profile/data/models/profile_user_model.dart';

class FirebaseProfileRemoteDatasource implements ProfileRemoteDataSource {
  final FirebaseFirestore firestore;
  FirebaseProfileRemoteDatasource({required this.firestore});

  @override
  Future<void> createProfile(ProfileUserModel user) async {
    await firestore.collection('users').doc(user.uid).set(
          user.toMap(),
        );
  }

  @override
  Future<ProfileUserModel> getProfile(String uid) {
    return firestore.collection('users').doc(uid).get().then((doc) {
      if (doc.exists) {
        return ProfileUserModel.fromMap(doc.data()!);
      } else {
        throw Exception('User not found');
      }
    });
  }

  @override
  Future<void> updateProfile(ProfileUserModel user) {
    return firestore.collection('users').doc(user.uid).update(
      {
        'name': user.name,
        'profileImageUrl': user.profileImageUrl,
        'bio': user.bio,
      },
    );
  }

  @override
  Future<void> deleteProfile(String uid) {
    return firestore.collection('users').doc(uid).delete();
  }

  @override
  Future<bool> profileExists(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    return doc.exists;
  }
}
