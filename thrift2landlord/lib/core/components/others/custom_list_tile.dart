part of '../index.dart';

class PropertyListTile extends StatelessWidget {
  final List<String> imageUrls;
  final String title;
  final double rating;
  final String category;

  const PropertyListTile({
    Key? key,
    required this.imageUrls,
    required this.title,
    required this.rating,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.primaryPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Scrollable Image List
          SizedBox(
            height: 100.h, // Fixed square height
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: 8.w),
                  width: 100.w, // Square width
                  height: 100.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.primaryRadius),
                    image: DecorationImage(
                      image: Image.asset(imageUrls[index]).image,

                      // image: NetworkImage(imageUrls[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: AppSizes.primaryGapHeight),

          // Property Title
          Text(title, style: Theme.of(context).textTheme.labelLarge),

          SizedBox(height: 4.h),

          // Rating Row
          Row(
            children: [
              Text(
                rating.toStringAsFixed(1),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(width: 4.w),
              ...List.generate(5, (index) {
                return Icon(
                  index < rating.round()
                      ? Icons.star
                      : Icons.star_border, // Filled or empty star
                  size: 16.sp,
                  color: AppColors.primary,
                );
              }),
            ],
          ),

          SizedBox(height: 4.h),

          // Category
          Text(
            category,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}

// HOW TO USE
// ListView.builder(
//   itemCount: properties.length,
//   padding: EdgeInsets.symmetric(vertical: 8.h),
//   itemBuilder: (context, index) {
//     final property = properties[index];

//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8.h),
//       child: PropertyListTile(
//         imageUrls: property.imageUrls, // List of image URLs
//         title: property.title, // Property title
//         rating: property.rating, // Double rating (e.g., 4.3)
//         category: property.category, // e.g., "Affordable"
//       ),
//     );
//   },
// );
