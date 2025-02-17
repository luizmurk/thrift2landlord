part of '../index.dart';

class YourListing extends StatefulWidget {
  final ListingModel listing;

  const YourListing({super.key, required this.listing});

  @override
  State<YourListing> createState() => _YourListingState();
}

class _YourListingState extends State<YourListing> {
  final PaymentsController _paymentController = Get.find<PaymentsController>();
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
              borderRadius: BorderRadius.circular(AppSizes.primaryRadius),
              image: DecorationImage(
                image: NetworkImage(widget.listing.imageUrls.first),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: AppSizes.primaryGapHeight),
          Text(
            widget.listing.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: AppSizes.secondaryGapHeight),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${widget.listing.price.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Row(
                children: [
                  Icon(Icons.king_bed,
                      size: AppSizes.mediumIcon, color: AppColors.primary),
                  SizedBox(width: AppSizes.secondaryGapWidth),
                  Text('${widget.listing.city}',
                      style: Theme.of(context).textTheme.bodyMedium),
                  SizedBox(width: AppSizes.primaryGapWidth),
                  Icon(Icons.bathtub,
                      size: AppSizes.mediumIcon, color: AppColors.primary),
                  SizedBox(width: AppSizes.secondaryGapWidth),
                  Text('${widget.listing.country}',
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
              SizedBox(width: AppSizes.secondaryGapWidth),
              Expanded(
                child: Text(
                  widget.listing.address,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.offWhite),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.primaryGapHeight),
          CustomSecondaryButton(
            text: "View Payment History",
            onPressed: () {
              _paymentController.showPaymentHistory(
                  context, widget.listing.paymentHistory, 10.0, 7, false);
            },
          ),
        ],
      ),
    );
  }
}
