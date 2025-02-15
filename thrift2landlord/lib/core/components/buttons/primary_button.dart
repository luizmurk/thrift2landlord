part of '../index.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isDisabled;
  final bool isLoading;
  final IconData? icon;

  const CustomPrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isDisabled = false,
    this.isLoading = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        elevation: 4.0, // Add elevation for the button
        color: isDisabled ? AppColors.offWhite : AppColors.primary,
        borderRadius: BorderRadius.circular(50.r), // Fully rounded ends
        child: InkWell(
          onTap: isDisabled || isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(50.r), // Fully rounded ends
          splashColor: AppColors.light.withOpacity(0.2), // Subtle tap effect
          child: Container(
            padding:
                EdgeInsets.symmetric(vertical: AppSizes.primaryPadding * 0.8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.r), // Fully rounded ends
              border: Border.all(
                  color: AppColors.offWhite), // Border instead of shadow
            ),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: AppSizes.mediumIcon,
                      height: AppSizes.mediumIcon,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.light),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (icon != null)
                          Icon(icon,
                              color: AppColors.light,
                              size: AppSizes.mediumIcon),
                        if (icon != null)
                          SizedBox(width: AppSizes.primaryGapWidth * 0.5),
                        Text(
                          text,
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: AppColors.light,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
