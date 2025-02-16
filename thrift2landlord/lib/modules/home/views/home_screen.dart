part of '../index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late PageController _pageController;

  final List<Widget> _pages = [
    ListingsScreen(),
    ChatScreen(),
    PaymentsScreen(),
    PropertiesScreen(),
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
      curve: Curves.easeInOut, // Smooth transition
    );
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(), // Natural scroll feel
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
            horizontal: AppSizes.p8, vertical: AppSizes.ph3),
        margin: EdgeInsets.symmetric(
            horizontal: AppSizes.p16, vertical: AppSizes.ph10),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppSizes.radiusXL),
          border: Border.all(
            color: AppColors.offWhite, // Use AppColors for the border color
            width: AppSizes
                .primaryBorderThickness, // Use AppSizes for the border width
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.radiusXL),
          child: BottomNavigationBar(
            // fixedColor: AppColors.primary,
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.primary,
            selectedItemColor: Theme.of(context).brightness == Brightness.dark
                ? AppColors.dark
                : AppColors.light,
            unselectedItemColor: Colors.white.withOpacity(0.5),
            showUnselectedLabels: true,
            elevation: 100.0, // Added elevation for the bottom navigation bar
            items: [
              _buildNavItem(Icons.home, "Listings", 0),
              _buildNavItem(Icons.chat, "Chat", 1),
              _buildNavItem(Icons.payment, "Payments", 2),
              _buildNavItem(Icons.business, "Properties", 3),
              BottomNavigationBarItem(
                icon: CustomAvatar(
                  imageUrl: ImageUrls.profilePlaceholder,
                  size: AppSizes.bigIcon,
                ),
                label: 'Profile',
              ),
            ],
          ),
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
