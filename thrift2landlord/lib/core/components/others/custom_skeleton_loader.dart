import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class SkeletonLoader extends StatelessWidget {
  final double height;
  final double width;
  final BorderRadius borderRadius;

  const SkeletonLoader({
    Key? key,
    required this.height,
    this.width = double.infinity,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: borderRadius,
      ),
    );
  }
}
