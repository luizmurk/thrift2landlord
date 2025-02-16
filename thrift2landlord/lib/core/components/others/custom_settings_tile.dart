import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';
import '../../themes/app_sizes.dart';
import '../../utils/custom_divider.dart';

class SettingsListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool hasSwitch;
  final bool switchValue;
  final ValueChanged<bool>? onSwitchChanged;

  const SettingsListTile({
    Key? key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.hasSwitch = false,
    this.switchValue = false,
    this.onSwitchChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: AppSizes.primaryPadding),
          leading: Icon(icon, color: AppColors.primary, size: AppSizes.bigIcon),
          title: Text(title, style: Theme.of(context).textTheme.titleLarge),
          subtitle: subtitle != null
              ? Text(subtitle!, style: Theme.of(context).textTheme.bodyMedium)
              : null,
          trailing: hasSwitch
              ? Switch(
                  value: switchValue,
                  onChanged: onSwitchChanged,
                  activeColor: AppColors.primary,
                )
              : const Icon(Icons.chevron_right, color: AppColors.offWhite),
          onTap: hasSwitch ? null : onTap,
        ),
        // CustomDivider(thickness: AppSizes.secondaryDividerThickness),
      ],
    );
  }
}

//HOW TO USE

// SettingsListTile(
//   icon: Icons.account_circle,
//   title: "Account Settings",
//   subtitle: "Manage your account details",
//   onTap: () {
//     // Navigate to account settings
//   },
// ),

// SettingsListTile(
//   icon: Icons.notifications,
//   title: "Notifications",
//   hasSwitch: true,
//   switchValue: true, // Dynamic from user settings
//   onSwitchChanged: (value) {
//     // Handle toggle
//   },
// ),

// SettingsListTile(
//   icon: Icons.lock,
//   title: "Privacy & Security",
//   onTap: () {
//     // Navigate to privacy settings
//   },
// ),
