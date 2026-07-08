import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String name;
  final String profileImageUrl;
  final int questionsCreated;
  final int questionsAnswered;

  const UserEntity({
    required this.uid,
    required this.email,
    required this.name,
    required this.profileImageUrl,
    required this.questionsCreated,
    required this.questionsAnswered,
  });

  @override
  List<Object> get props =>
      [uid, email]; // Define properties for equality checks
}
