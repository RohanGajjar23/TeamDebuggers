import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
          appBar: AppBar(
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
              )),
          bottomNavigationBar: Container(
            color: Theme.of(context).colorScheme.secondary.withOpacity(.87),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 13, vertical: 7),
              child: GNav(
                  backgroundColor:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                  activeColor: Theme.of(context).colorScheme.primaryContainer,
                  tabBackgroundColor: Theme.of(context).colorScheme.background,
                  gap: 5,
                  padding: EdgeInsets.all(13),
                  tabs: [
                    GButton(
                        icon: Icons.home,
                        iconColor: Theme.of(context).colorScheme.tertiary,
                        text: 'Home',
                        textStyle: GoogleFonts.varelaRound(
                            textStyle: TextStyle(
                          letterSpacing: 1,
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ))),
                    GButton(
                        icon: Icons.favorite,
                        iconColor: Theme.of(context).colorScheme.tertiary,
                        text: 'Likes',
                        textStyle: GoogleFonts.varelaRound(
                            textStyle: TextStyle(
                          letterSpacing: 1,
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ))),
                    GButton(
                        icon: Icons.search,
                        iconColor: Theme.of(context).colorScheme.tertiary,
                        text: 'Search',
                        textStyle: GoogleFonts.varelaRound(
                            textStyle: TextStyle(
                          letterSpacing: 1,
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ))),
                    GButton(
                        icon: Icons.person,
                        iconColor: Theme.of(context).colorScheme.tertiary,
                        text: 'Profile',
                        textStyle: GoogleFonts.varelaRound(
                            textStyle: TextStyle(
                          letterSpacing: 1,
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ))),
                  ]),
            ),
          )),
    ]);
  }
}
