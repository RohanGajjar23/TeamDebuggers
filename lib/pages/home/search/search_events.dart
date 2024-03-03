import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchEvents extends StatelessWidget {
  const SearchEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: Get.size.longestSide / 55,
            crossAxisSpacing: Get.size.shortestSide / 30,
          ),
          padding: EdgeInsets.only(
              left: Get.size.shortestSide / 40,
              right: Get.size.shortestSide / 40,
              top: Get.size.shortestSide / 40),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(width: .4, color: Colors.white),
                color: Get.theme.colorScheme.tertiary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Center(
                child: Text(
                  'Item $index',
                  style: GoogleFonts.varelaRound(
                      textStyle:
                          TextStyle(fontSize: Get.size.longestSide / 40)),
                ),
              ),
            );
          },
        ));
  }
}
