import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static final TextStyle title = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static final TextStyle subtitle = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textColor,
  );

  static final TextStyle body = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textColor,
  );

  static final TextStyle link = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.accent,
    decoration: TextDecoration.underline,
  );

  static final TextStyle button = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
