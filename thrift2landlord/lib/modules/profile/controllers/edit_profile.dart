part of '../index.dart';

class EditProfileController extends GetxController {
  final AuthService _authService = AuthService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  var currentUser = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    setUser();
  }

  var isLoading = false.obs;
  var profileImage = Rxn<String>();

  void pickProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage.value = pickedFile.path;
    }
  }

  Future<void> setUser() async {
    UserModel? storedUser = await SharedService.getUserFromStorage();
    if (storedUser != null) {
      currentUser.value = storedUser; // Navigate to Home Screen
    }
  }

  void updateProfile(String userId) async {
    if (nameController.text.isEmpty || emailController.text.isEmpty) {
      Get.snackbar('Error', 'Name and Email are required');
      return;
    }

    isLoading.value = true;
    try {
      await UserService().updateUserProfile(
        userId: userId,
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        photoUrl: profileImage.value,
      );
      setUser();
      Get.back();
      Get.snackbar('Success', 'Profile updated successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void showEditProfileBottomSheet(BuildContext context, UserModel user) {
    final controller = Get.put(EditProfileController());
    controller.nameController.text = user.name;
    controller.emailController.text = user.email;
    controller.phoneController.text = '';
    controller.profileImage.value = user.photoUrl;

    CustomBottomSheet.show(
        context: context, title: 'Edit Profile', child: EditProfileForm());
  }
}
