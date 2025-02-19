part of './../index.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reset Password",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Colors.black),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.primaryPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //   Center(
              //     child: Image.asset(
              //       Theme.of(context).brightness == Brightness.dark
              //           ? 'assets/images/logo_dark.jpeg'
              //           : 'assets/images/logo_light.jpeg',
              //       height: AppSizes.logoHeightAuth,
              //     ),
              //   ),
              SizedBox(height: AppSizes.primaryGapHeight),
              Text(
                  "Enter the email associated with your account and we’ll send an email with a link to reset your password.",
                  style: Theme.of(context).textTheme.labelLarge),
              SizedBox(height: AppSizes.primaryGapHeight),
              Text(
                "Email",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.black),
              ),
              CustomTextField(
                controller: emailController,
                hintText: "Enter your email",
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: AppSizes.primaryGapHeight),
              CustomPrimaryButton(
                text: "Send Link",
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
