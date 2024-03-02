import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventapp/model/user_data.dart';
import 'package:eventapp/services/authapi/auth_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum UserRole { organizer, user }

class AuthScreenController extends GetxController {
  Rx<ScrollController> scrollController = ScrollController().obs;
  Rx<TextEditingController> dateEditingController = TextEditingController().obs;
  Rx<TextEditingController> nameEditingController = TextEditingController().obs;
  Rx<TextEditingController> pubEditingController = TextEditingController().obs;
  Rx<TextEditingController> priEditingController = TextEditingController().obs;
  Rx<UserRole> selectedRole = UserRole.user.obs;
  Rx<String> dob = "".obs;
  Rx<bool> isLoading = false.obs;
  Rx<bool> showPubKey = true.obs;
  Rx<bool> showPriKey = true.obs;

  @override
  void dispose() {
    super.dispose();
    scrollController.update((val) {
      val!.dispose();
    });
  }

  Widget showGoogleImage() {
    return FutureBuilder<String>(
        future: AuthApi.getProfilePic(),
        builder: (context, snapshot) {
          if (snapshot.hasError ||
              snapshot.data == null ||
              snapshot.data == "") {
            return Image.asset(
              "assets/images/p3.png",
              height: Get.size.shortestSide / 10,
              width: Get.size.shortestSide / 10,
              fit: BoxFit.cover,
            );
          }
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: snapshot.data!,
                  height: Get.size.shortestSide / 3,
                  width: Get.size.shortestSide / 3,
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Image.asset(
                    "assets/images/p3.png",
                    height: Get.size.shortestSide / 4,
                    width: Get.size.shortestSide / 4,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<void> signInWithGoogle() async {
    isLoading(true);
    update();

    UserCredential? user = await AuthApi.signInWithGoogle();
    if (user == null) {
      isLoading(false);
      update();
      //display a snackbar

      return;
    }

    if (await checkuserExisted(user.user!.uid)) {
      log("Existed");
      isLoading(false);
      update();
      scrollController.update((val) {
        val!.animateTo((Get.size.longestSide / 1.25) * 2,
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate);
      });
      return;
    } else {
      scrollController.update((val) {
        val!.animateTo(Get.size.longestSide / 1.25,
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate);
      });

      log(await AuthApi.getUserName());
      log(await AuthApi.getUserEmail());
      log(await AuthApi.getProfilePic());

      nameEditingController.update((val) async {
        val!.text = await AuthApi.getUserName();
      });
    }

    isLoading(false);
    update();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      // This ensures the user can't pick a future date as their birthdate.
    );
    if (picked != null && picked != DateTime.now()) {
      dateEditingController.update((val) {
        val!.text = DateFormat('dd-MM-yyyy').format(picked);
      });
      update();

      dob(picked.millisecondsSinceEpoch.toString());
      update();
    }
  }

  Future<void> signOut() async {
    await AuthApi.signOutGoogle();
  }

  Future<bool> checkuserExisted(String uid) async {
    final existense =
        await AuthApi.firestore.collection("userData").doc(uid).get();
    if (existense.exists && existense.data() != null) {
      return true;
    }
    return false;
  }

  Future<void> updateProfileKeys() async {
    isLoading(true);
    update();
    final raw = await AuthApi.firestore
        .collection("userData")
        .doc(AuthApi.firebaseAuth.currentUser!.uid)
        .get();
    if (raw.data() != null && raw.exists) {
      var data = UserData.fromMap(raw.data()!);
      data.publicId = pubEditingController.value.text.trim();
      data.privateId = priEditingController.value.text.trim();
      await AuthApi.firestore
          .collection("userData")
          .doc(AuthApi.firebaseAuth.currentUser!.uid)
          .set(data.toMap());
      log("updated");
    } else {
      //show snackbar of something went wrong
    }
    isLoading(false);
    update();
  }

  Future<void> updateProfile() async {
    isLoading(true);
    update();

    if (!await checkuserExisted(AuthApi.firebaseAuth.currentUser!.uid)) {
      final name = nameEditingController.value.text.trim();
      await AuthApi.firebaseAuth.currentUser!.updateDisplayName(name);
      final email = AuthApi.firebaseAuth.currentUser!.email!;
      final photoUrl = await AuthApi.getProfilePic();
      final role = selectedRole.value.toString().split('.').last;
      final uid = AuthApi.firebaseAuth.currentUser!.uid;

      final userData = UserData(
          name: nameEditingController.value.text.trim(),
          email: email,
          photoUrl: photoUrl,
          dob: dob.value,
          role: role,
          publicId: "",
          uid: uid,
          privateId: '');

      await AuthApi.firestore
          .collection("userData")
          .doc(uid)
          .set(userData.toMap())
          .then((value) {
        scrollController.update((val) {
          val!.animateTo(Get.size.longestSide / 1.25,
              duration: const Duration(milliseconds: 500),
              curve: Curves.decelerate);
        });
      });
    }

    isLoading(false);
    update();
    scrollController.update((val) {
      val!.animateTo((Get.size.longestSide / 1.25) * 2,
          duration: const Duration(milliseconds: 500),
          curve: Curves.decelerate);
    });
  }
}
