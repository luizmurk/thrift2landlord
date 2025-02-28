part of '../index.dart';

class PropertyCard extends StatelessWidget {
  final ListingModel listing;

  const PropertyCard({super.key, required this.listing});

  @override
  Widget build(BuildContext context) {
    double completionPercentage =
        (listing.totalPaidAmount / listing.price).clamp(0.0, 1.0);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(12.0.w),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              listing.imageUrls.isNotEmpty ? listing.imageUrls.first : '',
              width: 80.w,
              height: 80.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  listing.title,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(fontFamily: "conthrax", fontSize: 12.sp),
                ),
                SizedBox(height: 4.0),
                Text(
                  "${listing.city}, ${listing.state}, ${listing.country}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.dark),
                ),
                SizedBox(height: 12.0),
                Text(
                  "Land Ownership Tracker",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(height: 4.0),
                LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(10.0),
                  minHeight: 10.0.h,
                  value: completionPercentage,
                  backgroundColor: Colors.grey,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
