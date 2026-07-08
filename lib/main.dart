// In main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questinair_app/core/constants/app_colors.dart';
import 'package:questinair_app/core/constants/app_themes.dart';
import 'package:questinair_app/core/routes/app_routes.dart';
import 'package:questinair_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:questinair_app/features/auth/presentation/bloc/auth_state.dart'; // <--- NEW: Import AuthState
import 'package:questinair_app/features/auth/presentation/screens/splash_screen.dart';
import 'package:questinair_app/features/auth/presentation/screens/signin_screen.dart'; // <--- NEW: Import SignInScreen
import 'package:questinair_app/features/home/presentation/screens/home_screen.dart'; // <--- NEW: Import HomeScreen for direct navigation
import 'package:questinair_app/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'firebase_options.dart';
import 'package:questinair_app/core/di/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on UnsupportedError {
    // DefaultFirebaseOptions not configured for this platform (e.g., windows).
    // Fall back to a no-options initialization so the app can run for development.
    await Firebase.initializeApp();
  }
  await di.init();
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<AuthBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<QuizBloc>(),
        ),
      ],
      // <--- NEW: BlocListener to handle global auth state changes and navigation
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // Use AppRoutes.instance.navigationKey.currentContext to ensure
          // navigation happens on the correct context, especially after logout.
          final currentContext = AppRoutes.instance.navigationKey.currentContext;
          if (currentContext == null) return; // Safety check

          if (state is AuthAuthenticated) {
            // If already on HomeScreen, do nothing. Otherwise, navigate to HomeScreen.
            if (ModalRoute.of(currentContext)?.settings.name != 'HomeScreen') {
               AppRoutes.instance.goToReplacement(const HomeScreen());
            }
          } else if (state is AuthUnauthenticated) {
            // If already on SignInScreen, do nothing. Otherwise, navigate to SignInScreen.
            if (ModalRoute.of(currentContext)?.settings.name != 'SignInScreen') {
                AppRoutes.instance.goToReplacement(const SignInScreen());
            }
          }
          // AuthLoading, AuthFailure, AuthSignedOut (from _onSignOutRequested) will be handled by specific screens or just show splash.
        },
        child: MaterialApp(
          navigatorKey: AppRoutes.instance.navigationKey,
          debugShowCheckedModeBanner: false,
          theme: Appthemes.lightTheme(),
          // <--- CHANGED: home is now determined by the listener, so SplashScreen is the initial entry point
          // The initial state of AuthBloc will trigger the listener to navigate from SplashScreen.
          home: const SplashScreen(),
          builder: (context, child) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.backgroundGradientTop,
                    AppColors.backgroundGradientBottom,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: child,
            );
          },
        ),
      ),
    );
  }
}