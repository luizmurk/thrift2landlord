part of '../index.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final int? maxLength;
  final bool? isPrefixed;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.isPrefixed = false,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      maxLength: maxLength,
      onTap: onTap,
      onChanged: onChanged,
      validator: validator,
      style: Theme.of(context).textTheme.labelMedium,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        prefixIcon: isPrefixed == true ? prefixIcon : null,
        prefixIconColor: AppColors.primary,
        suffixIcon: suffixIcon,
        counterText: "",
        filled: true,
        fillColor: isDarkMode ? AppColors.dark : AppColors.light,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.primaryRadius),
          borderSide: BorderSide(color: AppColors.offWhite),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.primaryRadius),
          borderSide: BorderSide(color: AppColors.offWhite),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.primaryRadius),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }
}
