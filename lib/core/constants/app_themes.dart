// import 'package:google_fonts/google_fonts.dart';
// import 'package:questinair_app/core/constants/colors.dart';

import 'package:flutter/material.dart';
import 'package:questinair_app/core/constants/app_colors.dart';

class Appthemes {
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.white,

      // Appbar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 4,
      ),

      // Text theme
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
            fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.grey),
      ),

      // ElevatedButton Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),

      // TextButton Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.red,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),

      // Snackbar Theme
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Colors.deepOrange,
        contentTextStyle: TextStyle(color: Colors.white),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
    );
  }
}
//       //* Appbar theme

//       appBarTheme: AppBarTheme(
//         iconTheme: const IconThemeData(color: AppColors.black),
//         surfaceTintColor: AppColors.white,
//         titleTextStyle:
//             GoogleFonts.diphylleia(fontSize: 24, fontWeight: FontWeight.w400),
//         backgroundColor: AppColors.white,
//       ),

//       // Text button
//       textButtonTheme: TextButtonThemeData(
//           style: TextButton.styleFrom(
//         foregroundColor: appPrimary1,
//         textStyle:
//             GoogleFonts.archivo(fontSize: 18, fontWeight: FontWeight.w600),
//       )),

//       // Elevated button
//       elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10)),
//               foregroundColor: AppColors.white,
//               backgroundColor: appPrimary1,
//               shadowColor: appPrimary1.withAlpha((0.7 * 255).toInt()),
//               elevation: 10,
//               textStyle: GoogleFonts.archivo(
//                   fontSize: 24, fontWeight: FontWeight.bold))),

//       // Text Theme
//       textTheme: TextTheme(
//         displayLarge:
//             GoogleFonts.ibmPlexSerif(fontSize: 30, fontWeight: FontWeight.w600),
//         displaySmall: GoogleFonts.roboto(
//             color: appThemeColor2, fontSize: 18, fontWeight: FontWeight.w500),
//         titleLarge: GoogleFonts.archivo(fontSize: 28),
//         titleMedium: GoogleFonts.roboto(fontSize: 22),
//         titleSmall:
//             GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w500),
//         bodyLarge: GoogleFonts.roboto(fontSize: 18),
//         bodyMedium:
//             GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold),
//         bodySmall: GoogleFonts.roboto(fontSize: 16),
//       ),

//       // Bottom navbar them

//       bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//         backgroundColor: AppColors.white,
//       ),
//       snackBarTheme: SnackBarThemeData(
//         contentTextStyle: GoogleFonts.barlow(
//             color: white, fontSize: 20, fontWeight: FontWeight.w500),
//       ),
//       fontFamily: GoogleFonts.roboto().fontFamily,
//       useMaterial3: true,
//       pageTransitionsTheme: const PageTransitionsTheme(
//         builders: {
//           TargetPlatform.android: CupertinoPageTransitionsBuilder(),
//           TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
//         },
//       ),
//     );
//   }

//   static ThemeData darkTheme() {
//     return ThemeData(
//       brightness: Brightness.dark,
//       scaffoldBackgroundColor: black,
//       bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//         backgroundColor: black,
//       ),

//       // Appbar Theme

//       appBarTheme: AppBarTheme(
//         surfaceTintColor: black,
//         iconTheme: const IconThemeData(color: Colors.white),
//         titleTextStyle:
//             GoogleFonts.diphylleia(fontSize: 24, fontWeight: FontWeight.w400),
//         backgroundColor: black,
//       ),
//       useMaterial3: true,

//       // TextButton Theme

//       textButtonTheme: TextButtonThemeData(
//           style: TextButton.styleFrom(
//         foregroundColor: appPrimary1,
//         textStyle:
//             GoogleFonts.archivo(fontSize: 18, fontWeight: FontWeight.w600),
//       )),

//       // ElevatedButton Theme

//       elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//               shape: RoundedRectangleBorder(
//                   side: BorderSide(color: appPrimary2, width: 1),
//                   borderRadius: BorderRadius.circular(10)),
//               foregroundColor: white,
//               backgroundColor: appPrimary1,
//               shadowColor: appPrimary4.withAlpha((0.4 * 255).toInt()),
//               elevation: 4,
//               textStyle: GoogleFonts.archivo(
//                   fontSize: 24, fontWeight: FontWeight.bold))),

//       // Text Theme

//       textTheme: TextTheme(
//         displayLarge:
//             GoogleFonts.ibmPlexSerif(fontSize: 30, fontWeight: FontWeight.w600),
//         displaySmall: GoogleFonts.roboto(
//             color: appThemeColor2, fontSize: 18, fontWeight: FontWeight.w500),
//         titleLarge: GoogleFonts.archivo(fontSize: 28),
//         titleMedium: GoogleFonts.roboto(fontSize: 22),
//         titleSmall:
//             GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w500),
//         bodyLarge: GoogleFonts.roboto(fontSize: 18),
//         bodyMedium:
//             GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold),
//         bodySmall: GoogleFonts.roboto(color: grey, fontSize: 16),
//       ),

//       // Snackbar Theme

//       snackBarTheme: SnackBarThemeData(
//         contentTextStyle: GoogleFonts.barlow(
//             color: white, fontSize: 20, fontWeight: FontWeight.w500),
//       ),
//       pageTransitionsTheme: const PageTransitionsTheme(
//         builders: {
//           TargetPlatform.android: CupertinoPageTransitionsBuilder(),
//           TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
//         },
//       ),
//     );

