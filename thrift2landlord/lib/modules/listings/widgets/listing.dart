part of '../index.dart';

class ListingDetailsScreen extends StatefulWidget {
  final ListingModel? listing;

  const ListingDetailsScreen({super.key, this.listing});

  @override
  State<ListingDetailsScreen> createState() => _ListingDetailsScreenState();
}

class _ListingDetailsScreenState extends State<ListingDetailsScreen> {
  late ListingModel listing;
  String? selectedImage;

  @override
  void initState() {
    super.initState();
    listing = Get.arguments as ListingModel;
  }

  void showFullImage(String imageUrl) {
    setState(() {
      selectedImage = imageUrl;
    });
  }

  void closeFullImage() {
    setState(() {
      selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              listing.imageUrls.first,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.5),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.5),
                          child: IconButton(
                            icon: Icon(Icons.location_pin, color: Colors.white),
                            onPressed: () {
                              // Add your onPressed logic here
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.5),
                          child: IconButton(
                            icon: Icon(Icons.favorite_border,
                                color: Colors.white),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              listing.owner != null
                  ? SizedBox(
                      height: 130.h,
                      child: Image.asset(
                        'assets/images/sold.png',
                        fit: BoxFit.cover,
                      ),
                    )
                  : SizedBox(),
              Container(
                margin: listing.owner == null
                    ? EdgeInsets.only(top: 134.h)
                    : EdgeInsets.only(top: 2.h),
                height: 100.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listing.imageUrls.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () => showFullImage(listing.imageUrls[index]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            listing.imageUrls[index],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 15.h),
                  width: double.infinity,
                  height: AppSizes.authImageHeight,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(AppSizes.primaryPadding),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: AppSizes.primaryGapHeight),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    constraints:
                                        BoxConstraints(maxWidth: 200.0),
                                    child: Text(
                                      listing.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    '${listing.city}, ${listing.country}',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    '500sqm',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: 50.h,
                                    padding: EdgeInsets.symmetric(
                                      vertical: AppSizes.p8,
                                      horizontal: AppSizes.p8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(
                                          AppSizes.primaryRadius),
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
                                  SizedBox(height: AppSizes.secondaryGapHeight),
                                  Text(
                                    '₦500k / ${listing.installmentMonths} months',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: AppSizes.primaryGapHeight),
                          Text(
                            listing.description ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.black,
                                ),
                          ),
                          SizedBox(height: AppSizes.primaryGapHeight),
                          listing.owner == null
                              ? CustomPrimaryButton(
                                  text: 'Buy Land Now',
                                  onPressed: () {
                                    Get.toNamed(AppRoutes.payment_checkout,
                                        arguments: listing);
                                  },
                                )
                              : SizedBox(),
                          SizedBox(height: AppSizes.primaryGapHeight),
                          CustomSecondaryButton(
                            text: 'See Land on Map',
                            onPressed: () {
                              // Add your onPressed logic here
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (selectedImage != null)
            GestureDetector(
              onTap: closeFullImage,
              child: Container(
                color: Colors.black.withOpacity(0.8),
                child: Center(
                  child: Image.network(
                    selectedImage!,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
