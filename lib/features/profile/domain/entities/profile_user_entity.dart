import 'package:equatable/equatable.dart';

class ProfileUserEntity extends Equatable {
  final String uid;
  final String email;
  final String name;
  final String profileImageUrl;
  final DateTime createdAt;
  final int quizzesAnswered;
  final int quizzesCreated;
  final String? bio;
  final int walletBalance;

  const ProfileUserEntity({
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

  @override
  List<Object> get props => [
        uid,
        email,
        name,
        profileImageUrl,
        createdAt,
        quizzesAnswered,
        quizzesCreated,
        bio ?? '',
        walletBalance,
      ]; // Define properties for equality checks
}
