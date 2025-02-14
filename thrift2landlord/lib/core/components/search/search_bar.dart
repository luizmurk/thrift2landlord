part of '../index.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;

  const CustomSearchBar({
    Key? key,
    required this.controller,
    this.hintText = "Search...",
    this.onTap,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlignVertical: TextAlignVertical.center,
      controller: controller,
      onTap: onTap,
      onChanged: onChanged,
      style: Theme.of(context).textTheme.bodyLarge, // Uses global typography
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color: AppColors.offWhite),
        prefixIcon: Icon(Icons.search,
            size: AppSizes.bigIcon, color: AppColors.primary),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.primaryRadius),
          borderSide: BorderSide(
              color: AppColors.offWhite,
              width: AppSizes.primaryBorderThickness),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.primaryRadius),
          borderSide: BorderSide(
              color: AppColors.primary, width: AppSizes.primaryBorderThickness),
        ),
      ),
    );
  }
}

// CustomSearchBar(
//   controller: searchController,
//   hintText: "Search properties...",
//   onChanged: (query) {
//     // Handle search logic
//   },
//   onFilterTap: () {
//     // Open bottom sheet filter dialog
//   },
//   showFilterButton: true, // Show filter button
// ),
