part of '../index.dart';

class NextOfKinView extends StatelessWidget {
  final KYCController controller;
  NextOfKinView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSizes.primaryGapHeight),
        Text('Next of Kin Details',
            style: Theme.of(context).textTheme.labelMedium),
        SizedBox(height: 16),
        Text(
          "Full Name",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black),
        ),
        SizedBox(height: AppSizes.secondaryGapHeight),
        CustomTextField(
          hintText: 'Full Name',
          controller: controller.nokFullNameController,
        ),
        SizedBox(height: AppSizes.primaryGapHeight),
        Text(
          "Relationship",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black),
        ),
        SizedBox(height: AppSizes.secondaryGapHeight),
        CustomTextField(
          hintText: 'Relationship',
          controller: controller.nokRelationshipController,
        ),
        SizedBox(height: AppSizes.primaryGapHeight),
        Text(
          "Phone Number",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black),
        ),
        SizedBox(height: AppSizes.secondaryGapHeight),
        NumberTextField(
          hintText: 'Phone Number',
          controller: controller.nokPhoneController,
        ),
        SizedBox(height: AppSizes.primaryGapHeight),
        Text(
          "Address",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black),
        ),
        SizedBox(height: AppSizes.secondaryGapHeight),
        CustomTextField(
          hintText: 'Address',
          controller: controller.nokAddressController,
        ),
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
