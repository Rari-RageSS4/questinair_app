// lib/features/quiz/presentation/bloc/quiz_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/create_quiz_usecase.dart';
import '../../domain/usecases/get_all_quizzes_usecase.dart';
import '../../domain/exceptions/quiz_exception.dart'; // <--- NEW: Import QuizException
import 'quiz_event.dart';
import 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final CreateQuizUseCase createQuizUseCase;
  final GetAllQuizzesUseCase getAllQuizzesUseCase;

  QuizBloc({
    required this.createQuizUseCase,
    required this.getAllQuizzesUseCase,
  }) : super(QuizInitial()) {
    on<CreateQuizEvent>(_onCreateQuiz);
    on<LoadQuizzesEvent>(_onLoadQuizzes);
  }

  Future<void> _onCreateQuiz(CreateQuizEvent event, Emitter<QuizState> emit) async {
    emit(QuizLoading());
    try {
      await createQuizUseCase(event.quiz);
      emit(QuizCreated());
    } on QuizException catch (e) { // <--- CHANGED: Catch specific QuizException
      emit(QuizError(e.message)); // <--- Use the exception's message
    } catch (e) {
      emit(QuizError(e.toString()));
    }
  }

  Future<void> _onLoadQuizzes(LoadQuizzesEvent event, Emitter<QuizState> emit) async {
    emit(QuizLoading());
    try {
      final quizzes = await getAllQuizzesUseCase();
      emit(QuizzesLoaded(quizzes));
    } on QuizException catch (e) { // <--- CHANGED: Catch specific QuizException
      emit(QuizError(e.message)); // <--- Use the exception's message
    } catch (e) {
      emit(QuizError(e.toString()));
    }
  }
}