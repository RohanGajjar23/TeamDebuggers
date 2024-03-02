import 'package:eventapp/firebase_options.dart';
import 'package:eventapp/pages/home/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:eventapp/pages/auth/auth_screen.dart';
import 'package:eventapp/theme/color_pallet.dart';
import 'package:get/get.dart';

import 'pages/auth/components/msg_box.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: CustomThemes.lightTheme,
      home: const AuthScreen(),
    );
  }
}
