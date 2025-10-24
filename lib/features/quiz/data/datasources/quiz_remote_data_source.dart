import '../models/quiz_model.dart';

abstract class QuizRemoteDataSource {
  Future<void> createQuiz(QuizModel quiz);
  Future<List<QuizModel>> getAllQuizzes();
}
