part of '../index.dart';

class KYCController extends GetxController {
  var isLoading = false.obs;
  // Personal Information
  final fullNameController = TextEditingController();
  final dobController = TextEditingController();
  final gender = ''.obs;
  final nationalityController = TextEditingController();
  final addressController = TextEditingController();
  final stateController = TextEditingController();
  final lgaController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  // Identification Documents
  final idType = ''.obs;
  final bvnController = TextEditingController();
  final utilityBillController = TextEditingController();
  final idFilePath = ''.obs;
  final utilityBillFilePath = ''.obs;

  // Employment & Income Details
  final employmentStatus = ''.obs;
  final employerNameController = TextEditingController();
  final employerAddressController = TextEditingController();
  final businessNatureController = TextEditingController();
  final incomeRange = ''.obs;
  final sourceOfFunds = ''.obs;

  // Bank & Financial Details
  final bankNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final accountNameController = TextEditingController();
  final paymentMethod = ''.obs;

  // Next of Kin
  final nokFullNameController = TextEditingController();
  final nokRelationshipController = TextEditingController();
  final nokPhoneController = TextEditingController();
  final nokAddressController = TextEditingController();

  // Security & Compliance
  final selfieFilePath = ''.obs;
  final signatureFilePath = ''.obs;
  final isTermsAccepted = false.obs;
  final isDataSharingAccepted = false.obs;

  var currentUser = Rxn<UserModel>();

  String? validateFields() {
    if (fullNameController.text.isEmpty) return "Full Name is required";
    if (dobController.text.isEmpty) return "Date of Birth is required";
    if (gender.value.isEmpty) return "Gender is required";
    if (nationalityController.text.isEmpty) return "Nationality is required";
    if (addressController.text.isEmpty) return "Address is required";
    if (stateController.text.isEmpty) return "State is required";
    if (lgaController.text.isEmpty) return "LGA is required";
    if (phoneController.text.isEmpty || phoneController.text.length < 10)
      return "Valid Phone Number is required";
    if (emailController.text.isEmpty || !GetUtils.isEmail(emailController.text))
      return "Valid Email is required";
    if (idType.value.isEmpty) return "ID Type is required";
    if (bvnController.text.isEmpty || bvnController.text.length != 11)
      return "Valid 11-digit BVN is required";
    if (idFilePath.value.isEmpty) return "ID Upload is required";
    if (employmentStatus.value.isEmpty) return "Employment Status is required";
    if (bankNameController.text.isEmpty) return "Bank Name is required";
    if (accountNumberController.text.isEmpty ||
        accountNumberController.text.length < 10)
      return "Valid Account Number is required";
    if (accountNameController.text.isEmpty) return "Account Name is required";
    if (nokFullNameController.text.isEmpty)
      return "Next of Kin Full Name is required";
    if (nokRelationshipController.text.isEmpty)
      return "Next of Kin Relationship is required";
    if (nokPhoneController.text.isEmpty || nokPhoneController.text.length < 10)
      return "Valid Next of Kin Phone Number is required";
    if (nokAddressController.text.isEmpty)
      return "Next of Kin Address is required";
    if (selfieFilePath.value.isEmpty) return "Selfie Upload is required";
    if (signatureFilePath.value.isEmpty) return "Signature Upload is required";
    if (!isTermsAccepted.value)
      return "You must accept the Terms and Conditions";
    return null;
  }

  var currentStep = 0.obs;

  @override
  void onInit() {
    checkLoggedInUser();
    super.onInit();
  }

  Future<void> checkLoggedInUser() async {
    UserModel? storedUser = await SharedService.getUserFromStorage();
    if (storedUser != null) {
      currentUser.value = storedUser; // Navigate to Home Screen
    }
  }

  void nextStep() {
    if (currentStep.value < 5) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void updateDOB(DateTime date) {
    dobController.text = date.toIso8601String();
  }

  Future<void> uploadID(XFile file) async {
    isLoading.value = true;
    String url = await KYCService.uploadFile(file, 'kyc/ids');
    idFilePath.value = url;
    isLoading.value = false;
  }

  Future<void> uploadUtilityBill(XFile file) async {
    isLoading.value = true;
    String url = await KYCService.uploadFile(file, 'kyc/utility_bills');
    utilityBillFilePath.value = url;
    isLoading.value = false;
  }

  Future<void> uploadSelfie(XFile file) async {
    isLoading.value = true;
    String url = await KYCService.uploadFile(file, 'kyc/selfies');
    selfieFilePath.value = url;
    isLoading.value = false;
  }

  Future<void> uploadSignature(XFile file) async {
    isLoading.value = true;
    String url = await KYCService.uploadFile(file, 'kyc/signatures');
    signatureFilePath.value = url;
    isLoading.value = false;
  }

  Future<void> submitKYC() async {
    String? validationError = validateFields();
    if (validationError != null) {
      Get.snackbar("Validation Error", validationError,
          snackPosition: SnackPosition.BOTTOM,
          icon: Icon(Icons.error),
          backgroundColor: Colors.red,
          colorText: AppColors.light);
      return;
    }

    isLoading.value = true;
    final kycData = KYCModel(
      id: currentUser.value!.id,
      fullName: fullNameController.text,
      dob: dobController.text,
      gender: gender.value,
      nationality: nationalityController.text,
      address: addressController.text,
      state: stateController.text,
      lga: lgaController.text,
      phone: phoneController.text,
      email: emailController.text,
      idType: idType.value,
      bvn: bvnController.text,
      utilityBill: utilityBillController.text,
      idFilePath: idFilePath.value,
      utilityBillFilePath: utilityBillFilePath.value,
      employmentStatus: employmentStatus.value,
      employerName: employerNameController.text,
      employerAddress: employerAddressController.text,
      businessNature: businessNatureController.text,
      incomeRange: incomeRange.value,
      sourceOfFunds: sourceOfFunds.value,
      bankName: bankNameController.text,
      accountNumber: accountNumberController.text,
      accountName: accountNameController.text,
      paymentMethod: paymentMethod.value,
      nokFullName: nokFullNameController.text,
      nokRelationship: nokRelationshipController.text,
      nokPhone: nokPhoneController.text,
      nokAddress: nokAddressController.text,
      selfieFilePath: selfieFilePath.value,
      signatureFilePath: signatureFilePath.value,
      isTermsAccepted: isTermsAccepted.value,
      isDataSharingAccepted: isDataSharingAccepted.value,
    );
    var res = await KYCService.submitKYC(kycData);
    isLoading.value = false;
    res
        ? Get.offNamed(
            AppRoutes.completion,
            arguments: {
              'title': 'KYC Submitted Successfully!',
              'body':
                  'Your KYC details have been submitted for review. You will be notified once the verification is complete.',
              'buttonText': 'Go to Dashboard',
              'onPressed': () => Get.offAllNamed(AppRoutes.home),
            },
          )
        : null;
  }
}
