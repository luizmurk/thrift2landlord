part of '../index.dart';

class KYCService {
  static Future<String> uploadFile(XFile file, String path) async {
    Reference ref = FirebaseStorage.instance.ref().child('$path/${file.name}');
    UploadTask uploadTask = ref.putFile(File(file.path));
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  static Future<bool> submitKYC(KYCModel kycData) async {
    final kycRef = FirebaseFirestore.instance.collection('kyc');

    // Check if KYC already exists for this user
    final querySnapshot = await kycRef.where('id', isEqualTo: kycData.id).get();

    if (querySnapshot.docs.isNotEmpty) {
      // KYC already submitted, show a snackbar
      Get.snackbar("Submission Error", "You have already submitted your KYC",
          snackPosition: SnackPosition.BOTTOM,
          icon: Icon(Icons.error),
          backgroundColor: Colors.red,
          colorText: AppColors.light);
      return false;
    }

    // Submit new KYC data
    await kycRef.add(kycData.toJson());
    return true;
  }
}
