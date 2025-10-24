// lib/features/auth/presentation/bloc/auth_state.dart

import 'package:equatable/equatable.dart';
import 'package:questinair_app/features/auth/domain/entities/user_entity.dart'; // <--- NEW: Import UserEntity

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

// <--- NEW STATES:
class AuthAuthenticated extends AuthState {
  final UserEntity user; // The authenticated user's data

  const AuthAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}

class AuthSignedOut extends AuthState {}