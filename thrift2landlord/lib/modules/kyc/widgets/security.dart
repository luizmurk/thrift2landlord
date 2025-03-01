part of '../index.dart';

class SecurityView extends StatelessWidget {
  final KYCController controller;
  SecurityView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSizes.primaryGapHeight),
        Text('Security & Compliance',
            style: Theme.of(context).textTheme.labelMedium),
        SizedBox(height: 16),

        // Selfie Upload
        Obx(() => CustomFilePicker(
              onFileSelected: (file) => controller.uploadSelfie(file),
              buttonText: !controller.isLoading.value
                  ? "Upload Selfie"
                  : "Uploading...",
            )),
        SizedBox(height: AppSizes.primaryGapHeight),
        // Signature Upload
        Obx(() => CustomFilePicker(
              onFileSelected: (file) => controller.uploadSignature(file),
              buttonText: !controller.isLoading.value
                  ? "Upload Signature"
                  : "Uploading...",
            )),

        SizedBox(height: AppSizes.primaryGapHeight),
        // Consent to Terms & Conditions
        Obx(() => CheckboxListTile(
              title: Text("I accept the Terms & Conditions"),
              value: controller.isTermsAccepted.value,
              onChanged: (value) => controller.isTermsAccepted.value = value!,
            )),

        // Consent for Data Sharing
        Obx(() => CheckboxListTile(
              title: Text(
                  "I consent to data sharing for verification & regulatory purposes"),
              value: controller.isDataSharingAccepted.value,
              onChanged: (value) =>
                  controller.isDataSharingAccepted.value = value!,
            )),

        SizedBox(height: 20),
        SizedBox(
          child: CustomSecondaryButton(
            text: 'previous',
            onPressed: controller.previousStep,
          ),
        ),
        SizedBox(height: AppSizes.primaryGapHeight),
        Obx(() => SizedBox(
              child: CustomPrimaryButton(
                onPressed: controller.submitKYC,
                text: 'Submit KYC',
                isLoading: controller.isLoading.value,
              ),
            )),
      ],
    );
  }
}
