// lib/features/home/presentation/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // <--- NEW: Import flutter_bloc
import 'package:questinair_app/core/constants/text_styles.dart';
import 'package:questinair_app/core/routes/app_routes.dart';
import 'package:questinair_app/core/widgets/primary_button.dart';
import 'package:questinair_app/features/quiz/presentation/pages/create_quiz_screen.dart';
import 'package:questinair_app/features/quiz/presentation/pages/quiz_list_screen.dart';
import 'package:questinair_app/features/auth/presentation/bloc/auth_bloc.dart'; // <--- NEW: Import AuthBloc
import 'package:questinair_app/features/auth/presentation/bloc/auth_event.dart'; // <--- NEW: Import AuthEvent

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Use global gradient
      appBar: AppBar(
        title: const Text('Home', style: AppTextStyles.title),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          // <--- NEW: Logout button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Dispatch the SignOutRequested event to the AuthBloc
              context.read<AuthBloc>().add(SignOutRequested());
              // The BlocListener in SplashScreen (or another top-level widget)
              // will handle navigation away from HomeScreen when AuthUnauthenticated is emitted.
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButton(
              onPressed: () {
                AppRoutes.instance.goToScreen(const CreateQuizScreen());
              },
              text: 'Create Quiz',
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              onPressed: () {
                AppRoutes.instance.goToScreen(const QuizListScreen());
              },
              text: 'View Quizzes',
            ),
          ],
        ),
      ),
    );
  }
}