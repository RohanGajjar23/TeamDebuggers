import 'package:eventapp/controller/home_controller.dart';
import 'package:eventapp/pages/event_details/components/slider_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuantityButton extends StatefulWidget {
  const QuantityButton({super.key});

  @override
  State<QuantityButton> createState() => _QuantityButtonState();
}

class _QuantityButtonState extends State<QuantityButton> {
  final HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => controller.decrementQuantity(),
          icon: const Icon(Icons.remove),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white24,
              fixedSize:
                  Size(Get.size.longestSide / 15, Get.size.longestSide / 17),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      topLeft: Radius.circular(30)))),
        ),
        const SliderTextWidget(),
        IconButton(
          onPressed: () => controller.incrementQuantity(),
          icon: const Icon(Icons.add),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white24,
              fixedSize:
                  Size(Get.size.longestSide / 15, Get.size.longestSide / 17),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      topRight: Radius.circular(30)))),
        )
      ],
    );
  }
}
