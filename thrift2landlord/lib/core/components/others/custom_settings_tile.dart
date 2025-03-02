import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../themes/app_colors.dart';
import '../../themes/app_sizes.dart';
import '../../utils/custom_divider.dart';

class SettingsListTile extends StatelessWidget {
  final String iconPath; // Updated to use an SVG asset path
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool hasSwitch;
  final bool switchValue;
  final ValueChanged<bool>? onSwitchChanged;

  const SettingsListTile({
    super.key,
    required this.iconPath, // Expecting an SVG file path
    required this.title,
    this.subtitle,
    this.onTap,
    this.hasSwitch = false,
    this.switchValue = false,
    this.onSwitchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: AppSizes.primaryPadding),
          leading: SvgPicture.asset(
            iconPath,
            height: AppSizes.bigIcon, // Use a standard size
            width: AppSizes.bigIcon,
            color: AppColors.primary,
          ),
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
