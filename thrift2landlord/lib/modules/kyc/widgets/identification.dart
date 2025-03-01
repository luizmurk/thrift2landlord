part of '../index.dart';

class IdentificationView extends StatelessWidget {
  final KYCController controller;
  IdentificationView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSizes.primaryGapHeight),
        Text(
          'Identification Documents',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(height: AppSizes.primaryGapHeight),

        Text(
          "Government ID",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black),
        ),
        SizedBox(height: AppSizes.secondaryGapHeight),

        Obx(() => CustomDropdown(
              value: controller.idType.value,
              labelText: "Select ID Type",
              items: ['NIN', 'Passport', 'Driver’s License', 'Voter’s Card'],
              onChanged: (value) => controller.idType.value = value!,
            )),

        SizedBox(height: AppSizes.primaryGapHeight),

        // ID Upload
        Text("Upload Government ID"),
        SizedBox(height: AppSizes.secondaryGapHeight),
        Obx(() => CustomFilePicker(
              onFileSelected: (file) => controller.uploadID(file),
              buttonText:
                  !controller.isLoading.value ? "Upload ID" : "Uploading...",
            )),

        SizedBox(height: AppSizes.primaryGapHeight),
        // BVN
        Text("Bank Verification Number (BVN)"),
        NumberTextField(
          controller: controller.bvnController,
          hintText: "Enter your BVN",
        ),
        SizedBox(height: AppSizes.primaryGapHeight),

        Text(
          "Utility Bill",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black),
        ),
        SizedBox(height: AppSizes.secondaryGapHeight),
        CustomTextField(
          controller: controller.utilityBillController,
          hintText: "Enter utility bill details",
        ),
        SizedBox(height: AppSizes.secondaryGapHeight),

        // Utility Bill Upload
        Text("Upload Utility Bill"),
        SizedBox(height: AppSizes.secondaryGapHeight),
        Obx(() => CustomFilePicker(
              onFileSelected: (file) => controller.uploadUtilityBill(file),
              buttonText: !controller.isLoading.value
                  ? "Upload Utility Bill"
                  : "Uploading...",
            )),
        SizedBox(height: AppSizes.primaryGapHeight),
        // Next Button
        SizedBox(
          child: CustomPrimaryButton(
            text: 'Next',
            onPressed: controller.nextStep,
          ),
        ),
        SizedBox(height: AppSizes.primaryGapHeight),
        SizedBox(
          child: CustomSecondaryButton(
            text: 'previous',
            onPressed: controller.previousStep,
          ),
        ),
      ],
    );
  }
}
