part of '../index.dart';

class HomeController extends GetxController {
  var properties = [].obs;
  var isLoading = true.obs;
  Rx<UserModel?> userModel = Rx<UserModel?>(null);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    loadProperties();
    checkLoggedInUser().then((onValue) => {fetchUserData()});
  }

  Future<void> checkLoggedInUser() async {
    UserModel? storedUser = await SharedService.getUserFromStorage();
    if (storedUser != null) {
      userModel.value = storedUser; // Navigate to Home Screen
    }
  }

  Future<void> fetchUserData() async {
    try {
      String userId = userModel.value!.id; // Replace with actual user ID
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        userModel.value =
            UserModel.fromMap(userDoc.data() as Map<String, dynamic>, userId);
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  void loadProperties() async {
    isLoading.value = true;
    // properties.value = await ListingsService.fetchProperties();
    isLoading.value = false;
  }
}
