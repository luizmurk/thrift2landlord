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
      builder: (context) =>
          CustomBottomSheet(title: title, child: child, height: height),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: height ??
          MediaQuery.of(context).size.height *
              0.4, // Default to 40% screen height
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 10),
          Expanded(child: child),
        ],
      ),
    );
  }
}

// HOW TO USE
// CustomBottomSheet.show(
//   context: context,
//   title: 'Bottom Sheet Title',
//   child: Column(
//     children: [
//       Text('This is a reusable bottom sheet.', style: Theme.of(context).textTheme.bodyText1),
//       const SizedBox(height: 20),
//       ElevatedButton(
//         onPressed: () => Navigator.pop(context),
//         child: const Text('Close'),
//       ),
//     ],
//   ),
// );
