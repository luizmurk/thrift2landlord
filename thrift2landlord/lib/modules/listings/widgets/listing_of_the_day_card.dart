part of '../index.dart';

class ListingOfTheDayCard extends StatelessWidget {
  final ListingModel listing;

  const ListingOfTheDayCard({super.key, required this.listing});

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
          Container(
            // width: AppSizes.realtorImageWidth,
            height: AppSizes.listingOfTheDayheight,
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
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: AppSizes.secondaryGapHeight),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${listing.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Row(
                children: [
                  Icon(Icons.king_bed, size: 20, color: AppColors.primary),
                  SizedBox(width: 4),
                  Text(listing.city,
                      style: Theme.of(context).textTheme.bodyMedium),
                  SizedBox(width: 8),
                  Icon(Icons.bathtub, size: 20, color: AppColors.primary),
                  SizedBox(width: 4),
                  Text(listing.country,
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ],
          ),
          SizedBox(height: AppSizes.secondaryGapHeight),
          Row(
            children: [
              Icon(Icons.location_on,
                  size: AppSizes.bigIcon, color: AppColors.primary),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  listing.address,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.offWhite),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
