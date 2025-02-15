import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class CustomAvatar extends StatelessWidget {
  final String imageUrl;
  final double size;
  final VoidCallback? onTap;

  const CustomAvatar({
    Key? key,
    required this.imageUrl,
    this.size = 50.0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: Image.network(
          imageUrl,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => CircleAvatar(
            radius: size / 2,
            backgroundColor: AppColors.offWhite,
            child: Icon(Icons.person, size: size / 2, color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}
