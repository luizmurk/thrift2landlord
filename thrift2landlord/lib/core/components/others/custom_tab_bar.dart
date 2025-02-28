import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> tabs;
  final TabController controller;

  const CustomTabBar({super.key, required this.tabs, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      labelStyle: Theme.of(context).textTheme.bodyLarge,
      unselectedLabelColor: AppColors.offWhite,
      labelColor: AppColors.primary,
      indicatorColor: AppColors.primary,
      tabs: tabs.map((title) => Tab(text: title)).toList(),
    );
  }
}
