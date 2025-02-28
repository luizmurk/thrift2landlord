part of '../index.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color textColor;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
