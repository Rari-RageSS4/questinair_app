import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questinair_app/features/profile/domain/usecases/create_profile_usecase.dart';
import 'package:questinair_app/features/profile/domain/usecases/delete_profile_usecase.dart';
import 'package:questinair_app/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:questinair_app/features/profile/domain/usecases/ensure_profile_exists_usecase.dart';
import 'package:questinair_app/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:questinair_app/features/profile/presentation/bloc/profile_event.dart';
import 'package:questinair_app/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final CreateProfileUseCase createProfileUseCase;
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final DeleteProfileUseCase deleteProfileUseCase;
  final EnsureProfileExistsUseCase ensureProfileExistsUseCase;

  ProfileBloc({
    required this.createProfileUseCase,
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
    required this.deleteProfileUseCase,
    required this.ensureProfileExistsUseCase,
  }) : super(ProfileInitial()) {
    on<LoadProfileEvent>(_onLoadProfile);
    on<EnsureProfileExistsEvent>(_onEnsureProfileExists);
    on<CreateProfileEvent>(_onCreateProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<DeleteProfileEvent>(_onDeleteProfile);
  }

  Future<void> _onLoadProfile(
    LoadProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      ProfileLoading(),
    );

    try {
      final user = await getProfileUseCase(event.uid);
      emit(ProfileLoaded(user));
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }

  Future<void> _onEnsureProfileExists(
    EnsureProfileExistsEvent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      await ensureProfileExistsUseCase(
        uid: event.uid,
        email: event.email,
      );
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }

  Future<void> _onCreateProfile(
      CreateProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      await createProfileUseCase(event.user);
      emit(ProfileCreated());
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }

  Future<void> _onUpdateProfile(
      UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      await updateProfileUseCase(event.user);
      emit(ProfileUpdated());
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }

  Future<void> _onDeleteProfile(
      DeleteProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      await deleteProfileUseCase(event.uid);
      emit(ProfileDeleted());
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }
}
