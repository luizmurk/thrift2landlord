import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_sizes.dart';

class AppTypography {
  static const String fontFamily = 'Poppins';

  static final TextTheme lightTextTheme = TextTheme(
    headlineLarge: TextStyle(
        fontSize: AppSizes.headlineLarge,
        fontWeight: FontWeight.bold,
        color: AppColors.dark),
    headlineMedium: TextStyle(
        fontSize: AppSizes.headlineMedium,
        fontWeight: FontWeight.w600,
        color: AppColors.dark),
    headlineSmall: TextStyle(
        fontSize: AppSizes.headlineSmall,
        fontWeight: FontWeight.w600,
        color: AppColors.dark),
    titleLarge: TextStyle(
        fontSize: AppSizes.titleLarge,
        fontWeight: FontWeight.bold,
        color: AppColors.dark),
    titleMedium: TextStyle(
        fontSize: AppSizes.titleMedium,
        fontWeight: FontWeight.w600,
        color: AppColors.dark),
    titleSmall: TextStyle(
        fontSize: AppSizes.titleSmall,
        fontWeight: FontWeight.w600,
        color: AppColors.dark),
    labelLarge: TextStyle(fontSize: AppSizes.labelLarge, color: AppColors.dark),
    labelMedium:
        TextStyle(fontSize: AppSizes.labelMedium, color: AppColors.dark),
    labelSmall: TextStyle(fontSize: AppSizes.labelSmall, color: AppColors.dark),
    bodyLarge:
        TextStyle(fontSize: AppSizes.bodyLarge, color: AppColors.offWhite),
    bodyMedium:
        TextStyle(fontSize: AppSizes.bodyMedium, color: AppColors.offWhite),
    bodySmall:
        TextStyle(fontSize: AppSizes.bodySmall, color: AppColors.offWhite),
  );

  static final TextTheme darkTextTheme = TextTheme(
    headlineLarge: TextStyle(
        fontSize: AppSizes.headlineLarge,
        fontWeight: FontWeight.bold,
        color: AppColors.light),
    headlineMedium: TextStyle(
        fontSize: AppSizes.headlineMedium,
        fontWeight: FontWeight.w500,
        color: AppColors.light),
    headlineSmall: TextStyle(
        fontSize: AppSizes.headlineSmall,
        fontWeight: FontWeight.w200,
        color: AppColors.light),
    titleLarge: TextStyle(
        fontSize: AppSizes.titleLarge,
        color: AppColors.light,
        fontWeight: FontWeight.bold),
    titleMedium: TextStyle(
        fontSize: AppSizes.titleMedium,
        color: AppColors.light,
        fontWeight: FontWeight.w600),
    titleSmall: TextStyle(
        fontSize: AppSizes.titleSmall,
        color: AppColors.light,
        fontWeight: FontWeight.w200),
    labelLarge: TextStyle(
        fontSize: AppSizes.labelLarge,
        color: AppColors.light,
        fontWeight: FontWeight.bold),
    labelMedium: TextStyle(
        fontSize: AppSizes.labelMedium,
        color: AppColors.light,
        fontWeight: FontWeight.bold),
    labelSmall: TextStyle(
        fontSize: AppSizes.labelSmall,
        color: AppColors.light,
        fontWeight: FontWeight.bold),
    bodyLarge:
        TextStyle(fontSize: AppSizes.bodyLarge, color: AppColors.offWhite),
    bodyMedium:
        TextStyle(fontSize: AppSizes.bodyMedium, color: AppColors.offWhite),
    bodySmall:
        TextStyle(fontSize: AppSizes.bodySmall, color: AppColors.offWhite),
  );
}

/// how to use
/// Text("Hello, World!", style: Theme.of(context).textTheme.headline1),
