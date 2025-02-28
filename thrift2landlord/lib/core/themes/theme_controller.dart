import 'package:get/get.dart';
import 'app_theme.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(
        isDarkMode.value ? AppTheme.darkTheme : AppTheme.lightTheme);
  }
}
