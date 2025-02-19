part of '../index.dart';

class OnboardingScreen extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (index) => controller.currentIndex.value = index,
        children: List.generate(4, (index) => OnboardingSlide(index: index)),
      ),
    );
  }
}
