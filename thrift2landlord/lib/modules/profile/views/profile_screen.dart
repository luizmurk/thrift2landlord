part of '../index.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final EditProfileController _controller = Get.put(EditProfileController());
  final ThemeController _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(AppSizes.p16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      CustomAvatar(
                        imageUrl: _controller.currentUser.value?.photoUrl ??
                            'https://via.placeholder.com/150',
                        size: 80,
                        onTap: () {},
                      ),
                      SizedBox(height: AppSizes.primaryGapHeight),
                      FutureBuilder<UserModel>(
                        future: SharedService.getUserFromStorage()
                            .then((user) => user!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SizedBox(height: AppSizes.primaryGapHeight);
                          } else if (snapshot.hasError) {
                            return Text("Error loading user data");
                          } else if (!snapshot.hasData ||
                              snapshot.data == null) {
                            return Text("No user data found");
                          } else {
                            final user = snapshot.data!;
                            return Column(
                              children: [
                                Obx(() {
                                  return Text(
                                    _controller.currentUser.value?.name ?? '',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  );
                                }),
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(
                                        0.5), // Adjust opacity here
                                    borderRadius: BorderRadius.circular(
                                        12), // Add border radius
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      user.email,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSizes.primaryGapHeight * 2),
                SettingsListTile(
                  icon: Icons.edit,
                  title: "Edit Profile",
                  onTap: () {
                    _controller.showEditProfileBottomSheet(
                        context, _controller.currentUser.value!);
                  },
                ),
                Divider(height: AppSizes.primaryGapHeight * 2),
                SettingsListTile(
                  icon: Icons.notifications,
                  title: "Notifications",
                  hasSwitch: true,
                  switchValue: true,
                  onSwitchChanged: (value) {},
                ),
                Divider(height: AppSizes.primaryGapHeight * 2),
                SettingsListTile(
                  icon: Icons.help,
                  title: "Change Password",
                  onTap: () {},
                ),
                Divider(height: AppSizes.primaryGapHeight * 2),
                SettingsListTile(
                  icon: Icons.mail,
                  title: "Feedbacks",
                  onTap: () {},
                ),
                Divider(height: AppSizes.primaryGapHeight * 2),
                SettingsListTile(
                  icon: Icons.help,
                  title: "Terms and Conditions",
                  onTap: () {},
                ),
                // Obx(() {
                //   return SettingsListTile(
                //     icon: Icons.notifications,
                //     title: "Switch Theme",
                //     hasSwitch: true,
                //     switchValue: _themeController.isDarkMode.value,
                //     onSwitchChanged: (value) {
                //       _themeController.toggleTheme();
                //     },
                //   );
                // }),
                Divider(height: AppSizes.primaryGapHeight * 2),
                SettingsListTile(
                  icon: Icons.logout,
                  title: "Logout",
                  onTap: () {},
                ),
              ],
            ),
          ),
        ));
  }
}
