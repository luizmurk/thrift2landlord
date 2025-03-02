part of '../index.dart';

class ChangePasswordController extends GetxController {
  final AuthService _authService = AuthService();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final RxBool isLoading = false.obs;
  var isObscure = true.obs;

  Future<void> changePassword() async {
    isLoading.value = true;
    String oldPassword = oldPasswordController.text.trim();
    String newPassword = newPasswordController.text.trim();

    if (oldPassword.isEmpty || newPassword.isEmpty) {
      Get.snackbar("Error", "All fields are required");
      isLoading.value = false;
      return;
    }

    try {
      await _authService.updatePassword(oldPassword, newPassword);
      Get.snackbar("Success", "Password changed successfully");
      oldPasswordController.clear();
      newPasswordController.clear();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
    isLoading.value = false;
  }
}
