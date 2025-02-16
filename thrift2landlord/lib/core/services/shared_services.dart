import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/data/user_model.dart';
import 'app_services.dart';

class SharedService extends AppService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  /// Sign in user
  Future<UserCredential> signIn(String email, String password) async {
    try {
      return await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  static Future<void> storeUserLocally(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', user.toJson());
  }

  static Future<UserModel?> getUserFromStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user');

    if (userData != null) {
      return UserModel.fromJson(userData);
    }
    return null;
  }

  /// Register user
  Future<UserCredential> register(String email, String password) async {
    try {
      return await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw Exception("Registration failed: $e");
    }
  }

  /// Sign out user
  Future<void> signOut() async {
    await auth.signOut();
  }
}
