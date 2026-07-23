import 'package:flutter/material.dart';
import 'package:questinair_app/core/constants/app_colors.dart';
import 'package:questinair_app/core/constants/app_text_styles.dart';

class BuildWalletCard extends StatelessWidget {
  final int coins;
  const BuildWalletCard({
    super.key,
    required this.coins,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.18, 0.42, 0.72, 1.0],
          colors: [
            AppColors.silver1,
            AppColors.silver4,
            AppColors.silver2,
            AppColors.silver3,
            AppColors.silver1,
          ],
        ),
        border: Border.all(
          color: const Color(0xFFF8F8F8),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.account_balance_wallet,
            color: Color.fromARGB(255, 240, 193, 53),
            size: 34,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Wallet",
                style: AppTextStyles.subtitle.copyWith(
                  color: Colors.black87,
                ),
              ),
              Text(
                "$coins Coins",
                style: AppTextStyles.title.copyWith(
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
