part of '../index.dart';

class ListingsCard extends StatelessWidget {
  final ListingModel listing;
  final bool? isList;

  const ListingsCard({
    required this.listing,
    this.isList = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(AppSizes.primaryPadding),
          width: !isList! ? AppSizes.listingCardImageWidth : null,
          height: AppSizes.listingCardImageHeight,
          margin: !isList!
              ? EdgeInsets.only(left: AppSizes.p8)
              : EdgeInsets.only(top: AppSizes.p8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.primaryRadius),
            image: DecorationImage(
              image: NetworkImage(listing.imageUrls.first),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.all(AppSizes.primaryPadding),
            child: Container(
              height: AppSizes.listingCardImageHeight / 3.5,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.all(
                  Radius.circular(AppSizes.primaryRadius),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(AppSizes.primaryPadding),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${listing.city}, ${listing.country}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          listing.title,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '₦${listing.price.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      height: 50.h,
                      padding: EdgeInsets.symmetric(
                        vertical: AppSizes.p8,
                        horizontal: AppSizes.p8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius:
                            BorderRadius.circular(AppSizes.primaryRadius),
                      ),
                      child: Center(
                        child: Text(
                          '₦${(listing.price / 1000000).toStringAsFixed(2)}M',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: AppColors.light,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
