import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventapp/controller/home_controller.dart';
import 'package:eventapp/model/event_model.dart';
import 'package:eventapp/pages/auth/widgets/TextInputdecoration.dart';
import 'package:eventapp/services/authapi/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class OrganizeEvents extends StatefulWidget {
  OrganizeEvents({super.key});

  @override
  State<OrganizeEvents> createState() => _OrganizeEventsState();
}

class _OrganizeEventsState extends State<OrganizeEvents> {
  final formKey = GlobalKey();

  late HomeController homeController;

  TextEditingController eventNameController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController locationController = TextEditingController();

  TextEditingController startDateController = TextEditingController();

  TextEditingController endDateController = TextEditingController();

  TextEditingController totalTicketsController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  Future<List<DateTime>?> showCustomDateTimeRangePicker(
      BuildContext context) async {
    List<DateTime>? selectedDateTimeRange = await showOmniDateTimeRangePicker(
      context: context,
      startInitialDate: DateTime.now(),
      startFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      startLastDate: DateTime.now().add(const Duration(days: 3652)),
      endInitialDate: DateTime.now(),
      endFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      endLastDate: DateTime.now().add(const Duration(days: 3652)),
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      isForce2Digits: true,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(maxWidth: 350, maxHeight: 650),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
            opacity: anim1.drive(Tween(begin: 0.0, end: 1.0)), child: child);
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      selectableDayPredicate: (dateTime) => dateTime != DateTime(2023, 2, 25),
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          // Define other text styles here as needed
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
          // You may want to customize other text styles like subtitle1, headline1, etc.
        ),
        // Ensure other components like buttons also match your theme
        colorScheme: ColorScheme.dark(
          primary: Colors.deepPurple,
          onPrimary: Colors.white, // For text on buttons
        ),
        dialogBackgroundColor:
            Colors.grey[900], // Adjust the picker's background color if needed
      ),
    );
    return selectedDateTimeRange;
  }

  Future<Map<String, int>?> getDateTimeRangeInMilliseconds(
      BuildContext context) async {
    // First, we call the custom date time range picker to get the start and end dates.
    List<DateTime>? dateTimeRange =
        await showCustomDateTimeRangePicker(context);

    if (dateTimeRange != null && dateTimeRange.length == 2) {
      // If the dateTimeRange is not null and contains exactly two dates,
      // we proceed to convert them into milliseconds.
      DateTime startDate = dateTimeRange[0];
      DateTime endDate = dateTimeRange[1];

      // Convert both dates to milliseconds.
      int startInMilliseconds = startDate.millisecondsSinceEpoch;
      int endInMilliseconds = endDate.millisecondsSinceEpoch;

      // Return a map containing the start and end dates in milliseconds.
      return {
        'start': startInMilliseconds,
        'end': endInMilliseconds,
      };
    } else {
      // Return null if the date range picker did not return a valid range.
      return null;
    }
  }

  Future<void> CreateEvent() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Events').get();
    int collectionLength = querySnapshot.docs.length;
    Map<String, int>? dateRangeInMilliseconds =
        await getDateTimeRangeInMilliseconds(context);
    String userName = await AuthApi.getUserName();
    try {
      EventModel eventModel = EventModel(
          name: eventNameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          startDate: dateRangeInMilliseconds!['start']!,
          endDate: dateRangeInMilliseconds['end']!,
          location: locationController.text,
          ticketSold: 0,
          status: Status.upcoming,
          totalTickets: int.parse(totalTicketsController.text),
          photoUrl: "",
          organizer: userName,
          id: collectionLength,
          eventType: EventType.technical);
      homeController.blockChain.createAndVerifyEvent(
          eventModel.name,
          eventModel.startDate.toString(),
          eventModel.price,
          eventModel.totalTickets,
          eventModel.status,
          eventModel);
    } catch (e) {
      log("Error : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    homeController = Get.find<HomeController>();
    return GetBuilder(
      init: homeController,
      builder: (controller) {
        return SizedBox(
            width: Get.size.width / 1,
            height: Get.size.height / 1.25,
            // color: Colors.greenAccent,
            child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(children: [
                    Text(
                      "Create your Event",
                      style: Get.theme.textTheme.bodyLarge!
                          .copyWith(color: Colors.white, fontSize: 30),
                    ),
                    SizedBox(height: Get.size.longestSide / 40),
                    TextField(
                      style: Get.theme.textTheme.bodyLarge!
                          .copyWith(color: Colors.white),
                      controller: eventNameController,
                      decoration: TextFieldDeco.decoration("Event Name"),
                    ),
                    SizedBox(height: Get.size.longestSide / 40),
                    TextField(
                      style: Get.theme.textTheme.bodyLarge!
                          .copyWith(color: Colors.white),
                      controller: descriptionController,
                      maxLines: null,
                      keyboardType: TextInputType.streetAddress,
                      decoration: TextFieldDeco.decoration("Description"),
                    ),
                    SizedBox(height: Get.size.longestSide / 40),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            // color: Colors.green,
                            child: TextField(
                              style: Get.theme.textTheme.bodyLarge!
                                  .copyWith(color: Colors.white),
                              controller: locationController,
                              keyboardType: TextInputType.streetAddress,
                              decoration: TextFieldDeco.decoration("Location"),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.size.shortestSide / 50,
                        ),
                        Expanded(
                          child: Container(
                            // color: Colors.red,
                            child: TextField(
                              style: Get.theme.textTheme.bodyLarge!
                                  .copyWith(color: Colors.white),
                              decoration: TextFieldDeco.decoration("Image"),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: Get.size.longestSide / 40),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              // color: Colors.green,
                              child: ElevatedButton(
                            onPressed: () async {
                              Map<String, int>? dateRangeInMilliseconds =
                                  await getDateTimeRangeInMilliseconds(context);
                              if (dateRangeInMilliseconds != null) {
                                print(
                                    "Start Date in Milliseconds: ${dateRangeInMilliseconds['start']}");
                                print(
                                    "End Date in Milliseconds: ${dateRangeInMilliseconds['end']}");
                                // Use the milliseconds as needed
                              } else {
                                print(
                                    "Date range selection was cancelled or invalid.");
                              }
                            },
                            child: const Text("Pick Start and End Date"),
                          )),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.size.longestSide / 40),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            // color: Colors.green,
                            child: TextField(
                              style: Get.theme.textTheme.bodyLarge!
                                  .copyWith(color: Colors.white),
                              controller: totalTicketsController,
                              keyboardType: TextInputType.number,
                              decoration:
                                  TextFieldDeco.decoration("Total Tickets"),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.size.shortestSide / 50,
                        ),
                        Expanded(
                          child: Container(
                            // color: Colors.red,
                            child: TextField(
                              style: Get.theme.textTheme.bodyLarge!
                                  .copyWith(color: Colors.white),
                              controller: priceController,
                              keyboardType: TextInputType.number,
                              decoration: TextFieldDeco.decoration("Price"),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: Get.size.longestSide / 20),
                    ElevatedButton(
                      onPressed: () {
                        CreateEvent();
                        // final isValid = formKey.currentState!.validate();
                        // if (!isValid) {
                        //   return;
                        // }
                        // FocusScope.of(Get.context!).unfocus();
                        // formKey.currentState!.save();
                        // controller.updateProfile();
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        fixedSize: Size(Get.size.shortestSide / 1.5,
                            Get.size.longestSide / 17),
                        foregroundColor: Colors.white,
                        backgroundColor:
                            Get.theme.colorScheme.background.withOpacity(0.8),
                      ),
                      child: const Text("Organize your new Event..."),
                    )
                  ])),
            ));
      },
    );
  }
}
