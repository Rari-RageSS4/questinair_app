import 'package:flutter/material.dart';
import 'package:questinair_app/core/constants/app_colors.dart';
import 'package:questinair_app/core/constants/app_text_styles.dart';

class ChallengeSection extends StatefulWidget {
  const ChallengeSection({super.key});

  @override
  State<ChallengeSection> createState() => _ChallengeSectionState();
}

class _ChallengeSectionState extends State<ChallengeSection> {

  bool isChallengeAccepted = false;
  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
