import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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

  static Future<UserCredential?> signInWithApple() async {
    try {
      final AuthorizationCredentialAppleID appleCredential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final OAuthCredential oauthCredential =
          OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(oauthCredential);
      log("Successful Apple login");

      return userCredential;
    } catch (e) {
      log("Error during Apple sign-in: $e");
      return null;
    }
  }

  static Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      log("Logout Successfully");
    } catch (e) {
      log("Error signing out: $e");
    }
  }

  static Future<UserCredential?> signInWithGitHub() async {
    const String clientId = 'YOUR_GITHUB_CLIENT_ID';
    const String clientSecret = 'YOUR_GITHUB_CLIENT_SECRET';
    final Uri githubUrl = Uri.parse(
        'https://github.com/login/oauth/authorize?client_id=$clientId&scope=read:user user:email');
    final http.Response response = await http.post(
      Uri.parse('https://github.com/login/oauth/access_token'),
      headers: <String, String>{
        'Accept': 'application/json',
      },
      body: <String, String>{
        'client_id': clientId,
        'client_secret': clientSecret,
        'code': 'AUTHORIZATION_CODE',
      },
    );
    final Map<String, dynamic> data = json.decode(response.body);
    final String accessToken = data['access_token'];

    final AuthCredential credential =
        GithubAuthProvider.credential(accessToken);
    return await firebaseAuth.signInWithCredential(credential);
  }
}
