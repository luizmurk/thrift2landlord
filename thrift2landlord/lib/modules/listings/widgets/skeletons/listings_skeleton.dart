part of '../../index.dart';

class ListingsSkeletonLoader extends StatelessWidget {
  const ListingsSkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(), // Avoids unwanted scrolling
      shrinkWrap: true, // Makes it adapt to parent constraints
      itemCount: 5, // Show 5 skeletons while loading
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(AppSizes.primaryPadding),
          margin: EdgeInsets.only(bottom: AppSizes.primaryGapHeight),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.primaryRadius),
            color: Theme.of(context).cardColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Scrollable Image List Skeleton
              SizedBox(
                height: AppSizes.listingCardImageHeight, // 80.w
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3, // Placeholder count
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        margin: EdgeInsets.only(right: 8.w),
                        width: AppSizes.listingCardImageWidth, // 150.w
                        height: AppSizes.listingCardImageHeight, // 80.w
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppSizes.primaryRadius),
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: AppSizes.primaryGapHeight),

              // Property Title Skeleton
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 20.h,
                  width: 120.w, // Placeholder width
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSizes.primaryRadius),
                  ),
                ),
              ),
              SizedBox(height: 4.h),

              // Rating Row Skeleton
              Row(
                children: [
                  // Rating Number Skeleton
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 16.h,
                      width: 24.w, // Placeholder width
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(AppSizes.primaryRadius),
                      ),
                    ),
                  ),
                  SizedBox(width: AppSizes.ratingGapWidth), // 4.w

                  // Star Rating Skeleton
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(Icons.star,
                          size: 16.sp, color: Colors.grey[300]!),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),

              // Category Skeleton
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 18.h,
                  width: 80.w, // Placeholder width
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSizes.primaryRadius),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
