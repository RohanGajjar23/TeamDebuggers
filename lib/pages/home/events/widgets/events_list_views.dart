import 'package:eventapp/model/event_model.dart';
import 'package:eventapp/pages/home/events/widgets/animated_scroll_view_item.dart';
import 'package:eventapp/pages/home/events/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class EventsListViews extends StatefulWidget {
  const EventsListViews({super.key, required this.events});
  final List<EventModel> events;

  @override
  State<EventsListViews> createState() => _EventsListViewsState();
}

class _EventsListViewsState extends State<EventsListViews>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.size.height / 3.5,
      child: AnimationLimiter(
        child: widget.events.isEmpty
            ? const Center(
                child: Text("No Events Right now!"),
              )
            : ListView.builder(
                cacheExtent: 0,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount: widget.events.length,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: AnimatedScrollViewItem(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: SizedBox(
                              child: EventCard(
                                event: widget.events[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
