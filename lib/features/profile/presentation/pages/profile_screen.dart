import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questinair_app/core/widgets/glass_app_bar.dart';
import 'package:questinair_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:questinair_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:questinair_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:questinair_app/features/profile/presentation/bloc/profile_event.dart';
import 'package:questinair_app/features/profile/presentation/bloc/profile_state.dart';
import 'package:questinair_app/features/profile/presentation/widgets/build_stat_box.dart';
import 'package:questinair_app/features/profile/presentation/widgets/build_wallet_card.dart';
import 'package:questinair_app/features/profile/presentation/widgets/challenge_section.dart';
import 'package:questinair_app/features/profile/presentation/widgets/profile_bio.dart';
import 'package:questinair_app/features/profile/presentation/widgets/profile_header.dart';

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
    return BlocBuilder<ProfileBloc, ProfileState>(
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

        return Scaffold(
          appBar: GlassAppBar(
            title: 'Profile',
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfileHeader(user: user),

                  const SizedBox(height: 24),

                  BuildWalletCard(coins: user.walletBalance),

                  const SizedBox(height: 24),

                  // Bio
                  ProfileBio(user: user),

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

                  const SizedBox(height: 24),

                  // challenge
                  const ChallengeSection(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
