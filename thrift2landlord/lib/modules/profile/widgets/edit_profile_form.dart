part of '../index.dart';

class EditProfileForm extends StatelessWidget {
  final EditProfileController controller = Get.find<EditProfileController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: controller.pickProfileImage,
            child: Obx(() => CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.primary,
                  backgroundImage: controller.profileImage.value != null
                      ? NetworkImage(controller.profileImage.value!)
                      : null,
                  child: controller.profileImage.value == null
                      ? Icon(Icons.camera_alt, color: AppColors.light)
                      : null,
                )),
          ),
          SizedBox(height: AppSizes.mediumGap),
          CustomTextField(
            controller: controller.nameController,
            hintText: 'Full Name',
          ),
          SizedBox(height: AppSizes.mediumGap),
          EmailTextField(
            controller: controller.emailController,
            hintText: 'Email Address',
          ),
          SizedBox(height: AppSizes.mediumGap),
          NumberTextField(
            controller: controller.phoneController,
            hintText: 'Phone Number',
          ),
          SizedBox(height: AppSizes.primaryGapHeight),
          Obx(() => CustomPrimaryButton(
                text: 'Save Changes',
                isLoading: controller.isLoading.value,
                onPressed: () =>
                    controller.updateProfile(controller.currentUser.value!.id),
              )),
        ],
      ),
    );
  }
}
