part of '../index.dart';

class CustomDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final Function(String) onChanged;
  final String labelText;

  const CustomDropdown({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.labelText,
  }) : super(key: key);

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppSizes.primaryRadius)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(AppSizes.primaryPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: items.map((item) {
              return ListTile(
                title: Text(item, style: Theme.of(context).textTheme.bodyLarge),
                onTap: () {
                  onChanged(item);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showBottomSheet(context),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: AppSizes.primaryPadding * 0.7,
          horizontal: AppSizes.primaryPadding,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.offWhite),
          borderRadius: BorderRadius.circular(AppSizes.primaryRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value ?? labelText,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: value == null ? AppColors.offWhite : AppColors.dark,
                  ),
            ),
            Icon(Icons.arrow_drop_down, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
