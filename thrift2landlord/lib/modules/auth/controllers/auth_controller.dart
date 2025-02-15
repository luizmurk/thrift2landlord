part of '../index.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  /// 🔹 UI State Management
  var isLoading = false.obs;
  var isObscure = true.obs; // Toggles password visibility
  var isEmailVerificationSent = false.obs;
  var currentUser = Rxn<UserModel>(); // Observable user

  /// 🔹 Input Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();

  /// ✅ **1. Handle Google Sign-In**
  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    User? userCredential = await _authService.signInWithGoogle();
    isLoading.value = false;

    if (userCredential != null) {
      Get.offAllNamed(AppRoutes.listings); // Navigate to Home after login
    }
  }

  Future<void> checkLoggedInUser() async {
    UserModel? storedUser = await _authService.getUserFromStorage();
    if (storedUser != null) {
      currentUser.value = storedUser;
      Get.offAllNamed(AppRoutes.listings); // Navigate to Home Screen
    } else {
      Get.offAllNamed(AppRoutes.signIn);
    }
  }

  /// ✅ **2. Handle Email Sign-In**
  Future<void> signInWithEmail() async {
    if (!_validateInputs()) return;

    isLoading.value = true;
    User? userCredential = await _authService.signIn(
        emailController.text.trim(), passwordController.text);
    isLoading.value = false;

    if (userCredential != null) {
      if (userCredential.emailVerified) {
        Get.offAllNamed(AppRoutes.listings);
      } else {
        CustomSnackbar.show("Please verify your email.", isError: true);
        isLoading.value = false;
      }
    }
  }

  /// ✅ **3. Handle Email Sign-Up**
  Future<void> signUpWithEmail() async {
    if (!_validateInputs()) return;

    isLoading.value = true;
    User? userCredential = await _authService.signUp(
        emailController.text.trim(), passwordController.text);
    isLoading.value = false;

    if (userCredential != null) {
      isEmailVerificationSent.value = true;
      Get.toNamed(AppRoutes.emailVerify);
    }
  }

  void resetPassword(String email) async {
    if (email.isEmpty || !GetUtils.isEmail(email)) {
      CustomSnackbar.show("Enter a valid email.", isError: true);
      return;
    }
    await _authService.resetPassword(email);
  }

  Future<void> checkEmailVerification() async {
    try {
      isLoading.value = true;
      await _authService.reloadUser();
      bool isVerified = _authService.isEmailVerified();

      if (isVerified) {
        CustomSnackbar.show("Email verified successfully!");
        await checkLoggedInUser();
        isLoading.value = false;
        // Navigate to home after verification
      } else {
        CustomSnackbar.show("Please verify your email.", isError: true);
        isLoading.value = false;
      }
    } catch (e) {
      CustomSnackbar.show("Error checking email verification.", isError: true);
      isLoading.value = false;
    }
  }

  /// ✅ **4. Resend Email Verification**
  Future<void> resendVerificationEmail() async {
    isLoading.value = true;
    await _authService.sendEmailVerification();
    isLoading.value = false;
  }

  /// ✅ **5. Toggle Password Visibility**
  void togglePasswordVisibility() {
    isObscure.value = !isObscure.value;
  }

  /// ✅ **6. Validate Input Fields**
  bool _validateInputs() {
    if (emailController.text.isEmpty || !emailController.text.contains("@")) {
      CustomSnackbar.show("Enter a valid email address", isError: true);
      return false;
    }
    if (passwordController.text.length < 6) {
      CustomSnackbar.show("Password must be at least 6 characters",
          isError: true);
      return false;
    }
    return true;
  }

  /// ✅ **7. Handle Sign Out**
  Future<void> signOut() async {
    isLoading.value = true;
    await _authService.signOut();
    isLoading.value = false;
    Get.offAllNamed(AppRoutes.login);
  }
}
