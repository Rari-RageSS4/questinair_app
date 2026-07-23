import 'package:flutter/material.dart';
import 'package:questinair_app/core/constants/app_text_styles.dart';

class BuildStatBox extends StatelessWidget {
  final String number;
  final String label;
  const BuildStatBox({
    super.key,
    required this.number,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withValues(alpha: .12),
        ),
      ),
      child: Column(
        children: [
          Text(
            number,
            style: AppTextStyles.title,
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
