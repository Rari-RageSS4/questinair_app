import 'package:flutter/material.dart';
import 'package:questinair_app/core/constants/app_text_styles.dart';
import 'package:questinair_app/features/profile/domain/entities/profile_user_entity.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileUserEntity user;
  const ProfileHeader({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}
