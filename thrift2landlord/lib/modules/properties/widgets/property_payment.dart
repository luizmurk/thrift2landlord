part of '../index.dart';

class PropertyPaymentCard extends StatelessWidget {
  final ListingModel listing;

  const PropertyPaymentCard({super.key, required this.listing});

  @override
  Widget build(BuildContext context) {
    double completionPercentage =
        (listing.totalPaidAmount / listing.price).clamp(0.0, 1.0);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 8.0.w),
      padding: EdgeInsets.all(12.0.w),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(width: 12.0.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listing.title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontFamily: "conthrax", fontSize: 12.sp),
                  ),
                  SizedBox(height: 4.0.h),
                  Text(
                    "${listing.city}, ${listing.state}, ${listing.country}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.dark),
                  ),
                  SizedBox(height: 12.0.h),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.0.h),
          Container(
            width: 320.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₦${(listing.totalPaidAmount / 1000000).toStringAsFixed(2)}M',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.primary,
                      ),
                ),
                Text(
                  '₦${(listing.price / 1000000).toStringAsFixed(2)}M',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.primary,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.0),
          SizedBox(
            width: 320.w, // Ensures it takes the full available width
            child: LinearProgressIndicator(
              borderRadius: BorderRadius.circular(10.0),
              minHeight: 10.0.h,
              value: completionPercentage,
              backgroundColor: Colors.grey,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
