import 'package:eventapp/pages/home/events/widgets/custom_category_widget.dart';
import 'package:eventapp/pages/home/events/widgets/events_list_views.dart';
import 'package:eventapp/services/authapi/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/event_model.dart';

class Events extends StatelessWidget {
  const Events({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthApi.firestore.collection("Events").snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasData && snapshot.data != null) {
                final events = snapshot.data!.docs
                    .map((e) => EventModel.fromMap(e.data()))
                    .toList();
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
                        events: events
                            .where((element) =>
                                element.eventType == EventType.technical)
                            .toList(),
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
                        events: events
                            .where((element) =>
                                element.eventType == EventType.cultural)
                            .toList(),
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
                        events: events
                            .where((element) =>
                                element.eventType == EventType.sports)
                            .toList(),
                      ),
                    ],
                  ),
                );
              }
              return const Center(
                child: Text("No data"),
              );
          }
        });
  }
}
