part of '../index.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthController _authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Dropdown State
  String? selectedRole;
  final List<String> roles = ["Buyer", "Seller", "Investor"];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _authController.nameController.text = nameController.text.trim();
      _authController.emailController.text = emailController.text.trim();
      _authController.passwordController.text = passwordController.text.trim();
      _authController.phoneNumberController.text = phoneController.text.trim();
      // _authController.selectedRole = selectedRole;

      _authController.signUpWithEmail();
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
                SizedBox(
                  width: double.infinity,
                  height: AppSizes.authImageHeight,
                  child: Image.asset(
                    'assets/images/sign_up.png',
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
                        "Create Account",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: AppColors.primary),
                      ),
                      SizedBox(height: AppSizes.primaryGapHeight),

                      // Email Input
                      Text(
                        "Full Name",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(height: AppSizes.secondaryGapHeight),
                      CustomTextField(
                        controller: nameController,
                        hintText: "Enter your name",
                        prefixIcon: Icon(Icons.person),
                        validator: (value) =>
                            value!.isEmpty ? "Name cannot be empty" : null,
                      ),
                      SizedBox(height: AppSizes.primaryGapHeight),
                      Text(
                        "Phone Number",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(height: AppSizes.secondaryGapHeight),
                      NumberTextField(
                        controller: phoneController,
                        hintText: "Enter your phone number",
                      ),
                      SizedBox(height: AppSizes.primaryGapHeight),

                      Text(
                        "Email",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(height: AppSizes.secondaryGapHeight),
                      // Email Input
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
                      // Password Input
                      PasswordTextField(
                        controller: passwordController,
                        hintText: "Enter your password",
                      ),

                      SizedBox(height: AppSizes.primaryGapHeight),

                      // Phone Number Input

                      // Sign-In Button with Loading State
                      Obx(() => CustomPrimaryButton(
                            text: "Create Account",
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
                                text: "Login",
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
