part of '../index.dart';

class ListingDetailsScreen extends StatefulWidget {
  final ListingModel listing;

  const ListingDetailsScreen({Key? key, required this.listing})
      : super(key: key);

  @override
  State<ListingDetailsScreen> createState() => _ListingDetailsScreenState();
}

class _ListingDetailsScreenState extends State<ListingDetailsScreen> {
  bool isImageExpanded = false;

  void toggleImageView() {
    setState(() {
      isImageExpanded = !isImageExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          GestureDetector(
            onTap: toggleImageView,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: isImageExpanded ? Get.height * 0.8 : 250,
              child: PageView.builder(
                itemCount: widget.listing.imageUrls.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    widget.listing.imageUrls[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          SizedBox(height: AppSizes.primaryGapHeight),

          // Price & Basic Details
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.primaryPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.listing.title,
                    style: Theme.of(context).textTheme.headlineMedium),
                SizedBox(height: AppSizes.primaryGapHeight),
                CustomDivider(thickness: AppSizes.primaryDividerThickness),
                SizedBox(height: AppSizes.primaryGapHeight),
                Row(
                  children: [
                    Text(
                      NumberFormat.currency(symbol: "\$", decimalDigits: 2)
                          .format(widget.listing.price),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.primaryGapHeight),
                Text(widget.listing.address,
                    style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: AppSizes.primaryGapHeight),
                Text("City: ${widget.listing.city} sq ft",
                    style: Theme.of(context).textTheme.bodyMedium),
                SizedBox(height: AppSizes.secondaryGapHeight),
                Text("Category: ${widget.listing.categories.first.name}",
                    style: Theme.of(context).textTheme.bodyMedium),
                SizedBox(height: AppSizes.primaryGapHeight),
                CustomDivider(thickness: AppSizes.primaryDividerThickness),
                SizedBox(height: AppSizes.primaryGapHeight),

                // Map Section
                // SizedBox(
                //   height: 250,
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(AppSizes.primaryRadius),
                //     child: GoogleMap(
                //       initialCameraPosition: CameraPosition(
                //         target: LatLng(widget.listing.location['lat']!,
                //             widget.listing.location['lng']!),
                //         zoom: 14,
                //       ),
                //       markers: {
                //         Marker(
                //           markerId: MarkerId(widget.listing.id),
                //           position: LatLng(widget.listing.location['lat']!,
                //               widget.listing.location['lng']!),
                //           infoWindow: InfoWindow(title: widget.listing.title),
                //         ),
                //       },
                //     ),
                //   ),
                // ),
                SizedBox(height: AppSizes.primaryGapHeight),

                // Installment Availability
                Row(
                  children: [
                    Icon(
                        widget.listing.isInstallmentAvailable
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: Colors.green),
                    SizedBox(width: AppSizes.secondaryGapWidth),
                    Text(widget.listing.isInstallmentAvailable
                        ? "Installment Available"
                        : "One-time Payment Only"),
                  ],
                ),
                SizedBox(height: AppSizes.primaryGapHeight),
                if (widget.listing.isInstallmentAvailable)
                  Row(
                    children: [
                      Icon(Icons.calendar_month, color: Colors.blue),
                      SizedBox(width: AppSizes.secondaryGapWidth),
                      Text("${widget.listing.installmentMonths} months plan"),
                    ],
                  ),
                SizedBox(height: AppSizes.primaryGapHeight),

                // Realtor Information
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(ImageUrls.profilePlaceholder),
                  ),
                  title: Text("Gambert Young"),
                  subtitle: Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: AppSizes.secondaryGapWidth),
                      Text("4.5"),
                    ],
                  ),
                ),
                SizedBox(height: AppSizes.primaryGapHeight),
                Text("Reviews", style: Theme.of(context).textTheme.labelLarge),
                SizedBox(height: AppSizes.primaryGapHeight),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.listing.reviews.length,
                  itemBuilder: (context, index) {
                    final review = widget.listing.reviews[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(review.comment,
                              style: Theme.of(context).textTheme.bodyMedium),
                          SizedBox(width: AppSizes.secondaryGapHeight),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber),
                              SizedBox(width: 4),
                              Text(review.rating.toString(),
                                  style: Theme.of(context).textTheme.bodySmall),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: AppSizes.primaryGapHeight),

                CustomPrimaryButton(
                  text: "Contact Realtor",
                  onPressed: () {},
                  isLoading: false,
                ),
                SizedBox(height: AppSizes.primaryGapHeight),
                CustomSecondaryButton(
                  text: "Make Payment",
                  onPressed: () {
                    // Get.toNamed(AppRoutes.signIn);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
