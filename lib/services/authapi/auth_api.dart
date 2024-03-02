import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthApi {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        return null;
      }
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
      log("Successfull login");

      return userCredential;
    } catch (e) {
      log("Error during Google sign-in: $e");
      return null;
    }
  }

  static Future<void> signOutGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      await googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      await Future.delayed(Duration(seconds: 2));

      log("Logout Successfully");
    } catch (e) {
      log("Error signing out: $e");
    }
  }

  static Future<String> getProfilePic() async {
    if (firebaseAuth.currentUser != null) {
      try {
        String photoUrl = firebaseAuth.currentUser!.photoURL!;
        if (photoUrl.isEmpty) {
          log("Error there is no photo");
          return "";
        } else {
          return photoUrl;
        }
      } catch (e) {
        log("Error there is no photo ${e.toString()}");
        return "";
      }
    } else {
      log("User is null Please Login Again");
      return "";
    }
  }

  static Future<String> getUserEmail() async {
    if (firebaseAuth.currentUser != null) {
      try {
        String email = firebaseAuth.currentUser!.email!;
        if (email.isEmpty) {
          log("Error there is no Email");
          return "";
        } else {
          return email;
        }
      } catch (e) {
        log("Error there is no Email ${e.toString()}");
        return "";
      }
    } else {
      log("User is null Please Login Again");
      return "";
    }
  }

  static Future<String> getUserName() async {
    if (firebaseAuth.currentUser != null) {
      try {
        String displayName = firebaseAuth.currentUser!.displayName!;
        if (displayName.isEmpty) {
          log("Error there is no displayName");
          return "";
        } else {
          return displayName;
        }
      } catch (e) {
        log("Error there is no displayName ${e.toString()}");
        return "";
      }
    } else {
      log("User is null Please Login Again");
      return "";
    }
  }
}
