part of '../index.dart';

class PersonalInfoView extends StatelessWidget {
  final KYCController controller;

  PersonalInfoView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSizes.primaryGapHeight),
          Text(
            'Personal Information',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          SizedBox(height: AppSizes.primaryGapHeight),

          // Full Name
          Text(
            "Full Name",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.black),
          ),
          SizedBox(height: AppSizes.secondaryGapHeight),
          CustomTextField(
            controller: controller.fullNameController,
            hintText: "Enter your full name",
            prefixIcon: Icon(Icons.person),
            validator: (value) =>
                value!.isEmpty ? "Full name is required" : null,
          ),

          SizedBox(height: AppSizes.primaryGapHeight),
          // Date of Birth
          Text(
            "Date of Birth",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.black),
          ),
          SizedBox(height: AppSizes.secondaryGapHeight),
          CustomDatePicker(
            selectedDate: controller.dobController.text.isNotEmpty
                ? DateTime.parse(controller.dobController.text)
                : DateTime.now(),
            onDateSelected: (date) => controller.updateDOB(date),
          ),

          SizedBox(height: AppSizes.primaryGapHeight),
          // Gender
          Text(
            "Gender",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.black),
          ),
          SizedBox(height: AppSizes.secondaryGapHeight),
          Obx(() => CustomDropdown(
                value: controller.gender.value,
                labelText: 'Select Gender',
                items: ['Male', 'Female', 'Other'],
                onChanged: (value) => controller.gender.value = value!,
              )),

          SizedBox(height: AppSizes.primaryGapHeight),
          // Nationality
          Text(
            "Nationality",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.black),
          ),
          SizedBox(height: AppSizes.secondaryGapHeight),
          CustomTextField(
            controller: controller.nationalityController,
            hintText: "Enter your nationality",
          ),

          SizedBox(height: AppSizes.primaryGapHeight),
          // Residential Address
          Text(
            "Residential Address",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.black),
          ),
          SizedBox(height: AppSizes.secondaryGapHeight),
          CustomTextField(
            controller: controller.addressController,
            hintText: "Enter your address",
          ),

          SizedBox(height: AppSizes.primaryGapHeight),
          // State & LGA
          Text(
            "State",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.black),
          ),
          SizedBox(height: AppSizes.secondaryGapHeight),
          CustomTextField(
            controller: controller.stateController,
            hintText: "Enter your state",
          ),

          SizedBox(height: AppSizes.primaryGapHeight),
          Text(
            "Local Government Area (LGA)",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.black),
          ),
          SizedBox(height: AppSizes.secondaryGapHeight),
          CustomTextField(
            controller: controller.lgaController,
            hintText: "Enter your LGA",
          ),

          SizedBox(height: AppSizes.primaryGapHeight),
          // Phone Number
          Text(
            "Phone Number",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.black),
          ),
          SizedBox(height: AppSizes.secondaryGapHeight),
          NumberTextField(
            controller: controller.phoneController,
            hintText: "Enter your phone number",
            validator: (value) =>
                value!.length < 10 ? "Enter a valid phone number" : null,
          ),

          SizedBox(height: AppSizes.primaryGapHeight),
          // Email Address
          Text(
            "Email Address",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.black),
          ),
          SizedBox(height: AppSizes.secondaryGapHeight),
          EmailTextField(
            controller: controller.emailController,
            hintText: "Enter your email",
          ),

          SizedBox(height: AppSizes.primaryGapHeight),
          // Next Button
          SizedBox(
            child: CustomPrimaryButton(
              text: 'Next',
              onPressed: controller.nextStep,
            ),
          ),
        ],
      ),
    );
  }
}
