import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventapp/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({super.key, required this.event});
  final EventModel event;

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  String formatDateFromMilliseconds(int millisecondsSinceEpoch) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
        backgroundColor: Get.theme.colorScheme.background,
      ),
      body: Stack(
        children: [
          Container(
            width: Get.size.shortestSide,
            height: Get.size.longestSide,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                radius: 0.5,
                transform: const GradientRotation(3.14 / 4),
                focal: Alignment.topRight,
                center: Alignment.topLeft,
                focalRadius: 3.4,
                colors: [
                  Get.theme.colorScheme.secondary,
                  Get.theme.colorScheme.secondary,
                  Get.theme.colorScheme.secondary,
                  Get.theme.colorScheme.background,
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    // Hero section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: Get.size.shortestSide / 2,
                          height: Get.size.shortestSide / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl: widget.event.photoUrl,
                              height: Get.size.longestSide / 5,
                              width: Get.size.shortestSide / 1.5,
                              alignment: Alignment.center,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Image.asset(
                                "assets/images/event1.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                              style: Get.theme.textTheme.bodyLarge!.copyWith(
                                  fontSize: Get.size.shortestSide / 10,
                                  fontWeight: FontWeight.w400),
                              children: [
                                TextSpan(
                                    text: "${widget.event.name}\n",
                                    style: Get.theme.textTheme.bodyLarge!
                                        .copyWith(
                                            color:
                                                Get.theme.colorScheme.tertiary,
                                            fontSize:
                                                Get.size.shortestSide / 15,
                                            fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: "Type: \n",
                                    style: Get.theme.textTheme.bodyLarge!
                                        .copyWith(
                                            color:
                                                Get.theme.colorScheme.tertiary,
                                            fontSize:
                                                Get.size.shortestSide / 30,
                                            fontWeight: FontWeight.w700)),
                                TextSpan(
                                    text:
                                        "${widget.event.eventType.toString().split('.').last} Event\n",
                                    style: Get.theme.textTheme.bodyLarge!
                                        .copyWith(
                                            color: Get.theme.colorScheme
                                                .primaryContainer,
                                            fontSize:
                                                Get.size.shortestSide / 30,
                                            fontWeight: FontWeight.w700)),
                                TextSpan(
                                    text: "status: \n",
                                    style: Get.theme.textTheme.bodyLarge!
                                        .copyWith(
                                            color:
                                                Get.theme.colorScheme.tertiary,
                                            fontSize:
                                                Get.size.shortestSide / 30,
                                            fontWeight: FontWeight.w700)),
                                TextSpan(
                                    text:
                                        "${widget.event.status.toString().split('.').last}\n",
                                    style: Get.theme.textTheme.bodyLarge!
                                        .copyWith(
                                            color: Get.theme.colorScheme
                                                .primaryContainer,
                                            fontSize:
                                                Get.size.shortestSide / 30,
                                            fontWeight: FontWeight.w500)),
                                TextSpan(
                                    text: "Event Date: \n",
                                    style: Get.theme.textTheme.bodyLarge!
                                        .copyWith(
                                            color:
                                                Get.theme.colorScheme.tertiary,
                                            fontSize:
                                                Get.size.shortestSide / 30,
                                            fontWeight: FontWeight.w700)),
                                TextSpan(
                                    text:
                                        "${formatDateFromMilliseconds(widget.event.startDate)}\n",
                                    style: Get.theme.textTheme.bodyLarge!
                                        .copyWith(
                                            color: Get.theme.colorScheme
                                                .primaryContainer,
                                            fontSize:
                                                Get.size.shortestSide / 30,
                                            fontWeight: FontWeight.w200)),
                              ]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Buttons

                    const Divider(),
                    // About the Venue
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Description of the Event',
                              style: Get.theme.textTheme.bodyLarge!.copyWith(
                                  color: Get.theme.colorScheme.tertiary,
                                  fontSize: Get.size.shortestSide / 15,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(widget.event.description,
                              style: Get.theme.textTheme.bodyLarge!.copyWith(
                                  color: Get.theme.colorScheme.tertiary,
                                  fontSize: Get.size.shortestSide / 20,
                                  fontWeight: FontWeight.w200)),
                        ],
                      ),
                    ),
                    const Divider(),
                    // Related Events
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            fixedSize: Size(Get.size.shortestSide / 3,
                                Get.size.longestSide / 25),
                            foregroundColor: Colors.white,
                            backgroundColor: Get.theme.colorScheme.background
                                .withOpacity(0.8),
                          ),
                          child: const Text('Interested'),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    fixedSize: Size(
                        Get.size.shortestSide / 3, Get.size.longestSide / 25),
                    foregroundColor: Colors.white,
                    backgroundColor:
                        Get.theme.colorScheme.background.withOpacity(0.8),
                  ),
                  child: const Text('Buy Ticket'),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Related Events',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      // List of related events would be here
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
