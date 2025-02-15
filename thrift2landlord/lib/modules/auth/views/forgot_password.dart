part of './../index.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.primaryPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  Theme.of(context).brightness == Brightness.dark
                      ? 'assets/images/logo_dark.jpeg'
                      : 'assets/images/logo_light.jpeg',
                  height: AppSizes.logoHeightAuth,
                ),
              ),
              SizedBox(height: AppSizes.primaryGapHeight),
              Text("Enter your email to reset password",
                  style: Theme.of(context).textTheme.labelLarge),
              SizedBox(height: AppSizes.primaryGapHeight),
              CustomTextField(
                controller: emailController,
                hintText: "Enter your email",
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: AppSizes.primaryGapHeight),
              CustomPrimaryButton(
                text: "Send Reset Email",
                onPressed: () {
                  _authController.resetPassword(emailController.text.trim());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
