import 'package:questinair_app/features/quiz/domain/repo/quiz_repo.dart';

import '../entities/quiz_entity.dart';

class GetAllQuizzesUseCase {
  final QuizRepository repository;

  GetAllQuizzesUseCase(this.repository);

  Future<List<QuizEntity>> call() async {
    return await repository.getAllQuizzes();
  }
}
