part of '../index.dart';

class CustomSecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isDisabled;
  final IconData? icon;

  const CustomSecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isDisabled = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding:
              EdgeInsets.symmetric(vertical: AppSizes.primaryPadding * 0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.r), // Fully rounded ends
          ),
          side: BorderSide(
              color: isDisabled ? AppColors.offWhite : AppColors.primary),
        ),
        onPressed: isDisabled ? null : onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(icon, color: AppColors.primary, size: AppSizes.mediumIcon),
            if (icon != null) SizedBox(width: AppSizes.primaryGapWidth * 0.5),
            Text(
              text,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
