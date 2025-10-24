// lib/features/quiz/data/repo/quiz_repo_impl.dart

import 'package:questinair_app/features/quiz/domain/entities/quiz_entity.dart';
import 'package:questinair_app/features/quiz/domain/exceptions/quiz_exception.dart'; // <--- NEW: Import QuizException
import 'package:questinair_app/features/quiz/domain/repo/quiz_repo.dart';
import '../datasources/quiz_remote_data_source.dart';
import '../models/quiz_model.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizRemoteDataSource remoteDataSource;

  QuizRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> createQuiz(QuizEntity quiz) async {
    try {
      final model = QuizModel.fromEntity(quiz);
      await remoteDataSource.createQuiz(model);
    } on QuizException { // <--- NEW: Catch QuizException
      rethrow; // Re-throw the same exception to propagate it up
    } catch (e) {
      throw QuizException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<List<QuizEntity>> getAllQuizzes() async {
    try {
      final models = await remoteDataSource.getAllQuizzes();
      return models.map((m) => m.toEntity()).toList();
    } on QuizException { // <--- NEW: Catch QuizException
      rethrow; // Re-throw the same exception to propagate it up
    } catch (e) {
      throw QuizException('An unexpected error occurred: $e');
    }
  }
}