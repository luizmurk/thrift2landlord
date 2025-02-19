import 'package:get/get.dart';
import '../../modules/auth/index.dart';
import '../../modules/chat/index.dart';
import '../../modules/home/index.dart';
import '../../modules/listings/index.dart';
import '../../modules/onboarding/index.dart';
import '../../modules/payments/index.dart';
import '../../modules/profile/index.dart';
import '../../modules/properties/index.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => OnboardingScreen(),
    ),
    GetPage(
      name: AppRoutes.listings,
      page: () => ListingsScreen(),
      binding: ListingsBinding(),
    ),
    GetPage(
      name: AppRoutes.signIn,
      page: () => SignInScreen(),
      // binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => SignUpScreen(),
      // binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => ForgotPasswordScreen(),
      // binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.emailVerify,
      page: () => EmailVerificationScreen(),
      // binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.properties,
      page: () => PropertiesScreen(),
      binding: PropertiesBinding(),
    ),
    GetPage(
      name: AppRoutes.payments,
      page: () => PaymentsScreen(),
      binding: PaymentsBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => ChatScreen(),
    ),
    //   GetPage(
    //   name: AppRoutes.splash,
    //   page: () => SplashScreen(),
    //   binding: SplashBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.onboarding,
    //   page: () => OnboardingScreen(),
    // ),
    // GetPage(
    //   name: AppRoutes.login,
    //   page: () => LoginScreen(),
    //   binding: AuthBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.register,
    //   page: () => RegisterScreen(),
    //   binding: AuthBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.propertyDetail,
    //   page: () => PropertyDetailScreen(),
    //   binding: ListingsBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.chat,
    //   page: () => ChatScreen(),
    //   binding: ChatBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.payments,
    //   page: () => PaymentsScreen(),
    //   binding: PaymentsBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.profile,
    //   page: () => ProfileScreen(),
    //   binding: ProfileBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.adminDashboard,
    //   page: () => AdminDashboardScreen(),
    //   binding: AdminBinding(),
    // ),
  ];
}

// HOW TO ROUTE
// Navigate to Listings Page
// Get.toNamed(AppRoutes.listings);

// // Navigate with parameters
// Get.toNamed(AppRoutes.propertyDetail, arguments: {'propertyId': '123'});

// // Navigate and remove previous screen (e.g., after login)
// Get.offNamed(AppRoutes.listings);

// // Navigate and clear history (e.g., after onboarding)
// Get.offAllNamed(AppRoutes.listings);
