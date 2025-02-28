part of '../index.dart';

class PropertiesScreen extends StatefulWidget {
  const PropertiesScreen({super.key});

  @override
  State<PropertiesScreen> createState() => _PropertiesScreenState();
}

class _PropertiesScreenState extends State<PropertiesScreen> {
  final PropertiesController controller = Get.put(PropertiesController());

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.fetchProperties();
  }

  // Add this
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.dark
          : AppColors.light,
      appBar: AppBar(
        title: Text(
          "Properties",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.house_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              Get.toNamed(AppRoutes.liked);
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.properties.isEmpty) {
          return Center(
              child: EmptyCMPState(
            title: '🚫 No Properties Yet!',
            body: 'Explore available lands and make your first purchase today.',
            buttonText: 'Find Properties Now',
            onButtonPressed: () {
              Get.toNamed(AppRoutes.listings);
            },
          ));
        }
        return Padding(
          padding: EdgeInsets.all(AppSizes.primaryPadding),
          child: ListView.builder(
            itemCount: controller.properties.length,
            itemBuilder: (context, index) {
              ListingModel listing = controller.properties[index];
              return GestureDetector(
                  onTap: () {
                    controller.showListing(context, listing);
                  },
                  child: PropertyCard(listing: listing));
            },
          ),
        );
      }),
    );
  }
}
