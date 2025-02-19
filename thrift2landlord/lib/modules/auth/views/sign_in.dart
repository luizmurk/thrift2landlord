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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: AppSizes.authImageHeight,
                  child: Image.asset(
                    'assets/images/sign_in.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: AppSizes.primaryGapHeight),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppSizes.primaryPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Landlord Login",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: AppColors.primary),
                      ),
                      SizedBox(height: AppSizes.primaryGapHeight),

                      // Email Input
                      Text(
                        "Email",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(height: AppSizes.secondaryGapHeight),
                      EmailTextField(
                        controller: emailController,
                        hintText: "Enter your email",
                      ),
                      SizedBox(height: AppSizes.primaryGapHeight),

                      Text(
                        "Password",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(height: AppSizes.secondaryGapHeight),
                      PasswordTextField(
                        controller: passwordController,
                        hintText: "Enter your password",
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () =>
                              Get.toNamed(AppRoutes.forgotPassword),
                          child: Text("Forgot Password?",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.red)),
                        ),
                      ),

                      SizedBox(height: AppSizes.primaryGapHeight),

                      // Sign-In Button with Loading State
                      Obx(() => CustomPrimaryButton(
                            text: "Login",
                            onPressed: _submitForm,
                            isLoading: _authController.isLoading.value,
                          )),
                      SizedBox(height: AppSizes.primaryGapHeight),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              height: 1.5,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "or sign in with",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.grey),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSizes.primaryGapHeight),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(AppSizes.secondaryPadding),
                            child: Container(
                              width: 50.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: AppColors.light,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.all(AppSizes.primaryPadding),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/facebook.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20.w),
                          GestureDetector(
                            onTap: () => _authController.signInWithGoogle(),
                            child: Padding(
                              padding:
                                  EdgeInsets.all(AppSizes.secondaryPadding),
                              child: Container(
                                width: 50.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  color: AppColors.light,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.all(AppSizes.primaryPadding),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/google.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Padding(
                            padding: EdgeInsets.all(AppSizes.secondaryPadding),
                            child: Container(
                              width: 50.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: AppColors.light,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.all(AppSizes.primaryPadding),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/apple.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: AppSizes.primaryGapHeight),

                      // Sign Up Button
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "I don’t have an account: ",
                            style: Theme.of(context).textTheme.bodySmall,
                            children: [
                              TextSpan(
                                text: "Create one",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed(AppRoutes.signUp);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: AppSizes.primaryGapHeight),
                    ],
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
