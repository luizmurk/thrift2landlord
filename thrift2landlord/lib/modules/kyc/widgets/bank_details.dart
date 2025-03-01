part of '../index.dart';

class BankDetailsView extends StatelessWidget {
  final KYCController controller;
  BankDetailsView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSizes.primaryGapHeight),
        Text('Bank & Financial Details',
            style: Theme.of(context).textTheme.labelMedium),
        SizedBox(height: 16),

        Text(
          "Bank Name",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black),
        ),
        SizedBox(height: AppSizes.secondaryGapHeight),
        CustomTextField(
          hintText: 'Bank Name',
          controller: controller.bankNameController,
        ),
        SizedBox(height: AppSizes.primaryGapHeight),
        Text(
          "Account Number",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black),
        ),
        SizedBox(height: AppSizes.secondaryGapHeight),
        CustomTextField(
          hintText: 'Account Number',
          controller: controller.accountNumberController,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: AppSizes.primaryGapHeight),
        Text(
          "Account Name",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black),
        ),
        SizedBox(height: AppSizes.secondaryGapHeight),
        CustomTextField(
          hintText: 'Account Name',
          controller: controller.accountNameController,
        ),
        SizedBox(height: AppSizes.primaryGapHeight),
        // Preferred Payment Method
        Obx(() => CustomDropdown(
              value: controller.paymentMethod.value,
              labelText: "Preferred Payment Method",
              items: ['Direct Debit', 'Bank Transfer', 'Mobile Money'],
              onChanged: (value) => controller.paymentMethod.value = value!,
            )),

        SizedBox(height: AppSizes.primaryGapHeight),
        SizedBox(height: 20),
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
