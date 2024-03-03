import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTitleCategory extends StatelessWidget {
  const CustomTitleCategory({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Get.theme.textTheme.bodyLarge!.copyWith(
                fontSize: 20,
                color: Get.theme.colorScheme.tertiary,
                fontWeight: FontWeight.bold),
          ),
          const Icon(Icons.arrow_forward_ios_rounded)
        ],
      ),
    );
  }
}
