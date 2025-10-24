import 'package:flutter/material.dart';
import 'package:questinair_app/core/constants/app_colors.dart';
import 'package:questinair_app/core/constants/text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        minimumSize: const Size(double.infinity, 50),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: AppTextStyles.button,
      ),
    );
  }
}
