import 'package:cloud_firestore/cloud_firestore.dart';

enum Status { upcoming, active, ended }

enum EventType { technical, cultural, sports }

class EventModel {
  late String name;
  late String description;
  late double price;
  late int startDate;
  late int endDate;
  late String location;
  late int ticketSold;
  late Status status;
  late int totalTickets;
  late String photoUrl;
  late int id;
  late String organizer;
  late EventType eventType;

  EventModel(
      {required this.name,
      required this.description,
      required this.price,
      required this.startDate,
      required this.endDate,
      required this.location,
      required this.ticketSold,
      required this.status,
      required this.totalTickets,
      required this.photoUrl,
      required this.organizer,
      required this.id,
      required this.eventType});

  static Future<void> storeEventData(EventModel event) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Events').get();
    int collectionLength = querySnapshot.docs.length;
    var eventDoc = FirebaseFirestore.instance
        .collection('Events')
        .doc(event.id.toString());
    await eventDoc.set({
      'name': event.name,
      'id': collectionLength,
      'description': event.description,
      'price': event.price,
      'startDate': event.startDate,
      'endDate': event.endDate,
      'location': event.location,
      'ticketSold': event.ticketSold,
      'status': event.status.index, // Storing enum index
      'totalTickets': event.totalTickets,
      'photoUrl': event.photoUrl,
      'organizer': event.organizer,
      'eventType': event.eventType.index, // Storing enum index
    });
  }

  //map to Model
  EventModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    description = map['description'];
    price = map['price'].abs().toDouble();
    startDate = map['startDate'];
    endDate = map['endDate'];
    location = map['location'];
    ticketSold = map['ticketSold'];
    status = map['status'] == "upcoming"
        ? Status.upcoming
        : map['status'] == "active"
            ? Status.active
            : Status.ended;
    totalTickets = map['totalTickets'];
    photoUrl = map['photoUrl'];
    id = map['id'] ?? 0;
    organizer = map['organizer'];
    eventType = map['eventType'] == "technical"
        ? EventType.technical
        : map['eventType'] == "cultural"
            ? EventType.cultural
            : EventType.sports;
  }

  //Model to map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'startDate': startDate,
      'endDate': endDate,
      'location': location,
      'ticketSold': ticketSold,
      'status': status.toString().split('.').last,
      'totalTickets': totalTickets,
      'photoUrl': photoUrl,
      'id': id,
      'organizer': organizer,
      'eventType': eventType.toString().split('.').last,
    };
  }
}
