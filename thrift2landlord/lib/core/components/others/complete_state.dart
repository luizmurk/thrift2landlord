import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/app_sizes.dart';
import '../index.dart';

class CompletionStatePage extends StatelessWidget {
  const CompletionStatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String title = Get.arguments['title'] ?? '';
    final String body = Get.arguments['body'] ?? '';
    final String buttonText = Get.arguments['buttonText'] ?? '';
    final VoidCallback onPressed = Get.arguments['onPressed'] ?? () {};

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/congrats_image.png',
              width: 150, // Adjust size as needed
              height: 150,
              fit: BoxFit.contain,
            ),
            SizedBox(height: AppSizes.secondaryGapHeight),
            Text(
              title,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSizes.secondaryGapHeight),
            Text(
              body,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSizes.primaryGapHeight),
            CustomPrimaryButton(
              text: buttonText,
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}

// Get.toNamed(AppRoutes.completion arguments: {
//   'title': 'Congratulations!',
//   'body': 'You have successfully completed the process.',
//   'buttonText': 'Go to Dashboard',
//   'onPressed': () {
//     Get.offAllNamed('/dashboard'); // Navigate to the dashboard or any other route
//   },
// });
