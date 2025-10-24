// lib/features/auth/presentation/screens/signin_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questinair_app/core/widgets/app_text_field.dart';
import 'package:questinair_app/core/widgets/primary_button.dart';
import 'package:questinair_app/features/auth/presentation/screens/signup_screen.dart';
import 'package:questinair_app/core/routes/app_routes.dart';
import 'package:questinair_app/features/home/presentation/screens/home_screen.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            // <--- CHANGED: Check for AuthAuthenticated instead of AuthSuccess
            if (state is AuthAuthenticated) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged In')),
              );
              // It's generally better to use named routes or
              // ensure your AppRoutes.instance.goToReplacement manages the navigation stack
              // to prevent the user from going back to login after successful login.
              // For now, this will work.
              AppRoutes.instance.goToReplacement(const HomeScreen());
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Login', style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 30),
                AppTextField(controller: emailController, hintText: 'Email'),
                const SizedBox(height: 16),
                AppTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true),
                const SizedBox(height: 20),
                // Display error and retry button only if it's an AuthFailure state
                if (state is AuthFailure)
                  Column(
                    children: [
                      Text("Error: ${state.message}",
                          style: const TextStyle(color: Colors.red)),
                      const SizedBox(height: 10),
                      // Consider if 'Retry' button is needed here, or if the user
                      // should just re-attempt by clicking the Login button again.
                      // For simplicity, I'll keep it as you had it.
                      PrimaryButton(
                        onPressed: () {
                          if (emailController.text.trim().isEmpty ||
                              passwordController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please fill in all fields')),
                            );
                            return;
                          }
                          context.read<AuthBloc>().add(SignInRequested(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              ));
                        },
                        text: 'Retry',
                      ),
                    ],
                  ),
                // Only show main login button if not in AuthLoading state
                if (state is! AuthLoading)
                  PrimaryButton(
                    onPressed: () {
                      if (emailController.text.trim().isEmpty ||
                          passwordController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please fill in all fields')),
                        );
                        return;
                      }
                      context.read<AuthBloc>().add(SignInRequested(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          ));
                    },
                    text: 'Login',
                  )
                else
                  const CircularProgressIndicator(), // Show loading indicator
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    AppRoutes.instance.goToScreen(const SignUpScreen());
                  },
                  child: Text('Create Account',
                      style: Theme.of(context).textTheme.bodyLarge),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}