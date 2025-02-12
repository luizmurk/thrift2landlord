import 'package:firebase_auth/firebase_auth.dart';
import 'app_services.dart';

class AuthService extends AppService {
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
