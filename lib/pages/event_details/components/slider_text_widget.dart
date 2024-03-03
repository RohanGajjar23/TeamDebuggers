import 'package:eventapp/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SliderTextWidget extends StatelessWidget {
  const SliderTextWidget({
    super.key,
    this.hasSign = true,
  });
  final bool hasSign;

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    return GetBuilder(
        init: controller,
        builder: (context) {
          return Container(
            color: Colors.white24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '',
                  style: Get.theme.textTheme.displayMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                ...List.generate(
                  controller.quantity.value.toInt().toString().length,
                  (index) => SliderText(
                    value: int.tryParse(controller.quantity.value
                            .toInt()
                            .toString()[index]) ??
                        10,
                  ),
                )
              ],
            ),
          );
        });
  }
}

class SliderText extends StatefulWidget {
  const SliderText({
    super.key,
    required this.value,
  });

  final int value;

  @override
  State<SliderText> createState() => _SliderTextState();
}

class _SliderTextState extends State<SliderText> {
  late final ScrollController _scrollController;
  final double _maxScrollHeight = 52;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo((_maxScrollHeight * widget.value).toDouble());
    });
  }

  @override
  void didUpdateWidget(covariant SliderText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _scrollController.animateTo(
        (_maxScrollHeight * widget.value).toDouble(),
        duration: const Duration(milliseconds: 500),
        curve: Curves.elasticOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _maxScrollHeight,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: List.generate(
            10,
            (index) => Text(
              '$index',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Get.theme.colorScheme.tertiary),
            ),
          ),
        ),
      ),
    );
  }
}
