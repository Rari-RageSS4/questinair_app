import '../entities/quiz_entity.dart';

abstract class QuizRepository {
  Future<void> createQuiz(QuizEntity quiz);
  Future<List<QuizEntity>> getAllQuizzes();
}
