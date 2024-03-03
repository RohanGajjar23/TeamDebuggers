import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventapp/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../../event_details/event_details.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event});
  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => EventDetails(event: event),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 500)),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 4,
        surfaceTintColor: Colors.black,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: event.photoUrl,
                      height: Get.size.longestSide / 5,
                      width: Get.size.shortestSide / 1.5,
                      alignment: Alignment.center,
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Image.asset(
                        "assets/images/event1.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black54,
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      event.name,
                      style: const TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: Get.size.width / 1.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.schedule,
                          color: Get.theme.colorScheme.primaryContainer),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        "${DateTime.fromMillisecondsSinceEpoch(event.startDate).hour} hr",
                        style: Get.theme.textTheme.bodyLarge!.copyWith(
                            fontSize: 15,
                            color: Get.theme.colorScheme.tertiary,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_city_rounded,
                        color: Get.theme.colorScheme.primaryContainer,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        event.location,
                        style: Get.theme.textTheme.bodyLarge!.copyWith(
                            fontSize: 15,
                            color: Get.theme.colorScheme.tertiary,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.airplane_ticket_outlined,
                          color: Get.theme.colorScheme.primaryContainer),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        (event.totalTickets - event.ticketSold).toString(),
                        style: Get.theme.textTheme.bodyLarge!.copyWith(
                            fontSize: 15,
                            color: Get.theme.colorScheme.tertiary,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.size.longestSide / 90,
            ),
          ],
        ),
      ),
    );
  }
}
