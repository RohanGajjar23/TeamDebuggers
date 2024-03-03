import 'package:eventapp/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
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
                                child: Image.asset('assets/images/google.png'),
                              ),
                              SizedBox(
                                height: Get.size.longestSide / 70,
                              ),
                              Center(
                                child: Text(
                                  "Harshita Bhamare",
                                  style: TextStyle(
                                      color: Get.theme.colorScheme.tertiary,
                                      fontSize: Get.size.longestSide / 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: Get.size.longestSide / 70,
                              ),
                              ListTile(
                                title: Container(),
                                subtitle: Text(
                                  "harshitabhamare16@gmail.com",
                                  style: TextStyle(
                                    color: Get.theme.colorScheme.tertiary,
                                    fontSize: Get.size.longestSide / 48,
                                  ),
                                ),
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
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(bottom: 4.64),
                                  child: Text(
                                    "16-11-2003",
                                    style: TextStyle(
                                      color: Get.theme.colorScheme.tertiary,
                                      fontSize: Get.size.longestSide / 48,
                                    ),
                                  ),
                                ),
                                leading: Text(
                                  "Birth Date :",
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
                                subtitle: Text(
                                  "skedfhgskihfage bwiasfhwoiafhlaDNilaqwuewsatfw brgiqWEYDQoweudNWDHx",
                                  style: TextStyle(
                                    color: Get.theme.colorScheme.tertiary,
                                    fontSize: Get.size.longestSide / 48,
                                  ),
                                ),
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
