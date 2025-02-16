import 'package:flutter/material.dart';
import 'package:thrift2landlord/core/themes/app_sizes.dart';

import '../../themes/app_colors.dart';

class CustomAvatar extends StatelessWidget {
  final String? imageUrl;
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
      child: Container(
        padding:
            EdgeInsets.all(AppSizes.primaryBorderThickness), // Border padding
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.primary,
            width: AppSizes.primaryBorderThickness,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size / 2),
          child: imageUrl != null
              ? Image.network(
                  imageUrl!,
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => CircleAvatar(
                    radius: size / 2,
                    backgroundColor: AppColors.offWhite,
                    child: Icon(Icons.person,
                        size: size / 2, color: AppColors.primary),
                  ),
                )
              : Image.asset(
                  'assets/images/default_avatar.png',
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}

// class AvatarPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Avatar Page'),
//       ),
//       body: Center(
//         child: CustomAvatar(
//           imageUrl: 'https://example.com/avatar.jpg',
//           size: 100.0,
//           onTap: () {
//             print('Avatar tapped!');
//           },
//         ),
//       ),
//     );
//   }
// }
