import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_sizes.dart';

class AppTypography {
  static const String fontFamily = 'Poppins';

  static final TextTheme lightTextTheme = TextTheme(
    headlineLarge: TextStyle(
        fontSize: AppSizes.headline1,
        fontWeight: FontWeight.bold,
        color: AppColors.textLight),
    headlineMedium: TextStyle(
        fontSize: AppSizes.headline1,
        fontWeight: FontWeight.w600,
        color: AppColors.textLight),
    headlineSmall: TextStyle(
        fontSize: AppSizes.headline1,
        fontWeight: FontWeight.w600,
        color: AppColors.textLight),
    titleLarge:
        TextStyle(fontSize: AppSizes.headline1, color: AppColors.textLight),
    titleMedium:
        TextStyle(fontSize: AppSizes.headline1, color: AppColors.textLight),
    titleSmall:
        TextStyle(fontSize: AppSizes.headline1, color: AppColors.textLight),
    labelLarge:
        TextStyle(fontSize: AppSizes.headline1, color: AppColors.textLight),
    labelMedium:
        TextStyle(fontSize: AppSizes.headline1, color: AppColors.textLight),
    labelSmall:
        TextStyle(fontSize: AppSizes.headline1, color: AppColors.textLight),
    bodyLarge:
        TextStyle(fontSize: AppSizes.headline1, color: AppColors.textLight),
    bodyMedium:
        TextStyle(fontSize: AppSizes.headline1, color: AppColors.textLight),
    bodySmall:
        TextStyle(fontSize: AppSizes.headline1, color: AppColors.textLight),
  );

  static final TextTheme darkTextTheme = TextTheme(
    headlineLarge: TextStyle(
        fontSize: AppSizes.headline1,
        fontWeight: FontWeight.bold,
        color: AppColors.textDark),
    headlineMedium: TextStyle(
        fontSize: AppSizes.headline1,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark),
    headlineSmall: TextStyle(
        fontSize: AppSizes.headline1,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark),
    titleLarge:
        TextStyle(fontSize: AppSizes.headline1, color: AppColors.textDark),
    titleMedium:
        TextStyle(fontSize: AppSizes.headline1, color: AppColors.textDark),
    titleSmall:
        TextStyle(fontSize: AppSizes.headline1, color: AppColors.textDark),
    labelLarge:
        TextStyle(fontSize: AppSizes.headline1, color: AppColors.textDark),
    labelMedium:
        TextStyle(fontSize: AppSizes.headline1, color: AppColors.textDark),
    labelSmall:
        TextStyle(fontSize: AppSizes.headline1, color: AppColors.textDark),
    bodyLarge:
        TextStyle(fontSize: AppSizes.headline1, color: AppColors.textDark),
    bodyMedium:
        TextStyle(fontSize: AppSizes.headline1, color: AppColors.textDark),
    bodySmall:
        TextStyle(fontSize: AppSizes.headline1, color: AppColors.textDark),
  );
}
