// lib/core/di/injection_container.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

// Auth Feature Imports
import 'package:questinair_app/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:questinair_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:questinair_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:questinair_app/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:questinair_app/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:questinair_app/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:questinair_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:questinair_app/features/quiz/data/datasources/quiz_remote_data_source.dart';

// Quiz Feature Imports
import 'package:questinair_app/features/quiz/data/datasources/quiz_remote_data_source_impl.dart';
import 'package:questinair_app/features/quiz/data/repo/quiz_repo_impl.dart';
import 'package:questinair_app/features/quiz/domain/repo/quiz_repo.dart';
import 'package:questinair_app/features/quiz/domain/usecases/create_quiz_usecase.dart';
import 'package:questinair_app/features/quiz/domain/usecases/get_all_quizzes_usecase.dart';
import 'package:questinair_app/features/quiz/presentation/bloc/quiz_bloc.dart';

final sl = GetIt.instance; // `sl` stands for Service Locator

Future<void> init() async {
  // --- Features - Auth ---
  // Bloc
  sl.registerFactory(() => AuthBloc(
        signInUseCase: sl(),
        signUpUseCase: sl(),
        signOutUseCase: sl(),
        authRepository: sl(), // <--- NEW: Added authRepository
      ));

  // Use cases
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
      // <--- CHANGED: Constructor parameter name from 'dataSource' to 'firebaseAuthDataSource'
      () => AuthRepositoryImpl(firebaseAuthDataSource: sl()));

  // Data sources
  sl.registerLazySingleton(() => FirebaseAuthDataSource(firebaseAuth: sl()));

//------------------------------------------------------------------------------------

  // --- Features - Quiz ---
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

  // --- External Dependencies ---
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
