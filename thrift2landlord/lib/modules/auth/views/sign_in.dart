part of '../index.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthController _authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Submit Sign-In Form
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _authController.emailController.text = emailController.text.trim();
      _authController.passwordController.text = passwordController.text.trim();
      _authController.signInWithEmail();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSizes.primaryPadding),
          child: Form(
            key: _formKey,
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

                // Google Sign-In Button
                CustomPrimaryButton(
                  text: "Sign in with Google",
                  icon: Icons.login,
                  onPressed: () => _authController.signInWithGoogle(),
                ),
                SizedBox(height: AppSizes.primaryGapHeight),

                const CustomDivider(),
                SizedBox(height: AppSizes.primaryGapHeight),

                // Email Input
                EmailTextField(
                  controller: emailController,
                  hintText: "Enter your email",
                ),
                SizedBox(height: AppSizes.primaryGapHeight),

                // Password Input
                PasswordTextField(
                  controller: passwordController,
                  hintText: "Enter your password",
                ),

                SizedBox(height: AppSizes.primaryGapHeight),

                // Sign-In Button with Loading State
                Obx(() => CustomPrimaryButton(
                      text: "Sign In",
                      onPressed: _submitForm,
                      isLoading: _authController.isLoading.value,
                    )),
                SizedBox(height: AppSizes.primaryGapHeight),

                // Sign Up Button
                CustomSecondaryButton(
                  text: "Don't have an account? Sign up",
                  onPressed: () {
                    Get.toNamed(AppRoutes.signUp);
                  },
                ),

                // Forgot Password
                Center(
                  child: GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                    child: Text(
                      "Forgot Password?",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
