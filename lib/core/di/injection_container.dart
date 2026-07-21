// lib/core/di/injection_container.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:questinair_app/features/auth/data/datasources/auth_remote_data_source.dart';

// Auth Feature Imports
import 'package:questinair_app/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:questinair_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:questinair_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:questinair_app/features/auth/domain/usecases/listen_auth_state_use_case.dart';
import 'package:questinair_app/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:questinair_app/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:questinair_app/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:questinair_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:questinair_app/features/profile/data/datasource/firebase_profile_remote_datasource.dart';
import 'package:questinair_app/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:questinair_app/features/profile/domain/repository/profile_repository.dart';
import 'package:questinair_app/features/profile/domain/usecases/create_profile_usecase.dart';
import 'package:questinair_app/features/profile/domain/usecases/delete_profile_usecase.dart';
import 'package:questinair_app/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:questinair_app/features/profile/domain/usecases/ensure_profile_exists_usecase.dart';
import 'package:questinair_app/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:questinair_app/features/quiz/data/datasources/quiz_remote_data_source.dart';

// Quiz Feature Imports
import 'package:questinair_app/features/quiz/data/datasources/quiz_remote_data_source_impl.dart';
import 'package:questinair_app/features/quiz/data/repo/quiz_repo_impl.dart';
import 'package:questinair_app/features/quiz/domain/repo/quiz_repo.dart';
import 'package:questinair_app/features/quiz/domain/usecases/create_quiz_usecase.dart';
import 'package:questinair_app/features/quiz/domain/usecases/get_all_quizzes_usecase.dart';
import 'package:questinair_app/features/quiz/presentation/bloc/quiz_bloc.dart';

import '../../features/profile/data/repository/profile_repository_impl.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';

final GetIt sl = GetIt.instance; // `sl` stands for Service Locator

Future<void> init() async {
  _initCore();
  _initAuth();
  _initQuiz();
  _initProfile();
}

void _initCore() {
  // --- External Dependencies ---
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}

void _initAuth() {
  // --- Features - Auth ---
  // Bloc
  sl.registerFactory(() => AuthBloc(
        signInUseCase: sl(),
        signUpUseCase: sl(),
        signOutUseCase: sl(),
        listenAuthStateUseCase: sl(),
       
      ));

  // Use cases
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => ListenAuthStateUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
      // <--- CHANGED: Constructor parameter name from 'dataSource' to 'firebaseAuthDataSource'
      () => AuthRepositoryImpl(remoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => FirebaseAuthDataSource(
      firebaseAuth: sl(),
    ),
  );
}

//------------------------------------------------------------------------------------
// --- Features - Quiz ---
void _initQuiz() {
  // Bloc
  sl.registerFactory(() => QuizBloc(
        createQuizUseCase: sl(),
        getAllQuizzesUseCase: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => CreateQuizUseCase(sl()));
  sl.registerLazySingleton(() => GetAllQuizzesUseCase(sl()));

  // Repository
  sl.registerLazySingleton<QuizRepository>(() => QuizRepositoryImpl(sl()));

  // Data sources
  sl.registerLazySingleton<QuizRemoteDataSource>(
      () => QuizRemoteDataSourceImpl(sl()));
}

//------------------------------------------------------------------------------------

/* --- Features - Profile --- */
void _initProfile() {
// Bloc
  sl.registerFactory(
    () => ProfileBloc(
      createProfileUseCase: sl(),
      getProfileUseCase: sl(),
      updateProfileUseCase: sl(),
      deleteProfileUseCase: sl(),
      ensureProfileExistsUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(
    () => CreateProfileUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => GetProfileUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => UpdateProfileUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => DeleteProfileUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => EnsureProfileExistsUseCase(sl()),
  );

  // Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(remoteDataSource: sl()),
  );
  
  // Data sources
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => FirebaseProfileRemoteDatasource(firestore:sl()),
  );
}
