import 'package:questinair_app/features/quiz/domain/repo/quiz_repo.dart';

import '../entities/quiz_entity.dart';

class CreateQuizUseCase {
  final QuizRepository repository;

  CreateQuizUseCase(this.repository);

  Future<void> call(QuizEntity quiz) async {
    await repository.createQuiz(quiz);
  }
}
