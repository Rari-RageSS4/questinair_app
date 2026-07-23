import 'dart:ui';

import 'package:flutter/material.dart';

class GlassAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  const GlassAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: AppBar(
          backgroundColor: Colors.white.withValues(alpha: .08),
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          title: Text(title),
          centerTitle: true,
          leading: leading,
          actions: actions,
        ),
      ),
    );
  }
}