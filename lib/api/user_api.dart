import 'package:firebase_auth/firebase_auth.dart';

import '../models/driver.dart';

class UserAPI {
  final DriverModel _user = DriverModel();
  final FirebaseAuth auth;
  UserAPI({required this.auth});

  Future<UserCredential?> signIn(String email, String password) async {
    String? errorMessage;
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      return result;
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";

          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";

          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      print(errorMessage);
      print(error.code);

      return null;
    }
  }
  Future<FirebaseAuth?> signOut() async {
    await auth.signOut();
    return auth;
  }
}