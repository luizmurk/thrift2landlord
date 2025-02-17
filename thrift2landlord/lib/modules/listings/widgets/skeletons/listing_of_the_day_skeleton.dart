part of '../../index.dart';

class ListingOfTheDaySkeletonLoader extends StatelessWidget {
  const ListingOfTheDaySkeletonLoader({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.primaryPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.primaryRadius),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Skeleton
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: AppSizes.listingOfTheDayheight, // 180.h
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.primaryRadius),
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: AppSizes.primaryGapHeight),

          // Title Skeleton
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 20.h, // Placeholder for title height
              width: AppSizes.listingOfTheDayWidth, // 80.w
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSizes.primaryRadius),
              ),
            ),
          ),
          SizedBox(height: AppSizes.secondaryGapHeight),

          // Price & Details Row Skeleton
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Price Skeleton
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 20.h, // Placeholder for price height
                  width: 60.w, // Placeholder width for price
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSizes.primaryRadius),
                  ),
                ),
              ),

              // Icons & City, Country Skeleton
              Row(
                children: [
                  Icon(Icons.king_bed,
                      size: 20, color: Colors.grey[300]), // Icon Size: 20
                  SizedBox(width: AppSizes.ratingGapWidth), // 4.w
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 15.h,
                      width: 40.w, // Placeholder width for city
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(AppSizes.primaryRadius),
                      ),
                    ),
                  ),
                  SizedBox(width: AppSizes.primaryGapWidth),
                  Icon(Icons.bathtub,
                      size: 20, color: Colors.grey[300]), // Icon Size: 20
                  SizedBox(width: AppSizes.ratingGapWidth), // 4.w
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 15.h,
                      width: 40.w, // Placeholder width for country
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(AppSizes.primaryRadius),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: AppSizes.secondaryGapHeight),

          // Location Row Skeleton
          Row(
            children: [
              Icon(Icons.location_on,
                  size: 24, color: Colors.grey[300]), // Icon Size: 24
              SizedBox(width: AppSizes.secondaryGapWidth),
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 18.h, // Placeholder for location text
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(AppSizes.primaryRadius),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
