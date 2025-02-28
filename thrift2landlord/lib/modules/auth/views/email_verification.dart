part of '../index.dart';

class EmailVerificationScreen extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());

  EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.primaryPadding),
          child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Confirm Your Email",
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppSizes.primaryGapHeight),
                  Text(
                    "We sent a confirmation email to",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.black),
                  ),
                  SizedBox(height: AppSizes.primaryGapHeight),
                  Text(
                    _authController.emailController.text,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppSizes.primaryGapHeight),
                  Text(
                    "Please check your email and click on the confirmation link and come back to this app to continue.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.black),
                  ),
                  SizedBox(height: AppSizes.primaryGapHeight),
                  CustomPrimaryButton(
                    text: "Continue",
                    onPressed: _authController.checkEmailVerification,
                    isLoading: _authController.isLoading.value,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
