part of '../index.dart';

class ListingsCard extends StatelessWidget {
  final ListingModel listing;

  const ListingsCard({
    required this.listing,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: AppSizes.listingCardImageWidth,
            height: AppSizes.listingCardImageHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: NetworkImage(listing.imageUrls.first),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: AppSizes.primaryGapHeight),
          Text(
            listing.title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: AppSizes.secondaryGapHeight),
          Row(
            children: [
              Icon(Icons.star, color: AppColors.primary, size: 16),
              SizedBox(width: AppSizes.ratingGapWidth),
              Text('${listing.rating}',
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          SizedBox(height: AppSizes.secondaryGapHeight),
          Text(
            listing.address,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
