import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
class AppTheme {
  static const Color primary = AppColors.primary;

  static ThemeData light = ThemeData(
    useMaterial3: true,

    brightness: Brightness.light,

    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
    ),

    fontFamily: GoogleFonts.cairo().fontFamily,

    scaffoldBackgroundColor:
    AppColors.lightBackground,

cardColor:
    AppColors.lightCard,

dividerColor:
    Colors.grey.shade300,
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: GoogleFonts.cairo(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: primary.withOpacity(.15),
      iconTheme: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(
              color: primary,
            );
          }

          return IconThemeData(
            color: Colors.grey.shade700,
          );
        },
      ),
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),
      );

  static ThemeData dark = ThemeData(
    useMaterial3: true,

    brightness: Brightness.dark,

    colorScheme: const ColorScheme.dark(
      primary: primary,
      secondary: AppColors.secondary,

      surface: Color(0xff1E1E1E),

      onSurface: Colors.white,

      onPrimary: Colors.white,
    ),

    fontFamily: GoogleFonts.cairo().fontFamily,

    scaffoldBackgroundColor:
    AppColors.darkBackground,

cardColor:
    AppColors.darkCard,

    dividerColor: Colors.white12,

    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: const Color(0xff121212),
      foregroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: GoogleFonts.cairo(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: const Color(0xff1B1B1B),

      indicatorColor: primary.withOpacity(.25),

      iconTheme: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(
              color: AppColors.lightCard,
            );
          }

          return const IconThemeData(
            color: Colors.grey,
          );
        },
      ),

      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) {
          return TextStyle(
            color: states.contains(WidgetState.selected)
                ? Colors.white
                : Colors.grey,
          );
        },
      ),
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xff1E1E1E),
      surfaceTintColor: Colors.transparent,
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: const Color(0xff222222),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    cardTheme: CardThemeData(
      color: AppColors.darkCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xff2B2B2B),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.white24,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: primary,
          width: 2,
        ),
      ),

      hintStyle: const TextStyle(
        color: Colors.grey,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,

        minimumSize: const Size(
          double.infinity,
          55,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(
        Colors.white,
      ),

      trackColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return primary;
          }

          return Colors.grey;
        },
      ),
    ),
  );
}