part of '../index.dart';

class AuthService extends AppService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // User canceled sign-in

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // Check if user exists in Firestore
        DocumentSnapshot userDoc = await _firestore
            .collection(FirebaseCollections.users)
            .doc(user.uid)
            .get();

        UserModel userModel = UserModel(
            id: user.uid,
            email: user.email ?? '',
            name: user.displayName ?? '',
            phoneNumber: "");

        if (!userDoc.exists) {
          // Store in Firebase if new user
          await _firestore
              .collection('users')
              .doc(user.uid)
              .set(userModel.toMap());
        }

        await SharedService.storeUserLocally(
            userModel); // Save in SharedPreferences
      }

      return user;
    } catch (e) {
      CustomSnackbar.show("Google sign-in failed", isError: true);
      return null;
    }
  }

  // Sign up with email & password
  Future<User?> signUp(
      String phone, String email, String password, String name) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("User created: ${userCredential}");
      final User? user = userCredential.user;
      if (user != null) {
        UserModel userModel = UserModel(
            id: user.uid, email: email, name: name, phoneNumber: phone);

        await _firestore
            .collection('users')
            .doc(user.uid)
            .set(userModel.toMap());
        await sendEmailVerification();
        await SharedService.storeUserLocally(
            userModel); // Save in SharedPreferences
      }
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        CustomSnackbar.show("This email is already registered.", isError: true);
      } else if (e.code == 'weak-password') {
        CustomSnackbar.show("The password is too weak.", isError: true);
      } else if (e.code == 'invalid-email') {
        CustomSnackbar.show("Invalid email address.", isError: true);
      } else {
        CustomSnackbar.show("Sign-up failed. Try again. $e", isError: true);
      }
      return null;
    } catch (e) {
      CustomSnackbar.show("An error occurred. Try again. $e", isError: true);
      return null;
    }
  }

  // Sign in with email & password
  Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;
      if (user != null) {
        UserModel userModel = UserModel(
            id: user.uid,
            email: email,
            name: user.displayName ?? '',
            phoneNumber: "");

        UserModel? storedUser = await SharedService.getUserFromStorage();
        if (storedUser == null) {
          await SharedService.storeUserLocally(
              userModel); // Save in SharedPreferences// Navigate to Home Screen
        }
      }
      return user;
    } catch (e) {
      CustomSnackbar.show("Invalid Credentials", isError: true);
      return null;
    }
  }

  Future<void> reloadUser() async {
    await _auth.currentUser?.reload();
  }

  bool isEmailVerified() {
    return _auth.currentUser?.emailVerified ?? false;
  }

  // Send email verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
      CustomSnackbar.show("Verification email sent", isError: false);
    } catch (e) {
      CustomSnackbar.show("Failed to send verification email", isError: false);
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      CustomSnackbar.show("Password reset email sent. Check your inbox!");
    } catch (e) {
      CustomSnackbar.show("Error: Unable to send reset email.", isError: true);
    }
  }

  Future<void> clearUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
