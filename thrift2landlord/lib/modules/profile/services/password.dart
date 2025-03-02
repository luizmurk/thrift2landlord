part of '../index.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> updatePassword(String oldPassword, String newPassword) async {
    User? user = _auth.currentUser;
    if (user == null) throw "User not logged in";

    AuthCredential credential = EmailAuthProvider.credential(
      email: user.email!,
      password: oldPassword,
    );

    try {
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
    } catch (e) {
      throw "Incorrect old password or weak new password";
    }
  }
}
