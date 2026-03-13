import 'package:evently_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.main,
      onPrimary: AppColors.inputs,
      secondary: AppColors.mainText,
      onSecondary: AppColors.inputs,
      error: AppColors.red,
      onError: AppColors.inputs,
      surface: AppColors.background,
      onSurface: AppColors.mainText,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.mainText,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.main,
        foregroundColor: AppColors.inputs,
        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        padding: EdgeInsets.all(16),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.main,
        foregroundColor: AppColors.inputs,
        side: BorderSide(width: 1, color: AppColors.main),
        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        padding: EdgeInsets.all(16),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.main,
      foregroundColor: AppColors.background,
      shape: CircleBorder(),
      elevation: 4,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.mainText,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.mainText,
      ),
      titleSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.mainText,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.mainText,
      ),
      labelMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.mainText,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: AppColors.mainText,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.secText,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.secText,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.secText,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.mainDark,
      onPrimary: AppColors.inputsDark,
      secondary: AppColors.mainTextDark,
      onSecondary: AppColors.inputsDark,
      error: AppColors.red,
      onError: AppColors.inputsDark,
      surface: AppColors.backgroundDark,
      onSurface: AppColors.mainTextDark,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundDark,
      foregroundColor: AppColors.mainTextDark,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.mainDark,
        foregroundColor: AppColors.inputsDark,
        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        padding: EdgeInsets.all(16),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.mainDark,
        foregroundColor: AppColors.inputsDark,
        side: BorderSide(width: 1, color: AppColors.mainDark),
        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        padding: EdgeInsets.all(16),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.mainDark,
      foregroundColor: AppColors.backgroundDark,
      shape: CircleBorder(),
      elevation: 4,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.mainTextDark,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.mainTextDark,
      ),
      titleSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.mainTextDark,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.mainTextDark,
      ),
      labelMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.mainTextDark,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: AppColors.mainTextDark,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.secTextDark,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.secTextDark,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.secTextDark,
      ),
    ),
  );
}
