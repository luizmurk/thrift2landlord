part of '../index.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color? color;
  final double? size;
  final bool isOutlined; // Determines if it's outlined or filled

  const CustomIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.color,
    this.size,
    this.isOutlined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isOutlined
          ? Colors.transparent
          : AppColors.primary, // Transparent for outlined button
      borderRadius: BorderRadius.circular(AppSizes.primaryRadius),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppSizes.primaryRadius),
        splashColor: AppColors.light.withOpacity(0.2),
        child: Container(
          padding: EdgeInsets.all(AppSizes.primaryPadding * 0.6),
          decoration: BoxDecoration(
            color: isOutlined ? Colors.transparent : AppColors.primary,
            borderRadius: BorderRadius.circular(AppSizes.primaryRadius),
            border:
                Border.all(color: AppColors.offWhite), // Always has a border
          ),
          child: Icon(
            icon,
            color: color ?? (isOutlined ? AppColors.primary : AppColors.light),
            size: size ?? AppSizes.mediumIcon,
          ),
        ),
      ),
    );
  }
}

// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     CustomIconButton(
//       icon: Icons.favorite,
//       onPressed: () {
//         print("Favorite clicked");
//       },
//       isOutlined: false, // Filled button
//     ),
//     SizedBox(width: AppSizes.primaryGapWidth),
//     CustomIconButton(
//       icon: Icons.share,
//       onPressed: () {
//         print("Share clicked");
//       },
//       isOutlined: true, // Outlined button
//     ),
//   ],
// )
