part of '../index.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final EditProfileController _controller = Get.put(EditProfileController());
  final ThemeController _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile", style: Theme.of(context).textTheme.titleLarge),
          centerTitle: true,
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
                        imageUrl: 'https://via.placeholder.com/150',
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
                                Text(user.email),
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
                SettingsListTile(
                  icon: Icons.lock,
                  title: "Security",
                  onTap: () {},
                ),
                SettingsListTile(
                  icon: Icons.privacy_tip,
                  title: "Privacy",
                  onTap: () {},
                ),
                SettingsListTile(
                  icon: Icons.help,
                  title: "Help & Support",
                  onTap: () {},
                ),
                SettingsListTile(
                  icon: Icons.notifications,
                  title: "Notifications",
                  hasSwitch: true,
                  switchValue: true,
                  onSwitchChanged: (value) {},
                ),
                Obx(() {
                  return SettingsListTile(
                    icon: Icons.notifications,
                    title: "Switch Theme",
                    hasSwitch: true,
                    switchValue: _themeController.isDarkMode.value,
                    onSwitchChanged: (value) {
                      _themeController.toggleTheme();
                    },
                  );
                }),
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
