part of '../index.dart';

class LikedProperties extends StatefulWidget {
  const LikedProperties({super.key});

  @override
  _LikedPropertiesState createState() => _LikedPropertiesState();
}

class _LikedPropertiesState extends State<LikedProperties> {
  final LikesController controller = Get.put(LikesController());
  final ListingsController listingController =
      Get.put<ListingsController>(ListingsController());

  String? selectedLocation;
  final List<String> locations = ["Gwagwalada", "Apo", "Lugbe"];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.dark
          : AppColors.light,
      appBar: AppBar(
        title: Text(
          "Liked Properties",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.primaryPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: AppSizes.primaryGapHeight),
            Obx(() {
              if (controller.isLoading.value) {
                return ListingOfTheDaySkeletonLoader(); // Replace with skeleton loader
              } else if (controller.likedProperties.isEmpty) {
                return Text('No listing of the day yet');
              }
              return SizedBox(
                height: 1000.h,
                width: 1000.w,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: controller.likedProperties.length,
                  itemBuilder: (context, index) {
                    final listing = controller.likedProperties[index];
                    return GestureDetector(
                      onTap: () {
                        listingController.showListing(context, listing);
                      },
                      child: ListingsCard(
                        listing: listing,
                        isList: true,
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
