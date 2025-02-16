part of '../index.dart';

class CustomBottomSheet extends StatelessWidget {
  final String title;
  final Widget child;
  final double? height;

  const CustomBottomSheet({
    Key? key,
    required this.title,
    required this.child,
    this.height,
  }) : super(key: key);

  static void show({
    required BuildContext context,
    required String title,
    required Widget child,
    double? height,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      shape: Theme.of(context).bottomSheetTheme.shape,
      isScrollControlled: true,
      enableDrag: true, // Allows the bottom sheet to be draggable
      builder: (context) =>
          CustomBottomSheet(title: title, child: child, height: height),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false, // Allows free vertical dragging
      initialChildSize: 0.8, // Default height as 40% of screen
      minChildSize: 0.2, // Minimum height
      maxChildSize: 0.9, // Maximum height before fully expanded
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).bottomSheetTheme.backgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: child,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
