part of '../index.dart';

class ChangePasswordInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  const ChangePasswordInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final ChangePasswordController authController =
        Get.find<ChangePasswordController>();

    return Obx(() => CustomTextField(
          controller: controller,
          hintText: hintText,
          obscureText: authController.isObscure.value,
          suffixIcon: IconButton(
            icon: Icon(
              authController.isObscure.value
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: AppColors.primary,
            ),
            onPressed: () {
              authController.isObscure.value = !authController.isObscure.value;
            },
          ),
          validator: validator,
        ));
  }
}
