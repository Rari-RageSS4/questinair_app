import 'package:flutter/material.dart';
import 'package:questinair_app/core/constants/app_text_styles.dart';
import 'package:questinair_app/features/profile/domain/entities/profile_user_entity.dart';

class ProfileBio extends StatelessWidget {
  final ProfileUserEntity user;
  const ProfileBio({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            user.bio?.isNotEmpty == true ? user.bio! : "No bio yet.",
            textAlign: TextAlign.center,
            style: AppTextStyles.body,
          ),
        ],
      ),
    );
  }
}
