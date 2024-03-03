import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../controller/home_controller.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(
      () => Container(
        color: Get.theme.colorScheme.secondary.withOpacity(.87),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
          child: GNav(
              onTabChange: (value) {
                controller.changePage(value);
              },
              selectedIndex: controller.selectedPage.value,
              backgroundColor: Get.theme.colorScheme.secondary.withOpacity(0.1),
              activeColor: Get.theme.colorScheme.primaryContainer,
              tabBackgroundColor: Get.theme.colorScheme.background,
              gap: 5,
              padding: const EdgeInsets.all(13),
              tabs: [
                GButton(
                    icon: Icons.home,
                    iconColor: Get.theme.colorScheme.tertiary,
                    text: 'Home',
                    textStyle: GoogleFonts.varelaRound(
                        textStyle: TextStyle(
                      letterSpacing: 1,
                      color: Get.theme.colorScheme.primaryContainer,
                    ))),
                GButton(
                    icon: Icons.event_note_outlined,
                    iconColor: Get.theme.colorScheme.tertiary,
                    text: 'Favourites',
                    textStyle: GoogleFonts.varelaRound(
                        textStyle: TextStyle(
                      letterSpacing: 1,
                      color: Get.theme.colorScheme.primaryContainer,
                    ))),
                GButton(
                    // onPressed: ,
                    icon: Icons.handshake_outlined,
                    iconColor: Get.theme.colorScheme.tertiary,
                    text: 'Community',
                    textStyle: GoogleFonts.varelaRound(
                        textStyle: TextStyle(
                      letterSpacing: 1,
                      color: Get.theme.colorScheme.primaryContainer,
                    ))),
                GButton(
                    // onPressed: ,
                    icon: Icons.search,
                    iconColor: Get.theme.colorScheme.tertiary,
                    text: 'Search',
                    textStyle: GoogleFonts.varelaRound(
                        textStyle: TextStyle(
                      letterSpacing: 1,
                      color: Get.theme.colorScheme.primaryContainer,
                    ))),
                GButton(
                    icon: Icons.person,
                    iconColor: Get.theme.colorScheme.tertiary,
                    text: 'Profile',
                    textStyle: GoogleFonts.varelaRound(
                        textStyle: TextStyle(
                      letterSpacing: 1,
                      color: Get.theme.colorScheme.primaryContainer,
                    ))),
              ]),
        ),
      ),
    );
  }
}
