import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_colors.dart';

class CustomDivider extends StatelessWidget {
  final double thickness;
  final double horizontalPadding;
  final double verticalSpacing;
  final Color? color;

  const CustomDivider({
    Key? key,
    this.thickness = 1.0, // Default thin divider
    this.horizontalPadding = 16.0, // Default horizontal padding
    this.verticalSpacing = 8.0, // Default spacing above & below
    this.color, // Defaults to AppColors.offWhite
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding.w,
        vertical: verticalSpacing.h,
      ),
      child: Divider(
        thickness: thickness.h,
        color: color ?? AppColors.offWhite,
      ),
    );
  }
}

// HOW TO USE:
// CustomDivider()
// CustomDivider(
//   thickness: 2.0,
//   verticalSpacing: 12.0,
// ),

// CustomDivider(
//   color: AppColors.primary, // Primary-colored divider
// ),
