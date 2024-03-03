import 'package:eventapp/pages/home/components/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../controller/home_controller.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GetBuilder(
          init: controller,
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  // IconbU(Icons.output_sharp)
                  // o
                ],
                centerTitle: true,
                automaticallyImplyLeading: false,
                backgroundColor: Get.theme.colorScheme.background,
                title: Text(
                  "Eventify",
                  style: GoogleFonts.varelaRound(
                    textStyle: TextStyle(
                      color: Get.theme.colorScheme.tertiary,
                      fontSize: Get.size.longestSide / 35,
                    ),
                  ),
                ),
              ),
              body: Stack(
                children: [
                  Container(
                    width: Get.size.shortestSide,
                    height: Get.size.longestSide,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        radius: 0.5,
                        transform: const GradientRotation(3.14 / 4),
                        focal: Alignment.topRight,
                        center: Alignment.topLeft,
                        focalRadius: 3.4,
                        colors: [
                          Get.theme.colorScheme.secondary,
                          Get.theme.colorScheme.secondary,
                          Get.theme.colorScheme.secondary,
                          Get.theme.colorScheme.background,
                        ],
                      ),
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 1000),
                    child: controller.pages[controller.selectedPage.value],
                  ),
                ],
              ),
              bottomNavigationBar: const CustomBottomBar(),
            );
          }),
    ]);
  }
}
