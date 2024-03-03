import 'package:eventapp/controller/auth_screen_controller.dart';
import 'package:eventapp/model/user_data.dart';
import 'package:eventapp/pages/auth/auth_screen.dart';
import 'package:eventapp/pages/home/dashboard.dart';
import 'package:eventapp/services/authapi/auth_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final controller = Get.put(AuthScreenController());

    return StreamBuilder<User?>(
      stream: AuthApi.firebaseAuth.authStateChanges(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData && snapshot.data != null) {
              return FutureBuilder(
                  future: AuthApi.firestore
                      .collection("userData")
                      .doc(AuthApi.firebaseAuth.currentUser!.uid)
                      .get(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case ConnectionState.active:
                      case ConnectionState.done:
                        if (snapshot.data != null &&
                            snapshot.data!.data() != null &&
                            snapshot.data!.data()!.isNotEmpty) {
                          final data = UserData.fromMap(snapshot.data!.data()!);
                          if (data.privateId == "" || data.publicId == "") {
                            return const AuthScreen();
                          }
                          return const DashBoard();
                        }
                        return const AuthScreen();
                    }
                  });
            }

            return const AuthScreen();
        }
      },
    );
  }
}
