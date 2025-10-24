import 'question_entity.dart';

class QuizEntity {
  final String id;
  final String title;
  final String createdBy;
  final List<QuestionEntity> questions;

  const QuizEntity({
    required this.id,
    required this.title,
    required this.createdBy,
    required this.questions,
  });
}
