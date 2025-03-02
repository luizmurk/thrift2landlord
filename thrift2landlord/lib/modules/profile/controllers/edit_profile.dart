part of '../index.dart';

class EditProfileController extends GetxController {
  final AuthService _authService = AuthService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  var currentUser = Rxn<UserModel>();
  var isLoading = false.obs;
  var profileImage = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    setUser();
  }

  Future<void> setUser() async {
    UserModel? storedUser = await SharedService.getUserFromStorage();
    if (storedUser != null) {
      currentUser.value = storedUser;
      nameController.text = storedUser.name;
      emailController.text = storedUser.email;
      phoneController.text = storedUser.phoneNumber;
      profileImage.value = storedUser.photoUrl;
    }
  }

  Future<void> pickProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      isLoading.value = true;
      try {
        String downloadUrl = await _uploadImage(File(pickedFile.path));
        profileImage.value = downloadUrl;
        updateProfile(currentUser.value!.id, isImageOnly: true);
      } catch (e) {
        Get.snackbar('Error', 'Failed to upload image');
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<String> _uploadImage(File imageFile) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('profile_images/${currentUser.value!.id}.jpg');
      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload image');
    }
  }

  void updateProfile(String userId, {bool isImageOnly = false}) async {
    if (!isImageOnly &&
        (nameController.text.isEmpty || emailController.text.isEmpty)) {
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
    controller.phoneController.text = user.phoneNumber;
    controller.profileImage.value = user.photoUrl;

    CustomBottomSheet.show(
        context: context, title: 'Edit Profile', child: EditProfileForm());
  }
}
