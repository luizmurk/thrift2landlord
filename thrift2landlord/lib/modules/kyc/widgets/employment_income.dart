part of '../index.dart';

class EmploymentView extends StatelessWidget {
  final KYCController controller;
  EmploymentView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSizes.primaryGapHeight),
        Text('Employment & Income Details',
            style: Theme.of(context).textTheme.labelMedium),
        SizedBox(height: 16),
        Text(
          "Employment Status",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black),
        ),
        SizedBox(height: AppSizes.secondaryGapHeight),
        Obx(() => CustomDropdown(
              value: controller.employmentStatus.value,
              labelText: "Employment Status",
              items: ['Employed', 'Self-Employed', 'Student', 'Unemployed'],
              onChanged: (value) => controller.employmentStatus.value = value!,
            )),
        SizedBox(height: AppSizes.primaryGapHeight),
        Text(
          "Employer Name",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black),
        ),
        SizedBox(height: AppSizes.secondaryGapHeight),
        CustomTextField(
          hintText: 'Employer Name',
          controller: controller.employerNameController,
        ),
        SizedBox(height: AppSizes.primaryGapHeight),
        Text(
          "Employer Address",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black),
        ),
        SizedBox(height: AppSizes.secondaryGapHeight),
        CustomTextField(
          hintText: 'Employer Address',
          controller: controller.employerAddressController,
        ),
        SizedBox(height: AppSizes.primaryGapHeight),
        Text(
          "Nature of Business",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black),
        ),
        SizedBox(height: AppSizes.secondaryGapHeight),
        CustomTextField(
          hintText: 'Nature of Business',
          controller: controller.businessNatureController,
        ),
        SizedBox(height: AppSizes.primaryGapHeight),
        Text(
          "Monthly Income",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black),
        ),
        SizedBox(height: AppSizes.secondaryGapHeight),
        Obx(() => CustomDropdown(
              value: controller.incomeRange.value,
              labelText: "Income Range",
              items: ['Below \$1,000', '\$1,000 - \$5,000', 'Above \$5,000'],
              onChanged: (value) => controller.incomeRange.value = value!,
            )),
        SizedBox(height: AppSizes.primaryGapHeight),
        Text(
          "Source of Funds",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black),
        ),
        SizedBox(height: AppSizes.secondaryGapHeight),
        Obx(() => CustomDropdown(
              value: controller.sourceOfFunds.value,
              labelText: "Source of Funds",
              items: ['Salary', 'Business', 'Gifts', 'Investments'],
              onChanged: (value) => controller.sourceOfFunds.value = value!,
            )),
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
