import 'package:equatable/equatable.dart';

class AuthUserEntity extends Equatable {
  final String uid;
  final String email;

  const AuthUserEntity({
    required this.uid,
    required this.email,
  });
  
  @override
  List<Object> get props => [
        uid,
        email,
      ]; // Define properties for equality checks
}
