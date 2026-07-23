import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questinair_app/core/constants/app_colors.dart';
import 'package:questinair_app/core/constants/app_text_styles.dart';
import 'package:questinair_app/core/widgets/glass_app_bar.dart';
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
  bool isChallengeAccepted = false;

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
      backgroundColor: Colors.transparent,
      appBar: GlassAppBar(
        title: 'Profile',
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
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
                          radius: 55,
                          backgroundImage: user.profileImageUrl.isNotEmpty
                              ? NetworkImage(user.profileImageUrl)
                              : null,
                          child: user.profileImageUrl.isEmpty
                              ? const Icon(Icons.person, size: 30)
                              : null,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 30,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary,
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 15,
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
                    style: AppTextStyles.subtitle,
                  ),

                  const SizedBox(height: 6),

                  Text(
                    user.email,
                    style: AppTextStyles.body,
                  ),

                  const SizedBox(height: 24),

                  BuildWalletCard(coins: user.walletBalance),

                  const SizedBox(height: 30),

                  // Bio
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.15),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Bio",
                          style: AppTextStyles.subtitle,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          user.bio?.isNotEmpty == true
                              ? user.bio!
                              : "No bio yet.",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.body,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BuildStatBox(
                        label: 'Answered',
                        number: user.quizzesAnswered.toString(),
                      ),
                      const SizedBox(
                        width: 16,
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
                        'Challenge this Person?',
                        style: AppTextStyles.title,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isChallengeAccepted
                                    ? AppColors.primary
                                    : Colors.white.withValues(alpha: 0.1),
                              ),
                              onPressed: () {
                                setState(() {
                                  isChallengeAccepted = true;
                                });
                                print(isChallengeAccepted);
                              },
                              child: const Text('Yes'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: !isChallengeAccepted
                                    ? AppColors.primary
                                    : Colors.white.withValues(alpha: 0.1),
                              ),
                              onPressed: () {
                                setState(() {
                                  isChallengeAccepted = false;
                                });
                              },
                              child: const Text('No'),
                            ),
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
