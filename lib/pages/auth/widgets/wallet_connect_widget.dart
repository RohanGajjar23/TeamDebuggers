import 'package:eventapp/pages/auth/widgets/TextInputdecoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/auth_screen_controller.dart';

class WalletConnectWidget extends StatefulWidget {
  const WalletConnectWidget({super.key});

  @override
  State<WalletConnectWidget> createState() => _WalletConnectWidgetState();
}

class _WalletConnectWidgetState extends State<WalletConnectWidget> {
  final AuthScreenController controller = Get.find<AuthScreenController>();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: Get.size.longestSide / 15),
            child: Container(
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
                      "Connect Your Wallet",
                      style: GoogleFonts.varelaRound(
                          textStyle: TextStyle(
                              color: Get.theme.colorScheme.tertiary,
                              fontWeight: FontWeight.w400,
                              fontSize: Get.size.shortestSide / 18)),
                    ),
                    SizedBox(height: Get.size.longestSide / 30),
                    SizedBox(
                      height: Get.size.longestSide / 1.75,
                      width: Get.size.longestSide / 3,
                      // color: Colors.greenAccent,
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            SizedBox(height: Get.size.longestSide / 40),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your Public Address';
                                }
                                return null;
                              },
                              obscureText: controller.showPubKey.value,
                              controller: controller.pubEditingController.value,
                              decoration: TextFieldDeco.decoration(
                                      "Enter Your Public Key")
                                  .copyWith(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.showPubKey(
                                        !controller.showPubKey.value);
                                    controller.update();
                                  },
                                  icon: Icon(controller.showPubKey.value
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility),
                                ),
                              ),
                            ),
                            SizedBox(height: Get.size.longestSide / 40),
                            TextFormField(
                              controller: controller.priEditingController.value,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your Private Address';
                                }
                                return null;
                              },
                              obscureText: controller.showPriKey.value,
                              decoration: TextFieldDeco.decoration(
                                      "Enter Your Private Key")
                                  .copyWith(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.showPriKey(
                                        !controller.showPriKey.value);
                                    controller.update();
                                  },
                                  icon: Icon(controller.showPriKey.value
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility),
                                ),
                              ),
                            ),
                            SizedBox(height: Get.size.longestSide / 18),
                            ElevatedButton(
                              onPressed: () {
                                final isValid =
                                    _formkey.currentState!.validate();
                                if (!isValid) {
                                  return;
                                }
                                FocusScope.of(Get.context!).unfocus();
                                _formkey.currentState!.save();
                                controller.updateProfileKeys();
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 10,
                                fixedSize: Size(Get.size.shortestSide / 1.5,
                                    Get.size.longestSide / 17),
                                foregroundColor: Colors.white,
                                backgroundColor: Get
                                    .theme.colorScheme.background
                                    .withOpacity(0.8),
                              ),
                              child: const Text("Get Started"),
                            ),
                            SizedBox(height: Get.size.longestSide / 50),
                            Text(
                              "OR",
                              style: GoogleFonts.varelaRound(
                                  textStyle: TextStyle(
                                      color: Get.theme.colorScheme.tertiary,
                                      fontWeight: FontWeight.w400,
                                      fontSize: Get.size.shortestSide / 18)),
                            ),
                            SizedBox(height: Get.size.longestSide / 50),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: Get.size.longestSide / 15,
                                width: Get.size.shortestSide / 1.5,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.size.shortestSide / 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: .4, color: Colors.white),
                                  color: Get.theme.colorScheme.tertiary
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Image.asset(
                                  'assets/images/Metamask-logo.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(height: Get.size.longestSide / 40),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
