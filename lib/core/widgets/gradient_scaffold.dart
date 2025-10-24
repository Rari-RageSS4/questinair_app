import 'package:flutter/material.dart';
import 'package:questinair_app/core/constants/app_colors.dart';

class GradientScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;

  const GradientScaffold({
    super.key,
    required this.body,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.backgroundGradientTop,
              AppColors.backgroundGradientBottom,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(child: body),
      ),
    );
  }
}
