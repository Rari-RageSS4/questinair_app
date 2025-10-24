// lib/features/auth/presentation/screens/splash_screen.dart

import 'package:flutter/material.dart';
// Removed: import 'package:flutter_bloc/flutter_bloc.dart';
// Removed: imports for SignInScreen, HomeScreen, AuthBloc, AuthState, AppRoutes

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // The navigation logic is now handled by the global BlocListener in main.dart
    return const Scaffold(
      body: Center(
        // This is what the user sees during the splash duration.
        // It's a simple loading indicator, you can replace it with your app's logo.
        child: CircularProgressIndicator(),
      ),
    );
  }
}