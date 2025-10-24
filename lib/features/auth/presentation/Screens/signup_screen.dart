// lib/features/auth/presentation/screens/signup_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questinair_app/core/routes/app_routes.dart';
import 'package:questinair_app/features/auth/presentation/Screens/signin_screen.dart'; // Make sure this path is correct
import 'package:questinair_app/features/home/presentation/screens/home_screen.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'package:questinair_app/core/widgets/app_text_field.dart';
import 'package:questinair_app/core/widgets/primary_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Sign Up'),
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
                const SnackBar(content: Text('Account Created')),
              );
              // As with SignInScreen, consider how navigation is handled
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
                Text('Sign Up',
                    style: Theme.of(context).textTheme.headlineLarge),
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
                      // Consider if 'Retry' button is needed here
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
                          context.read<AuthBloc>().add(SignUpRequested(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              ));
                        },
                        text: 'Retry',
                      ),
                    ],
                  ),
                // Only show main sign up button if not in AuthLoading state
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
                      context.read<AuthBloc>().add(SignUpRequested(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          ));
                    },
                    text: 'Sign Up',
                  )
                else
                  const CircularProgressIndicator(), // Show loading indicator
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    AppRoutes.instance.goToScreen(const SignInScreen());
                  },
                  child: Text('Already have an account? Login',
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