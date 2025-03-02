part of '../index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late PageController _pageController;
  final HomeController controller =
      Get.put(HomeController()); // Inject controller

  final List<Widget> _pages = [
    LandingScreen(),
    ListingsScreen(),
    PropertiesScreen(),
    PaymentsScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  void _onTabTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            children: _pages,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),

          // KYC Banner (Only shows if user is NOT verified)
          Obx(() {
            if (controller.userModel.value?.isVerified == false &&
                controller.isLoading.value == false) {
              return KYCBanner();
            }
            return SizedBox.shrink();
          }),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildKYCBanner() {
    return Positioned(
      child: Container(
        height: 600.h,
        margin: EdgeInsets.only(top: 50.h),
        child: Card(
          color: Colors.red.shade100,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Complete Your KYC!",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  "Your account is not verified yet. Please complete your KYC to continue using all features.",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => Get.toNamed(AppRoutes.kyc),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text("Complete KYC",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: AppSizes.p8, vertical: AppSizes.ph3),
      margin: EdgeInsets.symmetric(
          horizontal: AppSizes.p16, vertical: AppSizes.ph10),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(AppSizes.radiusXL),
        border: Border.all(
          color: AppColors.offWhite,
          width: AppSizes.primaryBorderThickness,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radiusXL),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.grey,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.offWhite,
          showUnselectedLabels: true,
          elevation: 100.0,
          items: [
            _buildNavItem(Icons.home, "Home", 0),
            _buildNavItem(Icons.search, "Listings", 1),
            _buildNavItem(Icons.circle, "Properties", 2),
            _buildNavItem(Icons.payment, "Payments", 3),
            BottomNavigationBarItem(
              icon: CustomAvatar(
                imageUrl: controller.userModel.value?.photoUrl ??
                    'https://via.placeholder.com/150',
                size: AppSizes.bigIcon,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, animation) =>
            ScaleTransition(scale: animation, child: child),
        child: Icon(icon, key: ValueKey<int>(_currentIndex == index ? 1 : 0)),
      ),
      label: label,
    );
  }
}
