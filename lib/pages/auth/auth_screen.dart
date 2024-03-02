import 'package:eventapp/pages/auth/widgets/google_github_wiget.dart';
import 'package:eventapp/pages/auth/widgets/profile_update_widget.dart';
import 'package:eventapp/controller/auth_screen_controller.dart';
import 'package:eventapp/pages/auth/widgets/wallet_connect_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  UserRole? selectedRole = UserRole.user;

  final AuthScreenController controller = Get.put(AuthScreenController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Scaffold(
              body: Container(
                width: Get.size.shortestSide,
                height: Get.size.longestSide,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    radius: 1.3,
                    // transform: GradientRotation(0),
                    center: Alignment.bottomCenter,
                    // begin: Alignment.topLeft,
                    // end: Alignment.bottomRight,
                    colors: [
                      // Get.theme.colorScheme.background,
                      // Get.theme.colorScheme.background,
                      Get.theme.colorScheme.secondary,
                      Get.theme.colorScheme.secondary,
                      Get.theme.colorScheme.secondary,
                      Get.theme.colorScheme.background,
                      // Get.theme.colorScheme.background,
                    ],
                  ),
                ),
                child: SingleChildScrollView(
                  controller: controller.scrollController.value,
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: Get.size.longestSide / 5),
                      const GoogleGithubWidget(),
                      SizedBox(height: Get.size.longestSide / 7),
                      const ProfileUpdateWidget(),
                      SizedBox(height: Get.size.longestSide / 7),
                      const WalletConnectWidget(),
                      SizedBox(height: Get.size.longestSide / 7),
                    ],
                  ),
                ),
              ),
            ),
            if (controller.isLoading.value)
              Container(
                width: Get.size.shortestSide,
                height: Get.size.longestSide,
                color: Colors.black54, //Get.theme.colorScheme.background,
                child: Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                      color: Get.theme.colorScheme.tertiary, size: 70),
                ),
              )
          ],
        ),
      ),
    );
  }
}
