import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:eventapp/contoller/auth_screen_controller.dart';
import 'package:eventapp/pages/home/widgets/TextInputdecoration.dart';
import 'package:eventapp/services/authapi/auth_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

enum UserRole { organizer, user }

class _AuthScreenState extends State<AuthScreen> {
  UserRole? selectedRole = UserRole.user;
  final scrollController = ScrollController();
  TextEditingController _controller = TextEditingController();
  final AuthScreenController controller = Get.put(AuthScreenController());
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      // This ensures the user can't pick a future date as their birthdate.
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _controller.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: Get.size.longestSide / 5),
                  SizedBox(width: Get.size.width / 1),
                  Container(
                    height: Get.size.longestSide / 1.6,
                    width: Get.size.shortestSide / 1.2,
                    decoration: BoxDecoration(
                      border: Border.all(width: .4, color: Colors.white),
                      color: Get.theme.colorScheme.tertiary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
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
                                  color: Get.theme.colorScheme.tertiary
                                      .withOpacity(0.8),
                                  fontWeight: FontWeight.w100,
                                  fontSize: Get.size.shortestSide / 27)),
                        ),
                        SizedBox(height: Get.size.longestSide / 7),
                        InkWell(
                          onTap: () async {
                            UserCredential? user =
                                await AuthApi.signInWithGoogle().then(
                              (value) {
                                scrollController.animateTo(
                                    Get.size.longestSide / 1.25,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.decelerate);
                              },
                            );
                            if (user != null) {
                              log(await AuthApi.getUserName());
                              log(await AuthApi.getUserEmail());
                              log(await AuthApi.getProfilePic());
                              // setState(() {});
                            }
                          },
                          child: Container(
                            height: Get.size.longestSide / 13,
                            width: Get.size.shortestSide / 2,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: .4, color: Colors.white),
                              color: Get.theme.colorScheme.tertiary
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(11),
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: Get.size.shortestSide / 18),
                                SizedBox(
                                    height: Get.size.shortestSide / 10,
                                    child: Image.asset(
                                        'assets/images/google.png')),
                                SizedBox(width: Get.size.shortestSide / 25),
                                SizedBox(
                                  child: Text(
                                    'Google',
                                    style: GoogleFonts.varelaRound(
                                        textStyle: TextStyle(
                                            color: Get
                                                .theme.colorScheme.tertiary
                                                .withOpacity(0.8),
                                            fontWeight: FontWeight.w500,
                                            fontSize:
                                                Get.size.shortestSide / 15)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: Get.size.longestSide / 25),
                        InkWell(
                          onTap: () async {
                            UserCredential? user =
                                await AuthApi.signInWithGoogle();
                            if (user != null) {
                              log(await AuthApi.getUserName());
                              log(await AuthApi.getUserEmail());
                              log(await AuthApi.getProfilePic());
                              // setState(() {});
                            }
                          },
                          child: Container(
                            height: Get.size.longestSide / 13,
                            width: Get.size.shortestSide / 2,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: .4, color: Colors.white),
                              color: Get.theme.colorScheme.tertiary
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(11),
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: Get.size.shortestSide / 35),
                                SizedBox(
                                    height: Get.size.shortestSide / 7,
                                    child:
                                        Image.asset('assets/images/git.png')),
                                SizedBox(width: Get.size.shortestSide / 30),
                                SizedBox(
                                  child: Text(
                                    'GitHub',
                                    style: GoogleFonts.varelaRound(
                                        textStyle: TextStyle(
                                            color: Get
                                                .theme.colorScheme.tertiary
                                                .withOpacity(0.8),
                                            fontWeight: FontWeight.w500,
                                            fontSize:
                                                Get.size.shortestSide / 15)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.size.longestSide / 7),
                  Container(
                    height: Get.size.longestSide / 1.25,
                    width: Get.size.shortestSide / 1.2,
                    decoration: BoxDecoration(
                      border: Border.all(width: .4, color: Colors.white),
                      color: Get.theme.colorScheme.tertiary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
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
                        SizedBox(height: Get.size.longestSide / 25),
                        Container(
                          // height: Get.size.longestSide / 3,
                          width: Get.size.shortestSide / 1.7,
                          decoration: BoxDecoration(
                            color: Get.theme.colorScheme.onPrimary,
                            borderRadius: BorderRadius.circular(11),
                          ),
                          // child: Image.asset(
                          //   'assets/images/logo.png',
                          //   // fit: BoxFit.cover,
                          // ),
                        ),
                        SizedBox(height: Get.size.longestSide / 20),
                        Container(
                          height: Get.size.longestSide / 1.75,
                          width: Get.size.longestSide / 3,
                          // color: Colors.greenAccent,
                          child: Column(
                            children: [
                              TextField(
                                  decoration:
                                      TextFieldDeco.decoration("Enter Name")),
                              SizedBox(height: Get.size.longestSide / 40),
                              TextField(
                                  keyboardType: TextInputType.phone,
                                  decoration: TextFieldDeco.decoration(
                                      "Enter Phone Number")),
                              SizedBox(height: Get.size.longestSide / 40),
                              TextFormField(
                                controller: _controller,
                                decoration: InputDecoration(
                                  labelText: 'Select your birthdate',
                                  suffixIcon: Icon(Icons.calendar_today),
                                ),
                                readOnly: true, // To prevent manual editing
                                onTap: () => _selectDate(context),
                              ),
                              SizedBox(height: Get.size.longestSide / 40),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  // Organizer option
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('Organizer'),
                                      Radio<UserRole>(
                                        value: UserRole.organizer,
                                        groupValue: selectedRole,
                                        onChanged: (UserRole? value) {
                                          setState(() {
                                            selectedRole = value!;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  // User option
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('User'),
                                      Radio<UserRole>(
                                        value: UserRole.user,
                                        groupValue: selectedRole,
                                        onChanged: (UserRole? value) {
                                          setState(() {
                                            selectedRole = value!;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: Get.size.longestSide / 7),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
