import 'package:flutter/material.dart';
import 'package:thrift2landlord/core/themes/app_sizes.dart';

import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  // Define Light Theme
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Karla',
    brightness: Brightness.light,
    primaryColor: AppColors.light,
    scaffoldBackgroundColor: AppColors.light,
    textTheme: AppTypography.lightTextTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.light,
      elevation: 0,
      titleTextStyle: TextStyle(
          color: AppColors.dark,
          fontSize: AppSizes.headlineMedium,
          fontWeight: FontWeight.bold),
    ),
  );

  // Define Dark Theme
  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'Karla',
    brightness: Brightness.dark,
    primaryColor: AppColors.dark,
    scaffoldBackgroundColor: AppColors.dark,
    textTheme: AppTypography.darkTextTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.dark,
      elevation: 0,
      titleTextStyle: TextStyle(
          color: AppColors.light,
          fontSize: AppSizes.headlineMedium,
          fontWeight: FontWeight.bold),
    ),
  );
}
