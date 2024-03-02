import 'package:flutter/material.dart';

class TextFieldDeco extends StatelessWidget {
  const TextFieldDeco({super.key});

  static InputDecoration decoration(String hintText) {
    return InputDecoration(
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white, width: 2)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white30)));
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
