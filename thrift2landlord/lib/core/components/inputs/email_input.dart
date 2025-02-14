part of '../index.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  const EmailTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hintText: hintText,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Icon(Icons.email, color: AppColors.primary),
      validator: validator,
    );
  }
}
