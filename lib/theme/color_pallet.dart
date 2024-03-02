import 'package:flutter/material.dart';

class CustomThemes {
  // static final ThemeData lightTheme = ThemeData.dark().copyWith(
  //     colorScheme: ColorScheme.dark(
  //   tertiary: Color.fromARGB(255, 0, 0, 0),
  //   primary: Color.fromARGB(255, 66, 0, 57),
  //   onPrimary: Color.fromARGB(255, 93, 0, 80),
  //   // onPrimary: Color.fromARGB(255, 131, 33, 97),
  //   secondary: Color.fromARGB(255, 218, 65, 103),
  //   // background: Color.fromARGB(255, 240, 239, 244),
  //   background: Color.fromARGB(255, 255, 236, 252),
  // ));
  // static final ThemeData lightTheme = ThemeData.dark().copyWith(
  //     colorScheme: ColorScheme.dark(
  //         background: Color.fromARGB(255, 13, 27, 42),
  //         primary: Color.fromARGB(255, 22, 41, 67),
  //         // primaryContainer: Color.fromARGB(255, 27, 38, 59),
  //         onPrimary: Color.fromARGB(255, 65, 90, 119),
  //         secondary: Color.fromARGB(255, 119, 141, 169),
  //         tertiary: Color.fromARGB(255, 224, 225, 221)));

  static final ThemeData lightTheme = ThemeData.dark().copyWith(
      colorScheme: ColorScheme.dark(
          background: Color.fromARGB(255, 0, 0, 0),
          // primary: Colors.grey,
          // primaryContainer: Color.fromARGB(255, 27, 38, 59),
          onPrimary: Color.fromARGB(255, 46, 46, 46),
          primaryContainer: Color.fromARGB(255, 247, 133, 26),
          secondary: Color.fromARGB(255, 53, 26, 87),
          tertiary: Color.fromARGB(255, 255, 255, 255)));
}
