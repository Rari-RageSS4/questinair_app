// lib/features/auth/presentation/bloc/auth_bloc.dart

import 'dart:async'; // <--- NEW: Import for StreamSubscription

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/repositories/auth_repository.dart'; // <--- NEW: Import AuthRepository
import '../../domain/entities/user_entity.dart'; // <--- NEW: Import UserEntity
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;
  final AuthRepository authRepository; // <--- NEW: Inject AuthRepository

  // <--- NEW: StreamSubscription to listen to auth state changes
  late final StreamSubscription<UserEntity?> _userSubscription;

  AuthBloc({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
    required this.authRepository, // <--- NEW: Require AuthRepository
  }) : super(AuthInitial()) {
    // <--- NEW: Register the new event handler
    on<AuthStatusChanged>(_onAuthStatusChanged);
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignOutRequested>(_onSignOutRequested);

    // <--- NEW: Start listening to the authStateChanges stream
    _userSubscription = authRepository.authStateChanges.listen(
      (user) => add(AuthStatusChanged(user)), // When auth state changes, dispatch AuthStatusChanged event
    );
  }

  // <--- NEW: Handler for AuthStatusChanged event
  Future<void> _onAuthStatusChanged(AuthStatusChanged event, Emitter<AuthState> emit) async {
    // If there's a user, it means they are authenticated
    if (event.user != null) {
      emit(AuthAuthenticated(event.user!));
    } else {
      // If user is null, they are unauthenticated
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onSignInRequested(SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await signInUseCase(event.email, event.password);
      // <--- CHANGED: Emit AuthAuthenticated instead of AuthSuccess
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignUpRequested(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await signUpUseCase(event.email, event.password);
      // <--- CHANGED: Emit AuthAuthenticated instead of AuthSuccess
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignOutRequested(SignOutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await signOutUseCase();
      emit(AuthUnauthenticated()); // <--- CHANGED: Emit AuthUnauthenticated after sign out
      // Note: The _userSubscription will also trigger AuthStatusChanged(null)
      // which will then emit AuthUnauthenticated. So this might be redundant
      // but it ensures immediate state change.
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // <--- NEW: Override the close method to cancel the subscription
  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}