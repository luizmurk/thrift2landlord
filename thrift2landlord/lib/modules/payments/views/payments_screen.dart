part of '../index.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  _PaymentsScreenState createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  final PaymentsController _controller = Get.put(PaymentsController());
  final PropertiesController propertiesController =
      Get.put(PropertiesController());
  final ListingsController _listingController = Get.find<ListingsController>();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // propertiesController.fetchProperties();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Get.toNamed(AppRoutes.documents);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Property Listings (Horizontal Scroll)
            SizedBox(
              height: 180,
              child: Obx(() {
                if (propertiesController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                if (propertiesController.properties.isEmpty) {
                  return Center(
                      child: EmptyCMPState(
                    title: '🚫 No Properties Yet!',
                    body:
                        'Explore available lands and make your first purchase today.',
                    buttonText: 'Find Properties Now',
                    onButtonPressed: () {
                      Get.toNamed(AppRoutes.listings);
                    },
                  ));
                }
                return SizedBox(
                  width: 380.w,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: propertiesController.properties.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _listingController.showListing(
                              context, propertiesController.properties[index]);
                        },
                        child: PropertyPaymentCard(
                            listing: propertiesController.properties[index]),
                      );
                    },
                  ),
                );
              }),
            ),

            // Action Buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text('Pause Payment',
                        style: TextStyle(color: Colors.red)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary),
                    onPressed: () {},
                    child: Text('Continue Payment',
                        style: TextStyle(color: AppColors.light)),
                  ),
                ],
              ),
            ),

            // Transaction History Heading
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Transaction History',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () {
                      // Get.to(() => TransactionHistoryPage());
                    },
                    child: Text('See More'),
                  ),
                ],
              ),
            ),

            // Transaction List
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5, // Replace with actual transaction count
              itemBuilder: (context, index) {
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/na-wali-b7671.appspot.com/o/listings%2Flisting2.jpeg?alt=media&token=6e19178c-cfba-42fb-958a-73fc1b342576'),
                  ),
                  title: Text('Old Amusement Park',
                      style: Theme.of(context).textTheme.headlineSmall),
                  subtitle: Text('Payment: Mrs Tosin'),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.check,
                                color: Colors.white, size: 16),
                          ),
                          SizedBox(width: 5),
                          Text('₦5M',
                              style: Theme.of(context).textTheme.headlineSmall),
                        ],
                      ),
                      Text('Dec 27, 2025',
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
