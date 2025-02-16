part of '../index.dart';

class SignUpScreen extends StatefulWidget {
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
          padding: EdgeInsets.all(AppSizes.primaryPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo
                Center(
                  child: Image.asset(
                    Theme.of(context).brightness == Brightness.dark
                        ? 'assets/images/logo_dark.jpeg'
                        : 'assets/images/logo_light.jpeg',
                    height: AppSizes.logoHeightAuth,
                  ),
                ),
                SizedBox(height: AppSizes.primaryGapHeight),

                // Name Input
                CustomTextField(
                  controller: nameController,
                  hintText: "Enter your name",
                  prefixIcon: Icon(Icons.person),
                  validator: (value) =>
                      value!.isEmpty ? "Name cannot be empty" : null,
                ),
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

                // Phone Number Input
                NumberTextField(
                  controller: phoneController,
                  hintText: "Enter your phone number",
                ),
                SizedBox(height: AppSizes.primaryGapHeight),

                // // Role Dropdown
                // CustomDropdown(
                //   value: selectedRole,
                //   items: roles,
                //   onChanged: (value) {
                //     setState(() {
                //       selectedRole = value;
                //     });
                //   },
                //   labelText: "Select Role",
                // ),
                // SizedBox(height: AppSizes.primaryGapHeight),

                // Submit Button with Loading State
                Obx(() => CustomPrimaryButton(
                      text: "Sign Up",
                      onPressed: _submitForm,
                      isLoading: _authController.isLoading.value,
                    )),
                SizedBox(height: AppSizes.primaryGapHeight),

                // Sign In Redirect
                CustomSecondaryButton(
                  text: "Already have an account? Sign in",
                  onPressed: () {
                    Get.toNamed(AppRoutes.signIn);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
