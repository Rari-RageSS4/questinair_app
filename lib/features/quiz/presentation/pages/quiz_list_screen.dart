import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questinair_app/core/routes/app_routes.dart';
import 'package:questinair_app/core/widgets/primary_button.dart';
import 'package:questinair_app/features/quiz/presentation/pages/take_quiz_screen.dart';
import '../bloc/quiz_bloc.dart';
import '../bloc/quiz_event.dart';
import '../bloc/quiz_state.dart';

class QuizListScreen extends StatelessWidget {
  const QuizListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<QuizBloc>().add(LoadQuizzesEvent());
 
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: const Text("All Quizzes")),
      body: BlocBuilder<QuizBloc, QuizState>(
        // Update the BlocBuilder
        builder: (context, state) {
          if (state is QuizLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuizError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Error: ${state.message}",
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 10),
                  PrimaryButton(
                    onPressed: () {
                      context.read<QuizBloc>().add(LoadQuizzesEvent());
                    },
                    text: 'Retry',
                  ),
                ],
              ),
            );
          } else if (state is QuizzesLoaded) {
            return ListView.builder(
              itemCount: state.quizzes.length,
              itemBuilder: (context, index) {
                final quiz = state.quizzes[index];
                return ListTile(
                  title: Text(quiz.title,
                      style: Theme.of(context).textTheme.titleLarge),
                  subtitle: Text("Created by ${quiz.createdBy}",
                      style: Theme.of(context).textTheme.bodyLarge),
                  onTap: () {
                    AppRoutes.instance.goToScreen(TakeQuizScreen(quiz: quiz));
                  },
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
