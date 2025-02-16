part of '../index.dart';

class UserService extends AppService {
  Future<void> updateUserProfile({
    required String userId,
    required String name,
    required String email,
    String? phone,
    String? photoUrl,
  }) async {
    Map<String, dynamic> updatedData = {
      'name': name,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
    };

    UserModel userModel = UserModel(
        id: userId,
        email: email,
        name: name,
        phoneNumber: phone ?? "",
        photoUrl: photoUrl ?? "");

    await updateDocument('users', userId, updatedData);
    await SharedService.storeUserLocally(userModel);
  }
}
