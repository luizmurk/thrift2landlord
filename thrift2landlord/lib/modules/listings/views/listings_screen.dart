part of '../index.dart';

class ListingsScreen extends StatelessWidget {
  final ListingsController listingsController = Get.put(ListingsController());
  final TextEditingController searchController =
      TextEditingController(); // Add this

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Home",
        style: Theme.of(context).textTheme.headlineMedium,
      )),
      body: Column(
        children: [
          SettingsListTile(
            icon: Icons.account_circle,
            title: "Account Settings",
            subtitle: "Manage your account details",
            onTap: () {
              // Navigate to account settings
            },
          ),
        ],
      ),
    );
  }
}
