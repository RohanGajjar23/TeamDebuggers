import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Get.theme.colorScheme.background,
            title: Text('Profile'),
            centerTitle: true,
          ),
          body: Container(
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
            child: Column(
              children: [
                Container(
                  height: Get.size.longestSide / 1.5,
                  color: Colors.transparent,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(),
                      ),
                      Text(
                        "Name",
                        style: TextStyle(color: Get.theme.colorScheme.tertiary),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
