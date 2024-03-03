import 'package:eventapp/controller/auth_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleGithubWidget extends StatelessWidget {
  const GoogleGithubWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthScreenController>();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.size.longestSide / 15),
      child: Container(
        // height: Get.size.longestSide / 30,
        // width: Get.size.shortestSide / 1.2,
        decoration: BoxDecoration(
          border: Border.all(width: .4, color: Colors.white),
          color: Get.theme.colorScheme.tertiary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Get.size.longestSide / 18),
              Text(
                "Sign in to your account",
                style: GoogleFonts.varelaRound(
                    textStyle: TextStyle(
                        color: Get.theme.colorScheme.tertiary,
                        fontWeight: FontWeight.w400,
                        fontSize: Get.size.shortestSide / 18)),
              ),
              SizedBox(height: Get.size.longestSide / 19),
              Text(
                "Let's Connect your account\nthrough your Google account\nor GitHub account",
                style: GoogleFonts.varelaRound(
                    textStyle: TextStyle(
                        color: Get.theme.colorScheme.tertiary.withOpacity(0.8),
                        fontWeight: FontWeight.w100,
                        fontSize: Get.size.shortestSide / 20)),
              ),
              SizedBox(height: Get.size.longestSide / 10),
              InkWell(
                onTap: () => controller.signInWithGoogle(),
                child: Container(
                  height: Get.size.longestSide / 15,
                  width: Get.size.shortestSide / 1.5,
                  decoration: BoxDecoration(
                    border: Border.all(width: .4, color: Colors.white),
                    color: Get.theme.colorScheme.tertiary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: Get.size.shortestSide / 10,
                          child: Image.asset('assets/images/google.png')),
                      SizedBox(width: Get.size.shortestSide / 25),
                      SizedBox(
                        child: Text(
                          'Google',
                          style: GoogleFonts.varelaRound(
                              textStyle: TextStyle(
                                  color: Get.theme.colorScheme.tertiary
                                      .withOpacity(0.8),
                                  fontWeight: FontWeight.w500,
                                  fontSize: Get.size.shortestSide / 15)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Get.size.longestSide / 25),
              InkWell(
                onTap: () => controller.signInWithGoogle(),
                child: Container(
                  height: Get.size.longestSide / 15,
                  width: Get.size.shortestSide / 1.5,
                  decoration: BoxDecoration(
                    border: Border.all(width: .4, color: Colors.white),
                    color: Get.theme.colorScheme.tertiary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: Get.size.shortestSide / 7,
                          child: Image.asset('assets/images/git.png')),
                      SizedBox(width: Get.size.shortestSide / 30),
                      SizedBox(
                        child: Text(
                          'GitHub',
                          style: GoogleFonts.varelaRound(
                              textStyle: TextStyle(
                                  color: Get.theme.colorScheme.tertiary
                                      .withOpacity(0.8),
                                  fontWeight: FontWeight.w500,
                                  fontSize: Get.size.shortestSide / 15)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
