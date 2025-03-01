part of '../index.dart';

class KYCForm extends StatelessWidget {
  final KYCController controller = Get.put(KYCController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "KYC Form",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: AppSizes.primaryPadding,
              horizontal: AppSizes.primaryPadding),
          child: Column(
            children: [
              Obx(() => LinearProgressIndicator(
                    value: (controller.currentStep.value + 1) / 6,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  )),
              SizedBox(
                child: Obx(
                  () => IndexedStack(
                    index: controller.currentStep.value,
                    children: [
                      PersonalInfoView(controller: controller),
                      IdentificationView(controller: controller),
                      EmploymentView(controller: controller),
                      BankDetailsView(controller: controller),
                      NextOfKinView(controller: controller),
                      SecurityView(controller: controller),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
