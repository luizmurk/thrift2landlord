part of '../index.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final bool? isPrefixed;

  const EmailTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPrefixed = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hintText: hintText,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: isPrefixed == true
          ? Icon(Icons.email, color: AppColors.primary)
          : null,
      validator: validator,
    );
  }
}
