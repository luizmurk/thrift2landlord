part of '../index.dart';

class EmailVerificationScreen extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());

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
                    "Verify Your Email",
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppSizes.primaryGapHeight),
                  Text(
                    "A verification link has been sent to your email. Please check your inbox.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: AppSizes.primaryGapHeight),
                  CustomSecondaryButton(
                    text: "Resend Email",
                    onPressed: _authController.resendVerificationEmail,
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
