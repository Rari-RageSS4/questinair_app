// lib/features/auth/presentation/bloc/auth_event.dart

import 'package:equatable/equatable.dart';
import 'package:questinair_app/features/auth/domain/entities/user_entity.dart'; // <--- NEW: Import UserEntity

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;

  const SignUpRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignOutRequested extends AuthEvent {
  @override
  List<Object?> get props => [];
}

// <--- NEW EVENT:
class AuthStatusChanged extends AuthEvent {
  final UserEntity? user; // Nullable, as user might become unauthenticated

  const AuthStatusChanged(this.user);

  @override
  List<Object?> get props => [user]; // props must match nullability
}