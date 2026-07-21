import 'package:equatable/equatable.dart';
import '../../domain/entities/quiz_entity.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object?> get props => [];
}

class CreateQuizEvent extends QuizEvent {
  final QuizEntity quiz;

  const CreateQuizEvent(this.quiz);

  @override
  List<Object?> get props => [quiz];
}

class LoadQuizzesEvent extends QuizEvent {}
  