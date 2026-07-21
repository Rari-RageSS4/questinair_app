import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questinair_app/core/constants/app_colors.dart';
import 'package:questinair_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:questinair_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:questinair_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:questinair_app/features/profile/presentation/bloc/profile_event.dart';
import 'package:questinair_app/features/profile/presentation/bloc/profile_state.dart';
import 'package:questinair_app/features/profile/presentation/widgets/build_stat_box.dart';
import 'package:questinair_app/features/profile/presentation/widgets/build_wallet_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    final authState = context.read<AuthBloc>().state;

    if (authState is AuthAuthenticated) {
      context.read<ProfileBloc>().add(
            LoadProfileEvent(authState.user.uid),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ProfileFailure) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is! ProfileLoaded) {
            return const Center(
              child: Text('No profile data available.'),
            );
          }

          final user = state.user;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: user.profileImageUrl.isNotEmpty
                              ? NetworkImage(user.profileImageUrl)
                              : null,
                          child: user.profileImageUrl.isEmpty
                              ? const Icon(Icons.person, size: 60)
                              : null,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.buttonColor),
                            child: IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: AppColors.white,
                                size: 20,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    user.email,
                    style: const TextStyle(
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  BuildWalletCard(coins: user.walletBalance),
                  const SizedBox(height: 30),
                  
                  //bio
                  Text(
                    user.bio?.isNotEmpty == true ? user.bio! : "No bio yet.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BuildStatBox(
                        label: 'Answered',
                        number: user.quizzesAnswered.toString(),
                      ),
                      BuildStatBox(
                        label: 'Created',
                        number: user.quizzesCreated.toString(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      const Text(
                        'Challenge this person?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.buttonColor,
                            ),
                            child: const Text(
                              'Yes',
                              style: TextStyle(color: AppColors.white),
                            ),
                          ),
                          const SizedBox(width: 12),
                          OutlinedButton(
                            onPressed: () {},
                            child: const Text('No'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}



