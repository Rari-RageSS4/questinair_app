import 'package:flutter/material.dart';
import 'package:questinair_app/features/profile/domain/entities/profile_user_entity.dart';

class EditProfileSheet extends StatelessWidget {
  final ProfileUserEntity user;
  const EditProfileSheet({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: const Text(
        "Edit Profile",
      ),
    );
  }
}
