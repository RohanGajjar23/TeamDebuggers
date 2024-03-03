import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventapp/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/authapi/auth_api.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late HomeController controller;
  Widget getUserName() {
    return FutureBuilder(
        future: AuthApi.getUserName(),
        builder: (context, snapshot) {
          if (snapshot.hasError ||
              snapshot.data == null ||
              snapshot.data == "") {
            return Text(
              "Fetching User...",
              style: TextStyle(
                  color: Get.theme.colorScheme.tertiary,
                  fontSize: Get.size.longestSide / 25,
                  fontWeight: FontWeight.bold),
            );
          }
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Text(
                  snapshot.data!,
                  style: TextStyle(
                      color: Get.theme.colorScheme.tertiary,
                      fontSize: Get.size.longestSide / 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        });
  }

  Widget getEmailID() {
    return FutureBuilder(
        future: AuthApi.getUserEmail(),
        builder: (context, snapshot) {
          if (snapshot.hasError ||
              snapshot.data == null ||
              snapshot.data == "") {
            return Text(
              "Fetching User E-mail...",
              style: TextStyle(
                color: Get.theme.colorScheme.tertiary,
                fontSize: Get.size.longestSide / 48,
              ),
            );
          }
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Text(
                  snapshot.data!,
                  style: TextStyle(
                    color: Get.theme.colorScheme.tertiary,
                    fontSize: Get.size.longestSide / 48,
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget getBalance(String targetAddress) {
    // Add a parameter for targetAddress
    return FutureBuilder<double>(
      // Specify the type of data this FutureBuilder expects
      future: controller.blockChain.getWalletBalance(
          targetAddress), // Corrected to pass the targetAddress
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            "Error Fetching Balance",
            style: TextStyle(
              color: Get.theme.colorScheme.tertiary,
              fontSize: Get.size.longestSide / 48,
            ),
          );
        } else if (!snapshot.hasData) {
          // Corrected condition to check for no data
          return Text(
            "Fetching User Balance...",
            style: TextStyle(
              color: Get.theme.colorScheme.tertiary,
              fontSize: Get.size.longestSide / 48,
            ),
          );
        } else {
          // Formatting the balance to a string with 2 decimal places
          String balance = snapshot.data!.toStringAsFixed(2);
          return ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Text(
              "$balance ETH", // Displaying the balance with ETH suffix
              style: TextStyle(
                color: Get.theme.colorScheme.tertiary,
                fontSize: Get.size.longestSide / 48,
              ),
            ),
          );
        }
      },
    );
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

  @override
  Widget build(BuildContext context) {
    controller = Get.find<HomeController>();
    return GetBuilder(
        init: controller,
        builder: (context) {
          return Stack(
            children: [
              Scaffold(
                  body: Stack(
                children: [
                  Container(
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
                  ),
                  Column(
                    children: [
                      // SizedBox(height: Get.size.longestSide / 30),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          alignment: Alignment.center,
                          // height: Get.size.longestSide / 1.5,
                          // color: Colors.amber,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: Get.size.longestSide / 70,
                              ),
                              Container(
                                height: Get.size.longestSide / 6,
                                width: Get.size.shortestSide / 1.9,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(1000)),
                                  // color: Colors.white,
                                ),
                                child: Center(child: showGoogleImage()),
                              ),
                              SizedBox(
                                height: Get.size.longestSide / 70,
                              ),
                              Center(
                                child: getUserName(),
                              ),
                              SizedBox(
                                height: Get.size.longestSide / 70,
                              ),
                              ListTile(
                                title: Container(),
                                subtitle:
                                    getEmailID().paddingOnly(bottom: 4.65),
                                leading: Text(
                                  "E-Mail :",
                                  style: TextStyle(
                                    color: Get.theme.colorScheme.tertiary,
                                    fontSize: Get.size.longestSide / 48,
                                  ),
                                ), // You can replace this with an appropriate icon
                              ),
                              SizedBox(
                                height: Get.size.longestSide / 70,
                              ),
                              ListTile(
                                title: Container(),
                                subtitle: Text(
                                  controller.blockChain.myAddress,
                                  style: TextStyle(
                                    color: Get.theme.colorScheme.tertiary,
                                    fontSize: Get.size.longestSide / 48,
                                  ),
                                ),
                                leading: Text(
                                  "Wallet ID :",
                                  style: TextStyle(
                                    color: Get.theme.colorScheme.tertiary,
                                    fontSize: Get.size.longestSide / 48,
                                  ),
                                ), // You can replace this with an appropriate icon
                              ),
                              ListTile(
                                title: Container(),
                                subtitle:
                                    getBalance(controller.blockChain.myAddress)
                                        .paddingOnly(bottom: 4.65),
                                leading: Text(
                                  "ETH Coins :",
                                  style: TextStyle(
                                    color: Get.theme.colorScheme.tertiary,
                                    fontSize: Get.size.longestSide / 48,
                                  ),
                                ), // You can replace this with an appropriate icon
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )),
            ],
          );
        });
  }
}
