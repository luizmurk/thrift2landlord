part of '../index.dart';

class OnboardingSlide extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController());
  final int index;

  OnboardingSlide({required this.index, Key? key}) : super(key: key);

  final List<String> images = [
    'assets/images/onboarding1.png',
    'assets/images/onboarding2.png',
    'assets/images/onboarding3.png',
    'assets/images/onboarding4.png',
  ];
  final List<String> titles = [
    "Find and secure your perfect land",
    "Explore verified listings",
    "Flexible installment payments",
    "Track and manage investments",
  ];
  final List<String> descriptions = [
    "Browse verified land listings by location, sizes, and filters.",
    "Get detailed insights and images before making a decision.",
    "Spread payments up to 10 months with ease.",
    "Monitor your land purchases and documents in one place.",
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 1500),
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, -1), // Start above
            end: Offset(0, 0), // Slide into position
          ).animate(animation),
          child: child,
        );
      },
      child: Column(
        key: ValueKey<int>(
            index), // This ensures animations trigger on index change
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(AppSizes.radiusL),
                  bottomRight: Radius.circular(AppSizes.radiusL),
                ),
                image: DecorationImage(
                  image: AssetImage(images[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Text(
            titles[index],
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSizes.primaryGapHeight),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.primaryPadding),
            child: Text(
              descriptions[index],
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: AppSizes.primaryGapHeight),
          Padding(
            padding: EdgeInsets.all(AppSizes.primaryPadding),
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                    (dotIndex) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: controller.currentIndex.value == dotIndex
                            ? AppColors.primary
                            : AppColors.offWhite,
                      ),
                    ),
                  ),
                )),
          ),
          SizedBox(height: AppSizes.secondaryGapHeight * 0.01),
          Padding(
            padding: EdgeInsets.all(AppSizes.primaryPadding),
            child: CustomPrimaryButton(
              onPressed: controller.nextPage,
              text: "Next",
            ),
          ),
          SizedBox(height: AppSizes.primaryGapHeight),
        ],
      ),
    );
  }
}
