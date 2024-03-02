import 'package:eventapp/pages/auth/widgets/TextInputdecoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/auth_screen_controller.dart';

class ProfileUpdateWidget extends StatefulWidget {
  const ProfileUpdateWidget({super.key});

  @override
  State<ProfileUpdateWidget> createState() => _ProfileUpdateWidgetState();
}

class _ProfileUpdateWidgetState extends State<ProfileUpdateWidget> {
  final AuthScreenController controller = Get.find<AuthScreenController>();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (context) {
          return Container(
            width: Get.size.shortestSide / 1.2,
            decoration: BoxDecoration(
              border: Border.all(width: .4, color: Colors.white),
              color: Get.theme.colorScheme.tertiary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  SizedBox(height: Get.size.longestSide / 18),
                  Text(
                    "Create your Profile",
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
                    child: Column(
                      children: [
                        controller.showGoogleImage(),
                        SizedBox(height: Get.size.longestSide / 40),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Name';
                            }
                            return null;
                          },
                          controller: controller.nameEditingController.value,
                          decoration: TextFieldDeco.decoration("Enter Name"),
                        ),
                        SizedBox(height: Get.size.longestSide / 40),
                        TextFormField(
                            controller: controller.dateEditingController.value,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your birthdate';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Select your birthdate',
                              labelStyle: Get.theme.textTheme.bodyMedium!
                                  .copyWith(
                                      color: Colors.white,
                                      fontSize: Get.size.shortestSide / 30),
                              suffixIcon: const Icon(Icons.calendar_today),
                            ),
                            readOnly: true, // To prevent manual editing
                            onTap: () => controller.selectDate(Get.context!)),
                        SizedBox(height: Get.size.longestSide / 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            // Organizer option
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Organizer'),
                                Radio<UserRole>(
                                  value: UserRole.organizer,
                                  groupValue: controller.selectedRole.value,
                                  onChanged: (UserRole? value) {
                                    controller.selectedRole(value!);
                                    controller.update();
                                  },
                                ),
                              ],
                            ),
                            // User option
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('User'),
                                Radio<UserRole>(
                                  value: UserRole.user,
                                  groupValue: controller.selectedRole.value,
                                  onChanged: (UserRole? value) {
                                    controller.selectedRole(value!);
                                    controller.update();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: Get.size.longestSide / 40),
                        ElevatedButton(
                          onPressed: () {
                            final isValid = _formkey.currentState!.validate();
                            if (!isValid) {
                              return;
                            }
                            FocusScope.of(Get.context!).unfocus();
                            _formkey.currentState!.save();
                            controller.updateProfile();
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            fixedSize: Size(Get.size.shortestSide / 1.5,
                                Get.size.longestSide / 17),
                            foregroundColor: Colors.white,
                            backgroundColor: Get.theme.colorScheme.background
                                .withOpacity(0.8),
                          ),
                          child: const Text("Next"),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
