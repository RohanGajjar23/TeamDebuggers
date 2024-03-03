import 'package:eventapp/pages/home/events/widgets/custom_category_widget.dart';
import 'package:eventapp/pages/home/events/widgets/events_list_views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/event_model.dart';

class Events extends StatelessWidget {
  const Events({super.key});

  @override
  Widget build(BuildContext context) {
    final List<EventModel> events = dummy;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CustomTitleCategory(title: "Technical Events"),
          const Divider(),
          SizedBox(
            height: Get.size.height / 90,
          ),
          EventsListViews(
            events: events,
          ),
          SizedBox(
            height: Get.size.height / 60,
          ),
          const CustomTitleCategory(title: "Cultural Events"),
          const Divider(),
          SizedBox(
            height: Get.size.height / 90,
          ),
          EventsListViews(
            events: events,
          ),
          SizedBox(
            height: Get.size.height / 60,
          ),
          const CustomTitleCategory(title: "Sports Events"),
          const Divider(),
          SizedBox(
            height: Get.size.height / 90,
          ),
          EventsListViews(
            events: events,
          ),
        ],
      ),
    );
  }
}
