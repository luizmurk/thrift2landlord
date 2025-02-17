part of '../../index.dart';

class RealtorsSkeletonLoader extends StatelessWidget {
  const RealtorsSkeletonLoader({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.realtorImageHeight + (AppSizes.primaryPadding * 2),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // Display 5 skeletons
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(right: AppSizes.primaryPadding),
            padding: EdgeInsets.all(AppSizes.primaryPadding),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(AppSizes.primaryRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Profile Image Skeleton
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: AppSizes.realtorImageWidth,
                    height: AppSizes.realtorImageHeight,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(AppSizes.primaryRadius),
                    ),
                  ),
                ),
                SizedBox(width: AppSizes.primaryGapWidth),

                // Text Skeletons
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name Skeleton
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 100,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    SizedBox(height: AppSizes.secondaryGapHeight),

                    // Rating Row Skeleton
                    Row(
                      children: [
                        Icon(Icons.star,
                            color: Colors.grey[300], size: AppSizes.mediumIcon),
                        SizedBox(width: AppSizes.secondaryGapWidth),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 30,
                            height: 14,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.secondaryGapHeight),

                    // Properties Listed Skeleton
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 80,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
