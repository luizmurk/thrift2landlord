part of '../index.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final ChangePasswordController controller =
      Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Change Password")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter your old password",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.black),
            ),
            SizedBox(height: AppSizes.secondaryGapHeight),
            ChangePasswordInput(
              controller: controller.oldPasswordController,
              hintText: "Enter your old password",
            ),
            SizedBox(height: 16.h),
            Text(
              "Enter your old password",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.black),
            ),
            SizedBox(height: AppSizes.secondaryGapHeight),
            ChangePasswordInput(
              controller: controller.newPasswordController,
              hintText: "Enter your new password",
            ),
            SizedBox(height: 24),
            Obx(() => SizedBox(
                  child: CustomPrimaryButton(
                    onPressed: controller.changePassword,
                    text: "Change Password",
                    isLoading: controller.isLoading.value,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
