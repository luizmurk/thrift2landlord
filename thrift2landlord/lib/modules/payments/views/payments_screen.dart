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
    propertiesController.fetchProperties();
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
            // IconButton(
            //   icon: Icon(Icons.add),
            //   onPressed: () {
            //     // Get.toNamed(AppRoutes.documents);
            //   },
            // ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            propertiesController.fetchProperties();
            propertiesController.getPayments();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
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
                              _listingController.showListing(context,
                                  propertiesController.properties[index]);
                            },
                            child: PropertyPaymentCard(
                                listing:
                                    propertiesController.properties[index]),
                          );
                        },
                      ),
                    );
                  }),
                ),

                // Transaction History Heading
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Transaction History',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),

                // Transaction List
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: propertiesController.getPayments().length,
                  itemBuilder: (context, index) {
                    PaymentModel payment =
                        propertiesController.getPayments()[index];
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/na-wali-b7671.appspot.com/o/listings%2Flisting2.jpeg?alt=media&token=6e19178c-cfba-42fb-958a-73fc1b342576'),
                      ),
                      title: Text('Payment ID: ${payment.paymentId}',
                          style: Theme.of(context).textTheme.labelMedium),
                      subtitle: Text('Status: ${payment.status}'),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: payment.status == 'complete'
                                      ? Colors.green
                                      : Colors.blueGrey,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  payment.status == 'complete'
                                      ? Icons.check
                                      : Icons.timer,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                  '₦${NumberFormat.compact().format(payment.amount)}',
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ],
                          ),
                          Text('${payment.date.toLocal()}'.split(' ')[0],
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
