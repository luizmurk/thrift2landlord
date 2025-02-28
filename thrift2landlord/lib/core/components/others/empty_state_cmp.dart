part of '../index.dart';

class EmptyCMPState extends StatelessWidget {
  final String title;
  final String body;
  final String buttonText;
  final VoidCallback? onButtonPressed;

  const EmptyCMPState({
    super.key,
    required this.title,
    required this.body,
    required this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.primaryPadding),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              body,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            onButtonPressed != null
                ? CustomPrimaryButton(
                    text: buttonText, onPressed: onButtonPressed ?? () {})
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
