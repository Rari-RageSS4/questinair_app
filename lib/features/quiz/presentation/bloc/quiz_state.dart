import 'package:equatable/equatable.dart';
import '../../domain/entities/quiz_entity.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object?> get props => [];
}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizSuccess extends QuizState{}

class QuizCreated extends QuizState {}

class QuizError extends QuizState {
  final String message;
  const QuizError(this.message);

  @override
  List<Object?> get props => [message];
}

class QuizzesLoaded extends QuizState {
  final List<QuizEntity> quizzes;

  const QuizzesLoaded(this.quizzes);

  @override
  List<Object?> get props => [quizzes];
}
