part of '../../index.dart';

class CategoriesSkeletonLoader extends StatelessWidget {
  const CategoriesSkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes
          .categoryCardHeight, // Adjust based on your category card height
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // Show 5 loading placeholders
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 120, // Adjust based on your card width
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
